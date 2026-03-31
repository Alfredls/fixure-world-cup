export interface Team {
    name: string;
    flag: string;
}

export interface MatchScore {
    home: number;
    away: number;
}

export interface BaseMatch {
    id: string | number;
    homeTeam: Team;
    awayTeam: Team;
    status: string;
    phase?: string;
    group?: string;
}

export interface CalendarMatch extends BaseMatch {
    date: string;
    time: string;
    venue: string;
    city: string;
}

export interface LiveMatchData extends BaseMatch {
    score: MatchScore;
    penalties?: { home: number; away: number } | null;
}

export interface DailyMatch extends BaseMatch {
    time: string;
    score: MatchScore;
}
