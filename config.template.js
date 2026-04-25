# Configuración de Supabase

Este archivo contiene las credenciales de tu proyecto Supabase.

## Instrucciones

1. Crea un proyecto en [Supabase](https://supabase.com)
2. Ve a Project Settings → API
3. Copia la URL y la anon key
4. Reemplaza los valores aquí abajo

## Configuración

```javascript
const SUPABASE_CONFIG = {
    URL: 'https://tu-proyecto.supabase.co',
    ANON_KEY: 'tu-anon-key-aqui'
};

// Exportar para uso en la app
if (typeof module !== 'undefined') {
    module.exports = SUPABASE_CONFIG;
}
