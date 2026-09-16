-- ============================================================
-- J.Lukas Barber Shop — Script de configuração do banco Supabase
-- Cole este script inteiro no SQL Editor do seu projeto Supabase
-- (Project > SQL Editor > New query) e clique em "Run".
-- ============================================================

create extension if not exists pgcrypto;

create table if not exists barbers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  specialty text,
  photo_url text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists services (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price numeric not null,
  duration_minutes integer not null default 30,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price numeric not null,
  description text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists appointments (
  id uuid primary key default gen_random_uuid(),
  barber_id uuid references barbers(id) on delete cascade,
  service_id uuid references services(id) on delete cascade,
  client_name text not null,
  client_contact text not null,
  contact_type text not null,
  appt_date date not null,
  appt_time text not null,
  status text not null default 'confirmado',
  cancel_reason text,
  created_at timestamptz not null default now()
);

-- RLS: como o painel do barbeiro não usa login de verdade (só uma senha
-- no front-end), liberamos leitura/escrita pública nessas tabelas via
-- chave anon — igual ao site original em que este projeto foi baseado.
alter table barbers enable row level security;
alter table services enable row level security;
alter table products enable row level security;
alter table appointments enable row level security;

drop policy if exists "public read barbers" on barbers;
drop policy if exists "public write barbers" on barbers;
drop policy if exists "public update barbers" on barbers;
drop policy if exists "public delete barbers" on barbers;
create policy "public read barbers" on barbers for select using (true);
create policy "public write barbers" on barbers for insert with check (true);
create policy "public update barbers" on barbers for update using (true);
create policy "public delete barbers" on barbers for delete using (true);

drop policy if exists "public read services" on services;
drop policy if exists "public write services" on services;
drop policy if exists "public update services" on services;
create policy "public read services" on services for select using (true);
create policy "public write services" on services for insert with check (true);
create policy "public update services" on services for update using (true);

drop policy if exists "public read products" on products;
drop policy if exists "public write products" on products;
drop policy if exists "public update products" on products;
drop policy if exists "public delete products" on products;
create policy "public read products" on products for select using (true);
create policy "public write products" on products for insert with check (true);
create policy "public update products" on products for update using (true);
create policy "public delete products" on products for delete using (true);

drop policy if exists "public read appointments" on appointments;
drop policy if exists "public write appointments" on appointments;
drop policy if exists "public update appointments" on appointments;
create policy "public read appointments" on appointments for select using (true);
create policy "public write appointments" on appointments for insert with check (true);
create policy "public update appointments" on appointments for update using (true);

-- ------------------------------------------------------------
-- Dados iniciais (pode editar/remover pelo próprio painel depois)
-- ------------------------------------------------------------

insert into barbers (name, specialty) values
  ('Lukas Ferreira', 'Cortes degradê, barba e sobrancelha'),
  ('Rafael Souza', 'Cortes clássicos e infantis');

insert into services (name, price, duration_minutes) values
  ('Corte militar', 30, 30),
  ('Corte militar reto', 30, 30),
  ('Corte personalizado', 30, 30),
  ('Cortes infantis', 30, 30),
  ('Corte com tesoura', 35, 40),
  ('Corte em degradê', 30, 30),
  ('Barba', 20, 20),
  ('Barbear com toalha quente', 60, 45),
  ('Tingimento de barba', 15, 15),
  ('Graxa', 20, 15);

insert into products (name, price, description) values
  ('Shaving Gel com menta', 40, 'Gel de barbear sem espuma, com mentol. Prepara e acalma a pele para um barbear suave e preciso.'),
  ('Amend hair spray fixação ultra forte', 55, 'Spray de fixação ultra forte e longa duração, ideal para finalizar penteados sem pesar nos fios.'),
  ('Hino''s Holy', 45, 'Óleo para cabelo 140ml. Para cabelos secos e desidratados, deixa o cabelo com aparência natural e brilhosa.');
