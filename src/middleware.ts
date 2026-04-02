import { defineMiddleware } from 'astro:middleware';
import { createClient } from '@supabase/supabase-js';

const ADMIN_EMAIL = import.meta.env.ADMIN_EMAIL;

export const onRequest = defineMiddleware(async (context, next) => {
  const { request, url, redirect, cookies } = context;
  const pathname = url.pathname;

  // Solo proteger rutas bajo /admin
  if (!pathname.startsWith('/admin')) {
    return next();
  }

  // Intentar obtener la sesión desde las cookies
  const accessToken = cookies.get('sb-access-token')?.value;
  const refreshToken = cookies.get('sb-refresh-token')?.value;

  if (!accessToken) {
    return redirect('/login?next=' + encodeURIComponent(pathname));
  }

  try {
    const supabase = createClient(
      import.meta.env.PUBLIC_SUPABASE_URL,
      import.meta.env.PUBLIC_SUPABASE_ANON_KEY,
    );

    const { data: { user }, error } = await supabase.auth.getUser(accessToken);

    if (error || !user) {
      return redirect('/login?next=' + encodeURIComponent(pathname));
    }

    // Verificar que sea el email admin correcto
    if (ADMIN_EMAIL && user.email !== ADMIN_EMAIL) {
      return redirect('/?error=unauthorized');
    }

    // Pasar el usuario al contexto para que las páginas lo usen
    context.locals.user = user;
    return next();

  } catch {
    return redirect('/login?next=' + encodeURIComponent(pathname));
  }
});
