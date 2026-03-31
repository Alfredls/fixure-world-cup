# 🏆 World Cup 2026 Fixture & Dashboard

Una plataforma web de alto rendimiento, diseñada con una estética **Premium Broadcast-Style**, para seguir cada detalle del Mundial 2026. Este proyecto utiliza tecnologías de vanguardia para ofrecer una experiencia fluida, rápida y visualmente impactante.

![Banner Home](./public/docs/screenshots/home.png)

---

## ✨ Características Principales

### 📡 Resultados en Vivo (SSR)
La página de inicio utiliza **Server-Side Rendering (SSR)** para conectarse en tiempo real con Supabase. Esto permite mostrar marcadores, estados de partidos y próximos encuentros sin necesidad de recompilar la aplicación.

### 📅 Calendario Inteligente con Filtros Avanzados
Un calendario interactivo de tres columnas que permite navegar por todos los partidos del mes. Incluye:
- **Filtro por Grupo:** Visualiza solo los enfrentamientos de un grupo específico.
- **Búsqueda por Equipo:** Encuentra rápidamente cuándo juega tu selección favorita.
- **Reseteo Instantáneo:** Limpia todos los filtros con un solo clic.

![Calendario](./public/docs/screenshots/calendar.png)

### 📊 Grupos y Tablas de Posiciones
Visualización clara de todos los grupos del mundial. Las tablas de posiciones se generan estáticamente a partir de los datos de Supabase para garantizar una carga instantánea.

![Grupos](./public/docs/screenshots/groups.png)

### 🔗 Fase Final Interactiva (Brackets)
Un bracket interactivo de la fase de eliminación directa con soporte para **Zoom y Panning**. Visualiza el camino a la final con líneas de conexión dinámicas y una estética inspirada en las grandes cadenas de deportes.

![Fase Final](./public/docs/screenshots/history.png)

---

## 🛠️ Stack Tecnológico

- **Framework:** [Astro 6.0](https://astro.build/) (Modo Híbrido: SSR + Static)
- **Estilos:** [Tailwind CSS v4](https://tailwindcss.com/)
- **Base de Datos:** [Supabase](https://supabase.com/) (PostgreSQL + Realtime Ready)
- **Despliegue:** Optimizado para Node.js (Standalone)

---

## 🚀 Guía de Uso

### Instalación de Dependencias
```bash
npm install
```

### Desarrollo Local
Para iniciar el servidor de desarrollo en `http://localhost:4321`:
```bash
npm run dev
```

### Construcción para Producción
Genera una versión optimizada lista para desplegar:
```bash
npm run build
```

### Previsualización de Producción
```bash
npm run preview
```

---

## 🏗️ Arquitectura del Proyecto

El proyecto implementa una **Arquitectura Híbrida** para maximizar el rendimiento:
- **`src/pages/index.astro`**: Renderizado en servidor (`prerender = false`) para datos en vivo.
- **`src/pages/calendar.astro` & `src/pages/groups.astro`**: Pre-renderizados estáticamente (`prerender = true`) para velocidad extrema.
- **`src/lib/db.ts`**: Capa de abstracción centralizada para todas las consultas a Supabase y manejo de Mocks.
- **`src/lib/flags.ts`**: Motor optimizado de resolución de banderas para evitar sobrecarga de memoria en el navegador.

---

## 🤖 Co-creación con IA

Este proyecto ha sido desarrollado con el apoyo de **Inteligencia Artificial Avanzada (Antigravity)**. La IA ha colaborado en:
- El diseño de la arquitectura híbrida SSR/Static.
- La implementación de algoritmos de filtrado dinámico en el cliente.
- La optimización de recursos y refactorización de código para escalabilidad.
- Generación de esta documentación técnica.

---

> [!IMPORTANT]
> **Seguridad:** Asegúrate de configurar correctamente las políticas de **RLS (Row Level Security)** en tu panel de Supabase para proteger los datos de escritura.
