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
