/**
 * Formats a date string (YYYY-MM-DD) to a friendly Spanish format.
 * Example: "2026-06-16" -> "Martes 16 de Jun."
 */
export function formatMatchDate(dateStr: string): string {
  if (!dateStr) return "";
  
  // Use local parts to avoid timezone shift from UTC
  const [year, month, day] = dateStr.split('-').map(Number);
  const date = new Date(year, month - 1, day);
  
  const days = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
  const months = ['Ene.', 'Feb.', 'Mar.', 'Abr.', 'May.', 'Jun.', 'Jul.', 'Ago.', 'Sep.', 'Oct.', 'Nov.', 'Dic.'];
  
  const dayName = days[date.getDay()];
  const dayNumber = date.getDate();
  const monthName = months[date.getMonth()];
  
  return `${dayName} ${dayNumber} de ${monthName}`;
}

/**
 * Formats a time string (HH:MM:SS or HH:MM) to include "Hrs."
 * Example: "16:00:00" -> "16:00 Hrs."
 */
export function formatMatchTime(timeStr: string): string {
  if (!timeStr) return "";
  
  const parts = timeStr.split(':');
  const hours = parts[0];
  const minutes = parts[1];
  
  return `${hours}:${minutes} Hrs.`;
}

/**
 * Formats the match phase.
 * Example: "group" -> "Grupo A" (if group is known) or "GRUPO"
 */
export function formatMatchPhase(phase: string): string {
  if (!phase) return "GRUPO";
  
  // Capitalize first letter: "group" -> "Group"
  const capitalized = phase.charAt(0).toUpperCase() + phase.slice(1).toLowerCase();
  
  // If it contains "group", translate to "Grupo"
  if (capitalized.toLowerCase().includes('group')) {
    return capitalized.replace(/group/i, 'Grupo');
  }
  
  return capitalized.toUpperCase();
}
