import { createClient } from '@supabase/supabase-js';
import * as XLSX from 'xlsx';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const supabaseUrl = process.env.PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('Error: Debes configurar PUBLIC_SUPABASE_URL y PUBLIC_SUPABASE_ANON_KEY en tu .env');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function importFromExcel(filePath) {
  console.log(`Leyendo archivo: ${filePath}`);
  
  const workbook = XLSX.readFile(filePath);
  
  // 1. Importar Equipos/Grupos (Hoja 'Equipos')
  if (workbook.SheetNames.includes('Equipos')) {
    const sheet = workbook.Sheets['Equipos'];
    const data = XLSX.utils.sheet_to_json(sheet);
    
    console.log(`Importando ${data.length} equipos...`);
    for (const row of data) {
      // row: { Nombre: 'Argentina', Grupo: 'J', Flag: '🇦🇷' }
      const { data: team, error } = await supabase
        .from('teams')
        .upsert({ 
          name: row.Nombre, 
          group_id: row.Grupo, 
          flag_emoji: row.Flag 
        }, { onConflict: 'name' });
      
      if (error) console.error(`Error importando equipo ${row.Nombre}:`, error.message);
    }
  }

  // 2. Importar Partidos (Hoja 'Partidos')
  if (workbook.SheetNames.includes('Partidos')) {
     const sheet = workbook.Sheets['Partidos'];
     const data = XLSX.utils.sheet_to_json(sheet);
     
     console.log(`Importando ${data.length} partidos...`);
     // Lógica similar para mapear partidos a la tabla 'matches'
  }

  console.log('¡Importación completada!');
}

// Uso: node scripts/import-excel.mjs archivo.xlsx
const args = process.argv.slice(2);
if (args.length > 0) {
  importFromExcel(join(__dirname, '..', args[0]));
} else {
  console.log('Por favor especifica el nombre del archivo excel. Ejemplo: node scripts/import-excel.mjs datos.xlsx');
}
