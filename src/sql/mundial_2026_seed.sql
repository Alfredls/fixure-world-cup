-- ============================================================
-- MUNDIAL 2026 - SEED DATA
-- Tablas: groups, teams, venues, matches
-- ============================================================

-- ============================================================
-- 0. RESET DATABASE
-- ============================================================
TRUNCATE TABLE standings, matches, teams, venues, groups CASCADE;

-- ============================================================
-- 1. GROUPS
-- ============================================================
INSERT INTO groups (id, name) VALUES
  ('A', 'Grupo A'),
  ('B', 'Grupo B'),
  ('C', 'Grupo C'),
  ('D', 'Grupo D'),
  ('E', 'Grupo E'),
  ('F', 'Grupo F'),
  ('G', 'Grupo G'),
  ('H', 'Grupo H'),
  ('I', 'Grupo I'),
  ('J', 'Grupo J'),
  ('K', 'Grupo K'),
  ('L', 'Grupo L');


-- ============================================================
-- 2. VENUES
-- ============================================================
INSERT INTO venues (id, name, city, country) VALUES
  (gen_random_uuid(), 'Estadio Azteca',              'Ciudad de México', 'México'),
  (gen_random_uuid(), 'Estadio Akron',               'Guadalajara',      'México'),
  (gen_random_uuid(), 'Estadio BBVA',                'Monterrey',        'México'),
  (gen_random_uuid(), 'Mercedes-Benz Stadium',       'Atlanta',          'USA'),
  (gen_random_uuid(), 'SoFi Stadium',                'Los Angeles',      'USA'),
  (gen_random_uuid(), 'Levi''s Stadium',             'San Francisco',    'USA'),
  (gen_random_uuid(), 'MetLife Stadium',             'New York/NJ',      'USA'),
  (gen_random_uuid(), 'Gillette Stadium',            'Boston',           'USA'),
  (gen_random_uuid(), 'Lincoln Financial Field',     'Philadelphia',     'USA'),
  (gen_random_uuid(), 'Hard Rock Stadium',           'Miami',            'USA'),
  (gen_random_uuid(), 'AT&T Stadium',                'Dallas',           'USA'),
  (gen_random_uuid(), 'Arrowhead Stadium',           'Kansas City',      'USA'),
  (gen_random_uuid(), 'NRG Stadium',                 'Houston',          'USA'),
  (gen_random_uuid(), 'Lumen Field',                 'Seattle',          'USA'),
  (gen_random_uuid(), 'BMO Field',                   'Toronto',          'Canadá'),
  (gen_random_uuid(), 'BC Place',                    'Vancouver',        'Canadá');


-- ============================================================
-- 3. TEAMS
-- Nota: los equipos con playoff pendiente se cargan con el
--       nombre provisional más probable / nombre compuesto.
-- ============================================================
INSERT INTO teams (id, name, flag_emoji, confederation, group_id) VALUES
  -- Grupo A
  (gen_random_uuid(), 'México',            'mex.png', 'CONCACAF', 'A'),
  (gen_random_uuid(), 'Sudáfrica',         'rsa.png', 'CAF',      'A'),
  (gen_random_uuid(), 'República de Corea','kor.png', 'AFC',      'A'),
  (gen_random_uuid(), 'Por definir (A4)',  'unk.png', 'UEFA',     'A'),

  -- Grupo B
  (gen_random_uuid(), 'Canadá',            'can.png', 'CONCACAF', 'B'),
  (gen_random_uuid(), 'Por definir (B2)',  'unk.png', 'UEFA',     'B'),
  (gen_random_uuid(), 'Catar',             'qat.png', 'AFC',      'B'),
  (gen_random_uuid(), 'Suiza',             'sui.png', 'UEFA',     'B'),

  -- Grupo C
  (gen_random_uuid(), 'Brasil',            'bra.png', 'CONMEBOL', 'C'),
  (gen_random_uuid(), 'Marruecos',         'mar.png', 'CAF',      'C'),
  (gen_random_uuid(), 'Haití',             'hai.png', 'CONCACAF', 'C'),
  (gen_random_uuid(), 'Escocia',           'sco.png', 'UEFA',     'C'),

  -- Grupo D
  (gen_random_uuid(), 'Estados Unidos',    'usa.png', 'CONCACAF', 'D'),
  (gen_random_uuid(), 'Paraguay',          'par.png', 'CONMEBOL', 'D'),
  (gen_random_uuid(), 'Australia',         'aus.png', 'AFC',      'D'),
  (gen_random_uuid(), 'Por definir (D4)',  'unk.png', 'UEFA',     'D'),

  -- Grupo E
  (gen_random_uuid(), 'Alemania',          'ger.png', 'UEFA',     'E'),
  (gen_random_uuid(), 'Curazao',           'cuw.png', 'CONCACAF', 'E'),
  (gen_random_uuid(), 'Costa de Marfil',   'civ.png', 'CAF',      'E'),
  (gen_random_uuid(), 'Ecuador',           'ecu.png', 'CONMEBOL', 'E'),

  -- Grupo F
  (gen_random_uuid(), 'Países Bajos',      'ned.png', 'UEFA',     'F'),
  (gen_random_uuid(), 'Japón',             'jpn.png', 'AFC',      'F'),
  (gen_random_uuid(), 'Por definir (F3)',  'unk.png', 'UEFA',     'F'),
  (gen_random_uuid(), 'Túnez',             'tun.png', 'CAF',      'F'),

  -- Grupo G
  (gen_random_uuid(), 'Bélgica',           'bel.png', 'UEFA',     'G'),
  (gen_random_uuid(), 'Egipto',            'egy.png', 'CAF',      'G'),
  (gen_random_uuid(), 'Irán',              'irn.png', 'AFC',      'G'),
  (gen_random_uuid(), 'Nueva Zelanda',     'nzl.png', 'OFC',      'G'),

  -- Grupo H
  (gen_random_uuid(), 'España',            'esp.png', 'UEFA',     'H'),
  (gen_random_uuid(), 'Cabo Verde',        'cpv.png', 'CAF',      'H'),
  (gen_random_uuid(), 'Arabia Saudí',      'ksa.png', 'AFC',      'H'),
  (gen_random_uuid(), 'Uruguay',           'uru.png', 'CONMEBOL', 'H'),

  -- Grupo I
  (gen_random_uuid(), 'Francia',           'fra.png', 'UEFA',     'I'),
  (gen_random_uuid(), 'Senegal',           'sen.png', 'CAF',      'I'),
  (gen_random_uuid(), 'Por definir (I3)',  'unk.png', 'CONCACAF', 'I'),
  (gen_random_uuid(), 'Noruega',           'nor.png', 'UEFA',     'I'),

  -- Grupo J
  (gen_random_uuid(), 'Argentina',         'arg.png', 'CONMEBOL', 'J'),
  (gen_random_uuid(), 'Argelia',           'alg.png', 'CAF',      'J'),
  (gen_random_uuid(), 'Austria',           'aut.png', 'UEFA',     'J'),
  (gen_random_uuid(), 'Jordania',          'jor.png', 'AFC',      'J'),

  -- Grupo K
  (gen_random_uuid(), 'Portugal',          'por.png', 'UEFA',     'K'),
  (gen_random_uuid(), 'Por definir (K2)',  'unk.png', 'CAF',      'K'),
  (gen_random_uuid(), 'Uzbekistán',        'uzb.png', 'AFC',      'K'),
  (gen_random_uuid(), 'Colombia',          'col.png', 'CONMEBOL', 'K'),

  -- Grupo L
  (gen_random_uuid(), 'Inglaterra',        'eng.png', 'UEFA',     'L'),
  (gen_random_uuid(), 'Croacia',           'cro.png', 'UEFA',     'L'),
  (gen_random_uuid(), 'Ghana',             'gha.png', 'CAF',      'L'),
  (gen_random_uuid(), 'Panamá',            'pan.png', 'CONCACAF', 'L');


-- ============================================================
-- 4. MATCHES
-- Se usa un CTE para poder referenciar equipos y venues por
-- nombre sin hardcodear UUIDs.
-- ============================================================

WITH
  t AS (SELECT id, name FROM teams),
  v AS (SELECT id, name FROM venues)

INSERT INTO matches (id, group_id, phase, home_team_id, away_team_id, match_date, match_time, venue_id, status)
VALUES

  -- ── GRUPO A ──────────────────────────────────────────────
  (gen_random_uuid(), 'A', 'group',
    (SELECT id FROM t WHERE name='México'),
    (SELECT id FROM t WHERE name='Sudáfrica'),
    '2026-06-11', '15:00',
    (SELECT id FROM v WHERE name='Estadio Azteca'), 'scheduled'),

  (gen_random_uuid(), 'A', 'group',
    (SELECT id FROM t WHERE name='República de Corea'),
    (SELECT id FROM t WHERE name='Por definir (A4)'),
    '2026-06-11', '22:00',
    (SELECT id FROM v WHERE name='Estadio Akron'), 'scheduled'),

  (gen_random_uuid(), 'A', 'group',
    (SELECT id FROM t WHERE name='Por definir (A4)'),
    (SELECT id FROM t WHERE name='Sudáfrica'),
    '2026-06-18', '12:00',
    (SELECT id FROM v WHERE name='Mercedes-Benz Stadium'), 'scheduled'),

  (gen_random_uuid(), 'A', 'group',
    (SELECT id FROM t WHERE name='México'),
    (SELECT id FROM t WHERE name='República de Corea'),
    '2026-06-18', '21:00',
    (SELECT id FROM v WHERE name='Estadio Akron'), 'scheduled'),

  (gen_random_uuid(), 'A', 'group',
    (SELECT id FROM t WHERE name='Por definir (A4)'),
    (SELECT id FROM t WHERE name='México'),
    '2026-06-24', '21:00',
    (SELECT id FROM v WHERE name='Estadio Azteca'), 'scheduled'),

  (gen_random_uuid(), 'A', 'group',
    (SELECT id FROM t WHERE name='Sudáfrica'),
    (SELECT id FROM t WHERE name='República de Corea'),
    '2026-06-24', '21:00',
    (SELECT id FROM v WHERE name='Estadio BBVA'), 'scheduled'),

  -- ── GRUPO B ──────────────────────────────────────────────
  (gen_random_uuid(), 'B', 'group',
    (SELECT id FROM t WHERE name='Canadá'),
    (SELECT id FROM t WHERE name='Por definir (B2)'),
    '2026-06-12', '15:00',
    (SELECT id FROM v WHERE name='BMO Field'), 'scheduled'),

  (gen_random_uuid(), 'B', 'group',
    (SELECT id FROM t WHERE name='Catar'),
    (SELECT id FROM t WHERE name='Suiza'),
    '2026-06-13', '15:00',
    (SELECT id FROM v WHERE name='Levi''s Stadium'), 'scheduled'),

  (gen_random_uuid(), 'B', 'group',
    (SELECT id FROM t WHERE name='Suiza'),
    (SELECT id FROM t WHERE name='Por definir (B2)'),
    '2026-06-18', '15:00',
    (SELECT id FROM v WHERE name='SoFi Stadium'), 'scheduled'),

  (gen_random_uuid(), 'B', 'group',
    (SELECT id FROM t WHERE name='Canadá'),
    (SELECT id FROM t WHERE name='Catar'),
    '2026-06-18', '18:00',
    (SELECT id FROM v WHERE name='BC Place'), 'scheduled'),

  (gen_random_uuid(), 'B', 'group',
    (SELECT id FROM t WHERE name='Suiza'),
    (SELECT id FROM t WHERE name='Canadá'),
    '2026-06-24', '15:00',
    (SELECT id FROM v WHERE name='BC Place'), 'scheduled'),

  (gen_random_uuid(), 'B', 'group',
    (SELECT id FROM t WHERE name='Por definir (B2)'),
    (SELECT id FROM t WHERE name='Catar'),
    '2026-06-24', '15:00',
    (SELECT id FROM v WHERE name='Lumen Field'), 'scheduled'),

  -- ── GRUPO C ──────────────────────────────────────────────
  (gen_random_uuid(), 'C', 'group',
    (SELECT id FROM t WHERE name='Brasil'),
    (SELECT id FROM t WHERE name='Marruecos'),
    '2026-06-13', '18:00',
    (SELECT id FROM v WHERE name='MetLife Stadium'), 'scheduled'),

  (gen_random_uuid(), 'C', 'group',
    (SELECT id FROM t WHERE name='Haití'),
    (SELECT id FROM t WHERE name='Escocia'),
    '2026-06-13', '21:00',
    (SELECT id FROM v WHERE name='Gillette Stadium'), 'scheduled'),

  (gen_random_uuid(), 'C', 'group',
    (SELECT id FROM t WHERE name='Escocia'),
    (SELECT id FROM t WHERE name='Marruecos'),
    '2026-06-19', '18:00',
    (SELECT id FROM v WHERE name='Gillette Stadium'), 'scheduled'),

  (gen_random_uuid(), 'C', 'group',
    (SELECT id FROM t WHERE name='Brasil'),
    (SELECT id FROM t WHERE name='Haití'),
    '2026-06-19', '21:00',
    (SELECT id FROM v WHERE name='Lincoln Financial Field'), 'scheduled'),

  (gen_random_uuid(), 'C', 'group',
    (SELECT id FROM t WHERE name='Brasil'),
    (SELECT id FROM t WHERE name='Escocia'),
    '2026-06-24', '18:00',
    (SELECT id FROM v WHERE name='Hard Rock Stadium'), 'scheduled'),

  (gen_random_uuid(), 'C', 'group',
    (SELECT id FROM t WHERE name='Marruecos'),
    (SELECT id FROM t WHERE name='Haití'),
    '2026-06-24', '18:00',
    (SELECT id FROM v WHERE name='Mercedes-Benz Stadium'), 'scheduled'),

  -- ── GRUPO D ──────────────────────────────────────────────
  (gen_random_uuid(), 'D', 'group',
    (SELECT id FROM t WHERE name='Estados Unidos'),
    (SELECT id FROM t WHERE name='Paraguay'),
    '2026-06-12', '21:00',
    (SELECT id FROM v WHERE name='SoFi Stadium'), 'scheduled'),

  (gen_random_uuid(), 'D', 'group',
    (SELECT id FROM t WHERE name='Australia'),
    (SELECT id FROM t WHERE name='Por definir (D4)'),
    '2026-06-13', '00:00',
    (SELECT id FROM v WHERE name='BC Place'), 'scheduled'),

  (gen_random_uuid(), 'D', 'group',
    (SELECT id FROM t WHERE name='Estados Unidos'),
    (SELECT id FROM t WHERE name='Australia'),
    '2026-06-19', '15:00',
    (SELECT id FROM v WHERE name='Lumen Field'), 'scheduled'),

  (gen_random_uuid(), 'D', 'group',
    (SELECT id FROM t WHERE name='Por definir (D4)'),
    (SELECT id FROM t WHERE name='Paraguay'),
    '2026-06-19', '00:00',
    (SELECT id FROM v WHERE name='Levi''s Stadium'), 'scheduled'),

  (gen_random_uuid(), 'D', 'group',
    (SELECT id FROM t WHERE name='Por definir (D4)'),
    (SELECT id FROM t WHERE name='Estados Unidos'),
    '2026-06-25', '22:00',
    (SELECT id FROM v WHERE name='SoFi Stadium'), 'scheduled'),

  (gen_random_uuid(), 'D', 'group',
    (SELECT id FROM t WHERE name='Paraguay'),
    (SELECT id FROM t WHERE name='Australia'),
    '2026-06-25', '22:00',
    (SELECT id FROM v WHERE name='Levi''s Stadium'), 'scheduled'),

  -- ── GRUPO E ──────────────────────────────────────────────
  (gen_random_uuid(), 'E', 'group',
    (SELECT id FROM t WHERE name='Alemania'),
    (SELECT id FROM t WHERE name='Curazao'),
    '2026-06-14', '13:00',
    (SELECT id FROM v WHERE name='NRG Stadium'), 'scheduled'),

  (gen_random_uuid(), 'E', 'group',
    (SELECT id FROM t WHERE name='Costa de Marfil'),
    (SELECT id FROM t WHERE name='Ecuador'),
    '2026-06-14', '19:00',
    (SELECT id FROM v WHERE name='Lincoln Financial Field'), 'scheduled'),

  (gen_random_uuid(), 'E', 'group',
    (SELECT id FROM t WHERE name='Alemania'),
    (SELECT id FROM t WHERE name='Costa de Marfil'),
    '2026-06-20', '16:00',
    (SELECT id FROM v WHERE name='BMO Field'), 'scheduled'),

  (gen_random_uuid(), 'E', 'group',
    (SELECT id FROM t WHERE name='Ecuador'),
    (SELECT id FROM t WHERE name='Curazao'),
    '2026-06-20', '22:00',
    (SELECT id FROM v WHERE name='Arrowhead Stadium'), 'scheduled'),

  (gen_random_uuid(), 'E', 'group',
    (SELECT id FROM t WHERE name='Curazao'),
    (SELECT id FROM t WHERE name='Costa de Marfil'),
    '2026-06-25', '16:00',
    (SELECT id FROM v WHERE name='Lincoln Financial Field'), 'scheduled'),

  (gen_random_uuid(), 'E', 'group',
    (SELECT id FROM t WHERE name='Ecuador'),
    (SELECT id FROM t WHERE name='Alemania'),
    '2026-06-25', '16:00',
    (SELECT id FROM v WHERE name='MetLife Stadium'), 'scheduled'),

  -- ── GRUPO F ──────────────────────────────────────────────
  (gen_random_uuid(), 'F', 'group',
    (SELECT id FROM t WHERE name='Países Bajos'),
    (SELECT id FROM t WHERE name='Japón'),
    '2026-06-14', '16:00',
    (SELECT id FROM v WHERE name='AT&T Stadium'), 'scheduled'),

  (gen_random_uuid(), 'F', 'group',
    (SELECT id FROM t WHERE name='Por definir (F3)'),
    (SELECT id FROM t WHERE name='Túnez'),
    '2026-06-14', '22:00',
    (SELECT id FROM v WHERE name='Estadio BBVA'), 'scheduled'),

  (gen_random_uuid(), 'F', 'group',
    (SELECT id FROM t WHERE name='Países Bajos'),
    (SELECT id FROM t WHERE name='Por definir (F3)'),
    '2026-06-20', '13:00',
    (SELECT id FROM v WHERE name='NRG Stadium'), 'scheduled'),

  (gen_random_uuid(), 'F', 'group',
    (SELECT id FROM t WHERE name='Túnez'),
    (SELECT id FROM t WHERE name='Japón'),
    '2026-06-20', '00:00',
    (SELECT id FROM v WHERE name='Estadio BBVA'), 'scheduled'),

  (gen_random_uuid(), 'F', 'group',
    (SELECT id FROM t WHERE name='Japón'),
    (SELECT id FROM t WHERE name='Por definir (F3)'),
    '2026-06-25', '19:00',
    (SELECT id FROM v WHERE name='AT&T Stadium'), 'scheduled'),

  (gen_random_uuid(), 'F', 'group',
    (SELECT id FROM t WHERE name='Túnez'),
    (SELECT id FROM t WHERE name='Países Bajos'),
    '2026-06-25', '19:00',
    (SELECT id FROM v WHERE name='Arrowhead Stadium'), 'scheduled'),

  -- ── GRUPO G ──────────────────────────────────────────────
  (gen_random_uuid(), 'G', 'group',
    (SELECT id FROM t WHERE name='Bélgica'),
    (SELECT id FROM t WHERE name='Egipto'),
    '2026-06-15', '15:00',
    (SELECT id FROM v WHERE name='Lumen Field'), 'scheduled'),

  (gen_random_uuid(), 'G', 'group',
    (SELECT id FROM t WHERE name='Irán'),
    (SELECT id FROM t WHERE name='Nueva Zelanda'),
    '2026-06-15', '21:00',
    (SELECT id FROM v WHERE name='SoFi Stadium'), 'scheduled'),

  (gen_random_uuid(), 'G', 'group',
    (SELECT id FROM t WHERE name='Bélgica'),
    (SELECT id FROM t WHERE name='Irán'),
    '2026-06-21', '15:00',
    (SELECT id FROM v WHERE name='SoFi Stadium'), 'scheduled'),

  (gen_random_uuid(), 'G', 'group',
    (SELECT id FROM t WHERE name='Nueva Zelanda'),
    (SELECT id FROM t WHERE name='Egipto'),
    '2026-06-21', '21:00',
    (SELECT id FROM v WHERE name='BC Place'), 'scheduled'),

  (gen_random_uuid(), 'G', 'group',
    (SELECT id FROM t WHERE name='Egipto'),
    (SELECT id FROM t WHERE name='Irán'),
    '2026-06-26', '23:00',
    (SELECT id FROM v WHERE name='Lumen Field'), 'scheduled'),

  (gen_random_uuid(), 'G', 'group',
    (SELECT id FROM t WHERE name='Nueva Zelanda'),
    (SELECT id FROM t WHERE name='Bélgica'),
    '2026-06-26', '23:00',
    (SELECT id FROM v WHERE name='BC Place'), 'scheduled'),

  -- ── GRUPO H ──────────────────────────────────────────────
  (gen_random_uuid(), 'H', 'group',
    (SELECT id FROM t WHERE name='España'),
    (SELECT id FROM t WHERE name='Cabo Verde'),
    '2026-06-15', '12:00',
    (SELECT id FROM v WHERE name='Mercedes-Benz Stadium'), 'scheduled'),

  (gen_random_uuid(), 'H', 'group',
    (SELECT id FROM t WHERE name='Arabia Saudí'),
    (SELECT id FROM t WHERE name='Uruguay'),
    '2026-06-15', '18:00',
    (SELECT id FROM v WHERE name='Hard Rock Stadium'), 'scheduled'),

  (gen_random_uuid(), 'H', 'group',
    (SELECT id FROM t WHERE name='España'),
    (SELECT id FROM t WHERE name='Arabia Saudí'),
    '2026-06-21', '12:00',
    (SELECT id FROM v WHERE name='Mercedes-Benz Stadium'), 'scheduled'),

  (gen_random_uuid(), 'H', 'group',
    (SELECT id FROM t WHERE name='Uruguay'),
    (SELECT id FROM t WHERE name='Cabo Verde'),
    '2026-06-21', '18:00',
    (SELECT id FROM v WHERE name='Hard Rock Stadium'), 'scheduled'),

  (gen_random_uuid(), 'H', 'group',
    (SELECT id FROM t WHERE name='Cabo Verde'),
    (SELECT id FROM t WHERE name='Arabia Saudí'),
    '2026-06-26', '20:00',
    (SELECT id FROM v WHERE name='NRG Stadium'), 'scheduled'),

  (gen_random_uuid(), 'H', 'group',
    (SELECT id FROM t WHERE name='Uruguay'),
    (SELECT id FROM t WHERE name='España'),
    '2026-06-26', '20:00',
    (SELECT id FROM v WHERE name='Estadio Akron'), 'scheduled'),

  -- ── GRUPO I ──────────────────────────────────────────────
  (gen_random_uuid(), 'I', 'group',
    (SELECT id FROM t WHERE name='Francia'),
    (SELECT id FROM t WHERE name='Senegal'),
    '2026-06-16', '15:00',
    (SELECT id FROM v WHERE name='MetLife Stadium'), 'scheduled'),

  (gen_random_uuid(), 'I', 'group',
    (SELECT id FROM t WHERE name='Por definir (I3)'),
    (SELECT id FROM t WHERE name='Noruega'),
    '2026-06-16', '18:00',
    (SELECT id FROM v WHERE name='Gillette Stadium'), 'scheduled'),

  (gen_random_uuid(), 'I', 'group',
    (SELECT id FROM t WHERE name='Francia'),
    (SELECT id FROM t WHERE name='Por definir (I3)'),
    '2026-06-22', '17:00',
    (SELECT id FROM v WHERE name='Lincoln Financial Field'), 'scheduled'),

  (gen_random_uuid(), 'I', 'group',
    (SELECT id FROM t WHERE name='Noruega'),
    (SELECT id FROM t WHERE name='Senegal'),
    '2026-06-22', '20:00',
    (SELECT id FROM v WHERE name='MetLife Stadium'), 'scheduled'),

  (gen_random_uuid(), 'I', 'group',
    (SELECT id FROM t WHERE name='Noruega'),
    (SELECT id FROM t WHERE name='Francia'),
    '2026-06-26', '15:00',
    (SELECT id FROM v WHERE name='Gillette Stadium'), 'scheduled'),

  (gen_random_uuid(), 'I', 'group',
    (SELECT id FROM t WHERE name='Senegal'),
    (SELECT id FROM t WHERE name='Por definir (I3)'),
    '2026-06-26', '15:00',
    (SELECT id FROM v WHERE name='BMO Field'), 'scheduled'),

  -- ── GRUPO J ──────────────────────────────────────────────
  (gen_random_uuid(), 'J', 'group',
    (SELECT id FROM t WHERE name='Argentina'),
    (SELECT id FROM t WHERE name='Argelia'),
    '2026-06-16', '21:00',
    (SELECT id FROM v WHERE name='Arrowhead Stadium'), 'scheduled'),

  (gen_random_uuid(), 'J', 'group',
    (SELECT id FROM t WHERE name='Austria'),
    (SELECT id FROM t WHERE name='Jordania'),
    '2026-06-16', '00:00',
    (SELECT id FROM v WHERE name='Levi''s Stadium'), 'scheduled'),

  (gen_random_uuid(), 'J', 'group',
    (SELECT id FROM t WHERE name='Argentina'),
    (SELECT id FROM t WHERE name='Austria'),
    '2026-06-22', '13:00',
    (SELECT id FROM v WHERE name='AT&T Stadium'), 'scheduled'),

  (gen_random_uuid(), 'J', 'group',
    (SELECT id FROM t WHERE name='Jordania'),
    (SELECT id FROM t WHERE name='Argelia'),
    '2026-06-22', '23:00',
    (SELECT id FROM v WHERE name='Levi''s Stadium'), 'scheduled'),

  (gen_random_uuid(), 'J', 'group',
    (SELECT id FROM t WHERE name='Argelia'),
    (SELECT id FROM t WHERE name='Austria'),
    '2026-06-27', '22:00',
    (SELECT id FROM v WHERE name='Arrowhead Stadium'), 'scheduled'),

  (gen_random_uuid(), 'J', 'group',
    (SELECT id FROM t WHERE name='Jordania'),
    (SELECT id FROM t WHERE name='Argentina'),
    '2026-06-27', '22:00',
    (SELECT id FROM v WHERE name='AT&T Stadium'), 'scheduled'),

  -- ── GRUPO K ──────────────────────────────────────────────
  (gen_random_uuid(), 'K', 'group',
    (SELECT id FROM t WHERE name='Portugal'),
    (SELECT id FROM t WHERE name='Por definir (K2)'),
    '2026-06-17', '13:00',
    (SELECT id FROM v WHERE name='NRG Stadium'), 'scheduled'),

  (gen_random_uuid(), 'K', 'group',
    (SELECT id FROM t WHERE name='Uzbekistán'),
    (SELECT id FROM t WHERE name='Colombia'),
    '2026-06-17', '22:00',
    (SELECT id FROM v WHERE name='Estadio Azteca'), 'scheduled'),

  (gen_random_uuid(), 'K', 'group',
    (SELECT id FROM t WHERE name='Portugal'),
    (SELECT id FROM t WHERE name='Uzbekistán'),
    '2026-06-23', '13:00',
    (SELECT id FROM v WHERE name='NRG Stadium'), 'scheduled'),

  (gen_random_uuid(), 'K', 'group',
    (SELECT id FROM t WHERE name='Colombia'),
    (SELECT id FROM t WHERE name='Por definir (K2)'),
    '2026-06-23', '22:00',
    (SELECT id FROM v WHERE name='Estadio Akron'), 'scheduled'),

  (gen_random_uuid(), 'K', 'group',
    (SELECT id FROM t WHERE name='Colombia'),
    (SELECT id FROM t WHERE name='Portugal'),
    '2026-06-27', '19:30',
    (SELECT id FROM v WHERE name='Hard Rock Stadium'), 'scheduled'),

  (gen_random_uuid(), 'K', 'group',
    (SELECT id FROM t WHERE name='Por definir (K2)'),
    (SELECT id FROM t WHERE name='Uzbekistán'),
    '2026-06-27', '19:30',
    (SELECT id FROM v WHERE name='Mercedes-Benz Stadium'), 'scheduled'),

  -- ── GRUPO L ──────────────────────────────────────────────
  (gen_random_uuid(), 'L', 'group',
    (SELECT id FROM t WHERE name='Inglaterra'),
    (SELECT id FROM t WHERE name='Croacia'),
    '2026-06-17', '16:00',
    (SELECT id FROM v WHERE name='AT&T Stadium'), 'scheduled'),

  (gen_random_uuid(), 'L', 'group',
    (SELECT id FROM t WHERE name='Ghana'),
    (SELECT id FROM t WHERE name='Panamá'),
    '2026-06-17', '19:00',
    (SELECT id FROM v WHERE name='BMO Field'), 'scheduled'),

  (gen_random_uuid(), 'L', 'group',
    (SELECT id FROM t WHERE name='Inglaterra'),
    (SELECT id FROM t WHERE name='Ghana'),
    '2026-06-23', '16:00',
    (SELECT id FROM v WHERE name='Gillette Stadium'), 'scheduled'),

  (gen_random_uuid(), 'L', 'group',
    (SELECT id FROM t WHERE name='Panamá'),
    (SELECT id FROM t WHERE name='Croacia'),
    '2026-06-23', '19:00',
    (SELECT id FROM v WHERE name='BMO Field'), 'scheduled'),

  (gen_random_uuid(), 'L', 'group',
    (SELECT id FROM t WHERE name='Panamá'),
    (SELECT id FROM t WHERE name='Inglaterra'),
    '2026-06-27', '17:00',
    (SELECT id FROM v WHERE name='MetLife Stadium'), 'scheduled'),

  (gen_random_uuid(), 'L', 'group',
    (SELECT id FROM t WHERE name='Croacia'),
    (SELECT id FROM t WHERE name='Ghana'),
    '2026-06-27', '17:00',
    (SELECT id FROM v WHERE name='Lincoln Financial Field'), 'scheduled');


-- ============================================================
-- 5. STANDINGS - inicializar en cero para cada equipo
-- ============================================================
INSERT INTO standings (id, group_id, team_id, played, won, drawn, lost, goals_for, goals_against, goal_diff, points, qualified)
SELECT
  gen_random_uuid(),
  group_id,
  id,
  0, 0, 0, 0, 0, 0, 0, 0, false
FROM teams;
