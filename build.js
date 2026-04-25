#!/usr/bin/env node

/**
 * Script de build para Cloudflare Pages
 * Genera config.js a partir de variables de entorno
 * 
 * Variables requeridas en Cloudflare Pages:
 * - SUPABASE_URL
 * - SUPABASE_ANON_KEY
 */

const fs = require('fs');
const path = require('path');

// Obtener variables de entorno
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

// Validar que existen las variables
if (!supabaseUrl || !supabaseKey) {
    console.error('❌ Error: Variables de entorno no encontradas');
    console.error('');
    console.error('Por favor configura en Cloudflare Pages:');
    console.error('  SUPABASE_URL=https://tu-proyecto.supabase.co');
    console.error('  SUPABASE_ANON_KEY=tu-anon-key');
    console.error('');
    console.error('O para desarrollo local:');
    console.error('  export SUPABASE_URL=...');
    console.error('  export SUPABASE_ANON_KEY=...');
    process.exit(1);
}

// Generar contenido de config.js
const configContent = `// Este archivo se genera automáticamente durante el build
// NO editar manualmente - usar variables de entorno

const SUPABASE_CONFIG = {
    URL: '${supabaseUrl}',
    ANON_KEY: '${supabaseKey}'
};

// Para debugging (quitar en producción si se desea)
console.log('[Config] Supabase URL configurada:', SUPABASE_CONFIG.URL);
`;

// Escribir el archivo
fs.writeFileSync(path.join(__dirname, 'config.js'), configContent);

console.log('✅ Build completado exitosamente');
console.log('📁 Generado: config.js');
console.log('🔧 Variables inyectadas desde entorno');
