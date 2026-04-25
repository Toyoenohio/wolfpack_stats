# Wolfpack Stats

App para estadísticas de voleibol.

## Configuración Segura

⚠️ **IMPORTANTE:** Las credenciales de Supabase NO deben subirse a Git.

### Pasos de instalación:

1. **Crear proyecto en Supabase**
   - Ve a https://supabase.com
   - Crea nuevo proyecto
   - Ve a SQL Editor y ejecuta `supabase/schema.sql`

2. **Configurar credenciales**
   ```bash
   cp config.template.js config.js
   ```
   - Edita `config.js` con tus credenciales de Supabase:
     - URL: Project Settings → API → Project URL
     - ANON_KEY: Project Settings → API → anon public

3. **Deploy**
   - Sube a Cloudflare Pages, Vercel, Netlify, etc.
   - Asegúrate de que `config.js` esté en el servidor
   - NUNCA subas `config.js` a Git (ya está en .gitignore)

## Estructura

```
wolfpack_stats/
├── index.html              # App principal
├── config.template.js      # Template de configuración
├── config.js               # TUS CREDENCIALES (no subir a Git)
├── supabase/
│   └── schema.sql          # Schema de base de datos
└── README.md
```

## Seguridad

- ✅ `config.js` está en `.gitignore` (no se sube a Git)
- ✅ Row Level Security (RLS) habilitado en tablas
- ✅ Políticas de acceso configuradas en Supabase
- ✅ Índices para optimizar consultas

## Stack

- HTML5 + Tailwind CSS
- Supabase (PostgreSQL)
- Vanilla JavaScript
