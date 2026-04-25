# Wolfpack Stats - Deploy en Cloudflare Pages

## Configuración de Variables de Entorno

### Paso 1: Configurar en Cloudflare Pages Dashboard

1. Ve a tu proyecto en Cloudflare Pages
2. Click en **Settings** → **Environment variables**
3. Agrega estas variables:

```
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

4. Guarda los cambios

### Paso 2: Configurar Build Settings

En **Settings** → **Build & deployment**:

- **Build command:** `npm run build`
- **Build output directory:** `/`

### Paso 3: Deploy

Cada vez que haces push a Git, Cloudflare Pages:
1. Ejecuta `npm run build`
2. El script `build.js` genera `config.js` con tus credenciales
3. Deploya la app

## Desarrollo Local

### Opción A: Variables de entorno

```bash
export SUPABASE_URL=https://tu-proyecto.supabase.co
export SUPABASE_ANON_KEY=tu-anon-key
npm run build
npx serve .
```

### Opción B: Crear config.js manualmente

```bash
cp config.template.js config.js
# Edita config.js con tus credenciales
npx serve .
```

## Estructura de Archivos

```
wolfpack_stats/
├── index.html              # App principal
├── build.js                # Script de build (genera config.js)
├── package.json            # Config npm
├── config.template.js      # Template para desarrollo
├── config.js               # ⚠️ GENERADO AUTOMÁTICAMENTE - No editar
├── .gitignore              # Ignora config.js
├── supabase/
│   └── schema.sql          # Schema de BD
└── README.md
```

## Seguridad

- ✅ `config.js` está en `.gitignore` (no se sube a Git)
- ✅ Credenciales se inyectan desde variables de entorno
- ✅ Cloudflare Pages encripta las variables
- ✅ El build genera config.js en tiempo de deploy

## Troubleshooting

### Error: "Variables de entorno no encontradas"

Asegúrate de haber configurado `SUPABASE_URL` y `SUPABASE_ANON_KEY` en Cloudflare Pages dashboard.

### Error: "SUPABASE_CONFIG no definido"

El archivo `config.js` no se generó. Verifica que el build command sea `npm run build`.

## Soporte

Si tienes problemas, verifica:
1. Variables configuradas en Cloudflare Pages
2. Build command correcto
3. Schema SQL ejecutado en Supabase
