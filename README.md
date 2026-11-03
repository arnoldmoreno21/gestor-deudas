# 💳 Deuda Cero v9.0 • Gestor Financiero Inteligente

> **Sincronización Cloud Real-Time con Supabase (PostgreSQL) + Despliegue en Vercel**  
> Desarrollado por **Arnold Moreno** • *Trisagio Studios* ([@arnoldporelmundo](https://instagram.com/arnoldporelmundo))

Una aplicación web progresiva y ejecutiva para gestionar deudas, tarjetas de crédito, compras en cuotas con o sin intereses, suscripciones y deudas compartidas entre amigos. Sincroniza al instante entre tu **Mac, iPhone, iPad y PC** usando **Supabase Realtime**.

---

## 🚀 Características Principales

- 💳 **Gestor Multitarjeta:** Tarjetas de crédito en Soles (PEN) y Dólares (USD), líneas de crédito, días de corte y fechas límite de pago.
- 📊 **Cálculo Financiero de Precisión:** Intereses compensatorios, TEA/TCEA, simulación de amortización tipo bola de nieve o avalancha.
- 👥 **División de Gastos con Amigos:** Registra compras donde amigos pagan una parte; visualiza cuánto te debe cada persona en tiempo real.
- ⚡ **Sincronización en Tiempo Real (Supabase):** Cualquier cambio guardado en tu Mac se actualiza automáticamente en tu iPhone sin necesidad de recargar la página.
- 🎨 **Estudio de Temas:** 9 paletas diseñadas al estilo Notion Dark, Cyberpunk, Obsidiana Gold, Esmeralda Financiero, y más.
- 📄 **Exportación:** Generación de reportes PDF limpios y exportación/importación completa en formato JSON.
- ☁️ **Despliegue Instantáneo en Vercel:** Listo para producción como sitio estático optimizado con `vercel.json`.

---

## ⚡ Conexión con Supabase (Paso a Paso)

Para activar la sincronización permanente y en vivo entre tu computadora y tu celular:

### 1. Crear Proyecto en Supabase
1. Ingresa a [supabase.com](https://supabase.com) y crea una cuenta gratuita si aún no tienes una.
2. Crea un **Nuevo Proyecto** (ej: `deuda-cero-db`).

### 2. Ejecutar el Script SQL
1. En el menú lateral izquierdo de Supabase, entra a **SQL Editor**.
2. Haz clic en **New Query**.
3. Copia y pega el contenido del archivo [`supabase_schema.sql`](./supabase_schema.sql) y presiona el botón **Run** (▶):

```sql
-- Crear tabla principal
create table if not exists public.deuda_cero_workspaces (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at_ms bigint not null default 0,
  updated_at timestamptz default timezone('utc'::text, now())
);

-- Habilitar RLS
alter table public.deuda_cero_workspaces enable row level security;

-- Política de lectura y escritura anónima
create policy "Acceso anonimo total para Deuda Cero"
  on public.deuda_cero_workspaces
  for all
  using (true)
  with check (true);

-- Habilitar WebSockets en Tiempo Real
alter publication supabase_realtime add table public.deuda_cero_workspaces;
```

### 3. Obtener tus Credenciales
1. En Supabase, ve a **Project Settings** (⚙️) > **API**.
2. Copia:
   - **Project URL** (ej: `https://xyzabcdefgh.supabase.co`)
   - **anon public key** (ej: `eyJhbGciOi...`)

### 4. Conectar en la Aplicación
Tienes **3 opciones sencillas** para configurarlo:

- **Opción A (Desde la App Web):**  
  Abre la app en el navegador, haz clic en **"⚡ Base de Datos Cloud (Supabase / Vercel)"**, pega tu URL y Anon Key y haz clic en **"🔌 Probar y Conectar Supabase"**. Se guardará en el navegador.

- **Opción B (Descargar con Credenciales Incrustadas):**  
  En ese mismo modal, presiona **"📥 Descargar index.html con Supabase Incrustado"** y sube ese archivo a tu Vercel.

- **Opción C (Archivo local de configuración):**  
  Copia el archivo `supabase-config.example.js` como `supabase-config.js` y coloca tus credenciales allí.

---

## 🌐 Despliegue en Vercel

### Método 1: Conectar Repositorio de GitHub (Recomendado)
1. Sube este repositorio a tu cuenta de GitHub (ver sección de GitHub abajo).
2. Entra a [vercel.com](https://vercel.com) e inicia sesión con tu cuenta de GitHub.
3. Haz clic en **Add New...** > **Project**.
4. Selecciona tu repositorio `gestor-deudas`.
5. En **Framework Preset**, déjalo en **Other** (el archivo `vercel.json` se encarga de todo automáticamente).
6. Presiona **Deploy**. ¡Listo! Cada vez que hagas `git push`, tu web se actualizará sola.

### Método 2: Vercel CLI
```bash
npm install -g vercel
vercel deploy --prod
```

---

## 🐙 Repositorio en GitHub

Para subir este proyecto a tu GitHub:

```bash
# 1. Asegúrate de estar en la carpeta del proyecto
cd /Users/arnoldmoreno21/Antigravity/gestor-deudas

# 2. Agregar los archivos y hacer commit inicial
git add .
git commit -m "feat: Deuda Cero v9.0 con integración Supabase Realtime y despliegue Vercel"

# 3. Vincular con tu repositorio en GitHub (crea antes el repo en github.com/new)
git branch -M main
git remote add origin https://github.com/TU_USUARIO_GITHUB/gestor-deudas.git

# 4. Subir los cambios
git push -u origin main
```

---

## 🛠️ Estructura del Proyecto

```text
gestor-deudas/
├── index.html                  # Aplicación completa Single-Page (React, Tailwind, Supabase)
├── supabase_schema.sql         # Script SQL listo para ejecutar en Supabase
├── supabase-config.example.js  # Plantilla para configuración local de Supabase
├── vercel.json                 # Configuración de despliegue y seguridad para Vercel
├── .gitignore                  # Exclusión de archivos locales y credenciales
└── README.md                   # Documentación completa del proyecto
```

---

## 👨‍💻 Créditos
- **Creador:** Arnold Moreno ([@arnoldporelmundo](https://instagram.com/arnoldporelmundo))
- **Estudio:** Trisagio Studios
