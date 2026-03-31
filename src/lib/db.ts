import { supabase } from "./supabase";

/**
 * Obtiene la fecha más cercana con partidos (hoy o en el futuro).
 * Retorna null si no hay partidos programados.
 */
export async function getNextMatchDate(fromDate: string = new Date().toISOString().split('T')[0]): Promise<string | null> {
  const { data, error } = await supabase
    .from("matches")
    .select("match_date")
    .gte("match_date", fromDate)
    .order("match_date", { ascending: true })
    .limit(1);

  if (error || !data || data.length === 0) return null;
  return data[0].match_date;
}

/**
 * Obtiene todos los partidos de una fecha específica, incluyendo datos de los equipos.
 */
export async function getMatchesByDate(date: string) {
  const { data, error } = await supabase
    .from("matches")
    .select(`
      *,
      home_team:teams!home_team_id(*),
      away_team:teams!away_team_id(*)
    `)
    .eq("match_date", date)
    .order("match_time", { ascending: true });

  if (error) {
    console.error("Error fetching matches by date:", error);
    return [];
  }
  return data || [];
}

const mockCalendarMatches = [
  { id: 1, homeTeam: { name: 'México', flag: 'mex.png' }, awayTeam: { name: 'Sudáfrica', flag: 'rsa.png' }, date: '2026-06-11', time: '15:00 Hrs.', venue: 'Estadio Azteca', city: 'Ciudad de México', phase: 'group', group: 'Grupo A', status: 'scheduled' },
  { id: 2, homeTeam: { name: 'Canadá', flag: 'can.png' }, awayTeam: { name: 'Suiza', flag: 'sui.png' }, date: '2026-06-12', time: '15:00 Hrs.', venue: 'BMO Field', city: 'Toronto', phase: 'group', group: 'Grupo B', status: 'scheduled' },
  { id: 3, homeTeam: { name: 'EE.UU.', flag: 'usa.png' }, awayTeam: { name: 'Paraguay', flag: 'par.png' }, date: '2026-06-12', time: '21:00 Hrs.', venue: 'SoFi Stadium', city: 'Los Angeles', phase: 'group', group: 'Grupo D', status: 'scheduled' },
  { id: 4, homeTeam: { name: 'Brasil', flag: 'bra.png' }, awayTeam: { name: 'Marruecos', flag: 'mar.png' }, date: '2026-06-13', time: '18:00 Hrs.', venue: 'MetLife Stadium', city: 'New York/NJ', phase: 'group', group: 'Grupo C', status: 'scheduled' },
];

export async function getAllCalendarMatches() {
  const { data, error } = await supabase
    .from('matches')
    .select(`
        id,
        match_date,
        match_time,
        status,
        phase,
        group_id,
        home_team:teams!home_team_id(name, flag_emoji),
        away_team:teams!away_team_id(name, flag_emoji),
        venue:venues(name, city)
    `)
    .order('match_date', { ascending: true })
    .order('match_time', { ascending: true });

  if (error || !data || data.length === 0) {
    console.error("Using mock matches due to error or missing data");
    return mockCalendarMatches;
  }

  return data.map((m: any) => {
    const home = Array.isArray(m.home_team) ? m.home_team[0] : m.home_team;
    const away = Array.isArray(m.away_team) ? m.away_team[0] : m.away_team;
    const venueInfo = Array.isArray(m.venue) ? m.venue[0] : m.venue;

    return {
      id: m.id,
      homeTeam: { name: home?.name || 'TBD', flag: home?.flag_emoji || 'unk.png' },
      awayTeam: { name: away?.name || 'TBD', flag: away?.flag_emoji || 'unk.png' },
      date: m.match_date,
      time: m.match_time ? m.match_time.slice(0, 5) + ' Hrs.' : 'TBD',
      venue: venueInfo?.name || 'TBD',
      city: venueInfo?.city || '',
      phase: m.phase,
      group: m.group_id ? `Grupo ${m.group_id}` : '',
      status: m.status
    };
  });
}

