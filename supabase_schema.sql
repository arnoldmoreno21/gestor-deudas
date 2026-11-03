-- =====================================================================
-- DEUDA CERO v9.0 - ESQUEMA DE BASE DE DATOS PARA SUPABASE
-- Desarrollado para Arnold Moreno • Trisagio Studios
-- =====================================================================
-- Instrucciones:
-- 1. Inicia sesión en https://supabase.com y abre tu proyecto.
-- 2. Ve a "SQL Editor" en el menú lateral izquierdo.
-- 3. Crea una "New Query", pega todo este contenido y presiona "Run" (▶).
-- =====================================================================

-- 1. Crear tabla principal para almacenar los workspaces
create table if not exists public.deuda_cero_workspaces (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at_ms bigint not null default 0,
  updated_at timestamptz default timezone('utc'::text, now())
);

-- Comentario explicativo en la tabla
comment on table public.deuda_cero_workspaces is 'Almacena los datos y sincronización en tiempo real del gestor de deudas (Deuda Cero).';

-- 2. Habilitar Row Level Security (RLS)
alter table public.deuda_cero_workspaces enable row level security;

-- 3. Crear política para permitir lectura y escritura con clave anon pública
drop policy if exists "Acceso anonimo total para Deuda Cero" on public.deuda_cero_workspaces;
create policy "Acceso anonimo total para Deuda Cero"
  on public.deuda_cero_workspaces
  for all
  using (true)
  with check (true);

-- 4. Habilitar la replicación en Tiempo Real (WebSockets de Supabase)
-- Esto permite que cualquier cambio en Mac se refleje al instante en iPhone y viceversa
do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'deuda_cero_workspaces'
  ) then
    alter publication supabase_realtime add table public.deuda_cero_workspaces;
  end if;
end $$;

-- 5. Crear índice para optimizar consultas por id
create index if not exists idx_deuda_cero_workspaces_id on public.deuda_cero_workspaces(id);
