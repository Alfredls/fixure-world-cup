-- ============================================================
-- MUNDIAL 2026 — LÓGICA DE RESULTADOS (VERSIÓN REPARACIÓN TOTAL V3)
-- Ejecutar en Supabase SQL Editor
-- ============================================================

-- ── 1. Limpieza y Recreación con Relaciones Correctas ────────
DROP TABLE IF EXISTS standings;

-- Aseguramos columnas en matches
ALTER TABLE matches
  ADD COLUMN IF NOT EXISTS home_score INTEGER DEFAULT 0,
  ADD COLUMN IF NOT EXISTS away_score INTEGER DEFAULT 0;

-- Recreamos standings con Llave Foránea (FK) para que la web vea los equipos
CREATE TABLE standings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id TEXT,
  team_id uuid UNIQUE REFERENCES teams(id), -- UUID + Relación con Teams
  played INTEGER DEFAULT 0,
  won INTEGER DEFAULT 0,
  drawn INTEGER DEFAULT 0,
  lost INTEGER DEFAULT 0,
  goals_for INTEGER DEFAULT 0,
  goals_against INTEGER DEFAULT 0,
  goal_diff INTEGER DEFAULT 0,
  points INTEGER DEFAULT 0,
  qualified BOOLEAN DEFAULT false
);

-- Insertar equipos (Usando el ID nativo UUID para que no falle)
INSERT INTO standings (group_id, team_id)
SELECT group_id, id FROM teams
ON CONFLICT (team_id) DO NOTHING;

-- ── 2. Función: recalcular standings de un grupo ─────────────
CREATE OR REPLACE FUNCTION fn_recalculate_standings(p_group_id TEXT)
RETURNS VOID AS $$
DECLARE
  rec RECORD;
BEGIN
  -- Resetear todos los valores del grupo a cero
  UPDATE standings SET
    played = 0, won = 0, drawn = 0, lost = 0,
    goals_for = 0, goals_against = 0, goal_diff = 0, points = 0
  WHERE group_id = p_group_id;

  -- Recorrer todos los partidos FINALIZADOS del grupo
  FOR rec IN
    SELECT home_team_id, away_team_id, home_score, away_score
    FROM matches
    WHERE group_id = p_group_id
      AND status = 'finished'
      AND home_score IS NOT NULL
      AND away_score IS NOT NULL
  LOOP
    -- Actualizar equipo local (Convertimos a UUID para la comparación)
    UPDATE standings SET
      played = played + 1,
      goals_for = goals_for + rec.home_score,
      goals_against = goals_against + rec.away_score,
      won = won + CASE WHEN rec.home_score > rec.away_score THEN 1 ELSE 0 END,
      drawn = drawn + CASE WHEN rec.home_score = rec.away_score THEN 1 ELSE 0 END,
      lost = lost + CASE WHEN rec.home_score < rec.away_score THEN 1 ELSE 0 END,
      points = points + CASE
        WHEN rec.home_score > rec.away_score THEN 3
        WHEN rec.home_score = rec.away_score THEN 1
        ELSE 0
      END
    WHERE team_id = rec.home_team_id::uuid AND group_id = p_group_id;

    -- Actualizar equipo visitante
    UPDATE standings SET
      played = played + 1,
      goals_for = goals_for + rec.away_score,
      goals_against = goals_against + rec.home_score,
      won = won + CASE WHEN rec.away_score > rec.home_score THEN 1 ELSE 0 END,
      drawn = drawn + CASE WHEN rec.away_score = rec.home_score THEN 1 ELSE 0 END,
      lost = lost + CASE WHEN rec.away_score < rec.home_score THEN 1 ELSE 0 END,
      points = points + CASE
        WHEN rec.away_score > rec.home_score THEN 3
        WHEN rec.away_score = rec.home_score THEN 1
        ELSE 0
      END
    WHERE team_id = rec.away_team_id::uuid AND group_id = p_group_id;
  END LOOP;

  -- Post-proceso: actualizar diferencia de goles
  UPDATE standings SET
    goal_diff = goals_for - goals_against
  WHERE group_id = p_group_id;
END;
$$ LANGUAGE plpgsql;

-- ── 3. Función del Trigger ────────────────────────────────────
CREATE OR REPLACE FUNCTION fn_trigger_match_update()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.group_id IS NOT NULL THEN
    PERFORM fn_recalculate_standings(NEW.group_id);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ── 4. Activar el Trigger ──────────────────────────────────────
DROP TRIGGER IF EXISTS tr_after_match_update ON matches;
CREATE TRIGGER tr_after_match_update
  AFTER UPDATE ON matches
  FOR EACH ROW
  EXECUTE FUNCTION fn_trigger_match_update();

-- ── 5. Seguridad y Lectura Pública ─────────────────────────────
ALTER TABLE matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE standings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public read matches" ON matches;
CREATE POLICY "Public read matches" ON matches FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "Public read standings" ON standings;
CREATE POLICY "Public read standings" ON standings FOR SELECT TO public USING (true);

-- ============================================================
-- FIN DEL SCRIPT REPARADO V3
-- ============================================================
