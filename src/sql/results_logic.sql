-- ============================================================
-- MUNDIAL 2026 — LÓGICA DE RESULTADOS
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- ── 1. Asegurar columnas de resultado en la tabla matches ────
ALTER TABLE matches
  ADD COLUMN IF NOT EXISTS home_score   INTEGER DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS away_score   INTEGER DEFAULT NULL;

-- ── 2. Función: recalcular standings de un grupo ─────────────
CREATE OR REPLACE FUNCTION fn_recalculate_standings(p_group_id TEXT)
RETURNS VOID AS $$
DECLARE
  rec RECORD;
BEGIN
  -- Resetear todos los valores del grupo
  UPDATE standings SET
    played = 0, won = 0, drawn = 0, lost = 0,
    goals_for = 0, goals_against = 0, goal_diff = 0, points = 0
  WHERE group_id = p_group_id;

  -- Recorrer todos los partidos finalizados del grupo
  FOR rec IN
    SELECT home_team_id, away_team_id, home_score, away_score
    FROM matches
    WHERE group_id = p_group_id
      AND status = 'finished'
      AND home_score IS NOT NULL
      AND away_score IS NOT NULL
  LOOP
    -- Actualizar equipo local (usamos ::text para evitar errores de UUID vs INT)
    UPDATE standings SET
      played = played + 1,
      goals_for = goals_for + rec.home_score,
      goals_against = goals_against + rec.away_score,
      goal_diff = goal_diff + (rec.home_score - rec.away_score),
      won = won + CASE WHEN rec.home_score > rec.away_score THEN 1 ELSE 0 END,
      drawn = drawn + CASE WHEN rec.home_score = rec.away_score THEN 1 ELSE 0 END,
      lost = lost + CASE WHEN rec.home_score < rec.away_score THEN 1 ELSE 0 END,
      points = points + CASE
        WHEN rec.home_score > rec.away_score THEN 3
        WHEN rec.home_score = rec.away_score THEN 1
        ELSE 0
      END
    WHERE team_id::text = rec.home_team_id::text AND group_id = p_group_id;

    -- Actualizar equipo visitante
    UPDATE standings SET
      played = played + 1,
      goals_for = goals_for + rec.away_score,
      goals_against = goals_against + rec.home_score,
      goal_diff = goal_diff + (rec.away_score - rec.home_score),
      won = won + CASE WHEN rec.away_score > rec.home_score THEN 1 ELSE 0 END,
      drawn = drawn + CASE WHEN rec.away_score = rec.home_score THEN 1 ELSE 0 END,
      lost = lost + CASE WHEN rec.away_score < rec.home_score THEN 1 ELSE 0 END,
      points = points + CASE
        WHEN rec.away_score > rec.home_score THEN 3
        WHEN rec.away_score = rec.home_score THEN 1
        ELSE 0
      END
    WHERE team_id::text = rec.away_team_id::text AND group_id = p_group_id;
  END LOOP;
END;
$$ LANGUAGE plpgsql;


-- ── 3. Función: obtener el ganador de un partido ──────────────
-- Retorna: 'home', 'away', o 'draw'
CREATE OR REPLACE FUNCTION fn_get_match_winner(p_home INTEGER, p_away INTEGER)
RETURNS TEXT AS $$
BEGIN
  IF p_home > p_away THEN RETURN 'home';
  ELSIF p_away > p_home THEN RETURN 'away';
  ELSE RETURN 'draw';
  END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;


-- ── 4. Función: llamada por el trigger al actualizar partidos ─
CREATE OR REPLACE FUNCTION fn_trigger_match_update()
RETURNS TRIGGER AS $$
BEGIN
  -- Solo actuar cuando el partido se marca como 'finished'
  IF NEW.status = 'finished' AND (OLD.status IS DISTINCT FROM 'finished' OR OLD.home_score IS DISTINCT FROM NEW.home_score OR OLD.away_score IS DISTINCT FROM NEW.away_score) THEN

    -- Recalcular standings si el partido es de grupo
    IF NEW.group_id IS NOT NULL THEN
      PERFORM fn_recalculate_standings(NEW.group_id);
    END IF;

  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ── 5. Crear el trigger en la tabla matches ────────────────────
DROP TRIGGER IF EXISTS tr_after_match_update ON matches;

CREATE TRIGGER tr_after_match_update
  AFTER UPDATE ON matches
  FOR EACH ROW
  EXECUTE FUNCTION fn_trigger_match_update();


-- ── 6. Política de escritura solo para admin autenticado ──────
-- Permite UPDATE solo si el usuario tiene rol 'authenticated' y
-- su email coincide con el admin designado:
-- (Reemplaza 'TU_EMAIL_AQUI@gmail.com' con tu email real)

ALTER TABLE matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE standings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Admin can update matches" ON matches;
CREATE POLICY "Admin can update matches"
  ON matches FOR UPDATE
  TO authenticated
  USING (auth.jwt() ->> 'email' = current_setting('app.admin_email', true))
  WITH CHECK (auth.jwt() ->> 'email' = current_setting('app.admin_email', true));

DROP POLICY IF EXISTS "Admin can update standings" ON standings;
CREATE POLICY "Admin can update standings"
  ON standings FOR UPDATE
  TO authenticated
  USING (auth.jwt() ->> 'email' = current_setting('app.admin_email', true))
  WITH CHECK (auth.jwt() ->> 'email' = current_setting('app.admin_email', true));

-- Permitir SELECT siempre (ya estaba habilitado antes)
DROP POLICY IF EXISTS "Public read standings" ON standings;
CREATE POLICY "Public read standings"
  ON standings FOR SELECT TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "Public read matches" ON matches;
CREATE POLICY "Public read matches"
  ON matches FOR SELECT TO anon, authenticated USING (true);


-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
