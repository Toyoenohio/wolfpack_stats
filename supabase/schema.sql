-- Schema para Wolfpack Stats (VolleyStats)
-- Crear proyecto en Supabase y ejecutar este SQL en SQL Editor

-- Tabla de jugadoras
CREATE TABLE players (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    number INTEGER,
    position TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de prácticas
CREATE TABLE practice_sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    date DATE DEFAULT CURRENT_DATE,
    status TEXT DEFAULT 'active', -- active, closed
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de estadísticas
CREATE TABLE stats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    session_id UUID REFERENCES practice_sessions(id) ON DELETE CASCADE,
    action TEXT NOT NULL, -- ataque, pase, recepcion, bloqueo, servicio
    position INTEGER NOT NULL CHECK (position >= 1 AND position <= 6),
    result TEXT NOT NULL CHECK (result IN ('success', 'fail')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Vistas para estadísticas

-- Vista: Estadísticas por jugadora y acción
CREATE VIEW player_stats_summary AS
SELECT 
    p.id as player_id,
    p.name,
    p.number,
    p.position,
    s.action,
    s.position as stat_position,
    COUNT(*) FILTER (WHERE s.result = 'success') as success_count,
    COUNT(*) FILTER (WHERE s.result = 'fail') as fail_count,
    COUNT(*) as total_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 
            ROUND((COUNT(*) FILTER (WHERE s.result = 'success') * 100.0 / COUNT(*)), 2)
        ELSE 0 
    END as effectiveness_percentage
FROM players p
LEFT JOIN stats s ON p.id = s.player_id
GROUP BY p.id, p.name, p.number, p.position, s.action, s.position;

-- Vista: Estadísticas por jugadora y práctica
CREATE VIEW player_session_stats AS
SELECT 
    p.id as player_id,
    p.name as player_name,
    ps.id as session_id,
    ps.name as session_name,
    ps.date as session_date,
    s.action,
    s.position,
    COUNT(*) FILTER (WHERE s.result = 'success') as success_count,
    COUNT(*) FILTER (WHERE s.result = 'fail') as fail_count,
    COUNT(*) as total_count
FROM players p
JOIN stats s ON p.id = s.player_id
JOIN practice_sessions ps ON s.session_id = ps.id
GROUP BY p.id, p.name, ps.id, ps.name, ps.date, s.action, s.position
ORDER BY ps.date DESC, p.name;

-- Políticas de seguridad (RLS)
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE practice_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE stats ENABLE ROW LEVEL SECURITY;

-- Permitir lectura/escritura anónima (para el MVP)
-- En producción, cambiar a autenticación requerida
CREATE POLICY "Allow anonymous read" ON players FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert" ON players FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow anonymous read" ON practice_sessions FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert" ON practice_sessions FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow anonymous read" ON stats FOR SELECT USING (true);
CREATE POLICY "Allow anonymous insert" ON stats FOR INSERT WITH CHECK (true);

-- Índices para optimizar consultas
CREATE INDEX idx_stats_player ON stats(player_id);
CREATE INDEX idx_stats_session ON stats(session_id);
CREATE INDEX idx_stats_action ON stats(action);
