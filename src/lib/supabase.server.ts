import { createClient } from '@supabase/supabase-js';

// Cliente con Service Role para operaciones de servidor (admin)
// NUNCA exponer SUPABASE_SERVICE_ROLE_KEY en el cliente
const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabaseServiceKey = import.meta.env.SUPABASE_SERVICE_ROLE_KEY;
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

// Cliente anon para operaciones básicas del servidor
export const supabaseServer = createClient(supabaseUrl, supabaseAnonKey);

// Cliente con service role para admin (puede bypassear RLS)
export const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey || supabaseAnonKey);

/**
 * Crea un cliente autenticado con la sesión del usuario actual.
 * Usado en el Middleware para verificar la sesión.
 */
export function createServerSupabaseClient(accessToken: string) {
  return createClient(supabaseUrl, supabaseAnonKey, {
    global: {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    },
  });
}
