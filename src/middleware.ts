import { defineMiddleware } from 'astro:middleware';
import { createClient } from '@supabase/supabase-js';

const ADMIN_EMAIL = import.meta.env.ADMIN_EMAIL;

export const onRequest = defineMiddleware(async (context, next) => {
  const { url, redirect, cookies } = context;
  const pathname = url.pathname;

  // Solo proteger rutas bajo /admin
  if (!pathname.startsWith('/admin')) {
    return next();
  }

  // Sin sesión → inicio (no se revela que existe un panel admin)
  const accessToken = cookies.get('sb-access-token')?.value;
  if (!accessToken) {
    return redirect('/');
  }

  try {
    const supabase = createClient(
      import.meta.env.PUBLIC_SUPABASE_URL,
      import.meta.env.PUBLIC_SUPABASE_ANON_KEY,
    );

    const { data: { user }, error } = await supabase.auth.getUser(accessToken);

    // Token inválido o expirado → inicio
    if (error || !user) {
      return redirect('/');
    }

    // Email no coincide con el admin configurado → inicio
    if (ADMIN_EMAIL && user.email !== ADMIN_EMAIL) {
      return redirect('/');
    }

    // Sesión válida → mostrar panel
    context.locals.user = user;
    return next();

  } catch {
    return redirect('/');
  }
});
