import type { APIRoute } from 'astro';
import { createClient } from '@supabase/supabase-js';

const FOOTBALL_DATA_TOKEN = import.meta.env.FOOTBALL_DATA_API_KEY;
// World Cup 2026 competition ID on football-data.org
const WC2026_ID = 2000; // FIFA World Cup competition code

export const POST: APIRoute = async ({ request, cookies }) => {
  // Verify auth
  const authHeader = request.headers.get('Authorization');
  const token = authHeader?.replace('Bearer ', '') || cookies.get('sb-access-token')?.value;

  if (!token) {
    return new Response(JSON.stringify({ error: 'No autorizado' }), {
      status: 401,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // Client anon — solo para verificar la sesión del usuario
  const supabaseAuth = createClient(
    import.meta.env.PUBLIC_SUPABASE_URL,
    import.meta.env.PUBLIC_SUPABASE_ANON_KEY,
    { global: { headers: { Authorization: `Bearer ${token}` } } }
  );

  // Verify user session
  const { data: { user }, error: authError } = await supabaseAuth.auth.getUser(token);
  if (authError || !user) {
    return new Response(JSON.stringify({ error: 'Sesión inválida' }), {
      status: 401,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // Client service role — para operaciones de lectura/escritura en DB (bypassa RLS)
  const supabase = createClient(
    import.meta.env.PUBLIC_SUPABASE_URL,
    import.meta.env.SUPABASE_SERVICE_ROLE_KEY,
  );

  const today = new Date().toISOString().split('T')[0];
  let updated = 0;
  let live = 0;
  let message = '';

  // If no API key configured, return helpful message
  if (!FOOTBALL_DATA_TOKEN) {
    return new Response(JSON.stringify({
      updated: 0,
      live: 0,
      message: 'API Key no configurada. Agrega FOOTBALL_DATA_API_KEY en tu archivo .env para activar la sincronización automática.',
    }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  try {
    // Fetch today's matches from football-data.org
    const apiRes = await fetch(
      `https://api.football-data.org/v4/competitions/${WC2026_ID}/matches?dateFrom=${today}&dateTo=${today}`,
      {
        headers: {
          'X-Auth-Token': FOOTBALL_DATA_TOKEN,
        },
      }
    );

    if (!apiRes.ok) {
      const errText = await apiRes.text();
      return new Response(JSON.stringify({
        error: `API error ${apiRes.status}: ${errText.slice(0, 200)}`,
      }), {
        status: 502,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const apiData = await apiRes.json();
    const apiMatches = apiData?.matches || [];

    if (apiMatches.length === 0) {
      return new Response(JSON.stringify({
        updated: 0,
        live: 0,
        message: 'No hay partidos hoy según la API externa.',
      }), {
        status: 200,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    // Get today's matches from our DB
    const { data: dbMatches } = await supabase
      .from('matches')
      .select('id, match_date, match_time, home_score, away_score, status, home_team:teams!home_team_id(name), away_team:teams!away_team_id(name)')
      .eq('match_date', today);

    // Map API statuses to our statuses
    const mapStatus = (apiStatus: string): string => {
      switch (apiStatus) {
        case 'IN_PLAY':
        case 'PAUSED':
          return 'live';
        case 'FINISHED':
        case 'AWARDED':
          return 'finished';
        default:
          return 'scheduled';
      }
    };

    // Match API results to DB matches by team name (fuzzy matching)
    for (const apiMatch of apiMatches) {
      const apiHomeGoals = apiMatch.score?.fullTime?.home ?? null;
      const apiAwayGoals = apiMatch.score?.fullTime?.away ?? null;
      const apiStatus = mapStatus(apiMatch.status);

      if (apiStatus === 'live') live++;

      // Find corresponding match in DB
      const homeTeamName = apiMatch.homeTeam?.name || '';
      const dbMatch = dbMatches?.find((db: any) => {
        const dbHome = Array.isArray(db.home_team) ? db.home_team[0] : db.home_team;
        return dbHome?.name?.toLowerCase().includes(homeTeamName.toLowerCase().split(' ')[0]);
      });

      if (dbMatch && (
        dbMatch.status !== apiStatus ||
        dbMatch.home_score !== apiHomeGoals ||
        dbMatch.away_score !== apiAwayGoals
      )) {
        const updatePayload: Record<string, any> = { status: apiStatus };
        if (apiHomeGoals !== null) updatePayload.home_score = apiHomeGoals;
        if (apiAwayGoals !== null) updatePayload.away_score = apiAwayGoals;

        const { error: updateErr } = await supabase
          .from('matches')
          .update(updatePayload)
          .eq('id', dbMatch.id);

        if (!updateErr) updated++;
      }
    }

    return new Response(JSON.stringify({ updated, live, message }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });

  } catch (err: any) {
    return new Response(JSON.stringify({ error: err.message || 'Error interno' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
};
