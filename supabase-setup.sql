-- ============================================================
-- J.Lukas Barber Shop — Script de configuração do banco Supabase
--
-- Rode este script no SQL Editor do projeto Supabase
-- (Dashboard > SQL Editor > New query > colar > Run).
--
-- IMPORTANTE: todas as tabelas têm o prefixo "jlukas_" justamente
-- para NÃO tocar nas tabelas do site antigo (barbers, services,
-- appointments) que já existem nesse mesmo projeto. Nada do outro
-- site é alterado ou apagado por este script.
-- ============================================================

create extension if not exists pgcrypto;

create table if not exists jlukas_barbers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  specialty text,
  photo_url text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists jlukas_services (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price numeric not null,
  duration_minutes integer not null default 30,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists jlukas_products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  price numeric not null,
  description text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists jlukas_appointments (
  id uuid primary key default gen_random_uuid(),
  barber_id uuid references jlukas_barbers(id) on delete cascade,
  service_id uuid references jlukas_services(id) on delete cascade,
  client_name text not null,
  client_contact text not null,
  contact_type text not null,
  appt_date date not null,
  appt_time text not null,
  status text not null default 'confirmado',
  cancel_reason text,
  created_at timestamptz not null default now()
);

-- RLS: como o painel do barbeiro não tem login de verdade (só uma senha no
-- front-end), a leitura/escrita é liberada via chave pública — mesmo modelo
-- do site em que este projeto foi baseado.
alter table jlukas_barbers enable row level security;
alter table jlukas_services enable row level security;
alter table jlukas_products enable row level security;
alter table jlukas_appointments enable row level security;

drop policy if exists "jlukas read barbers" on jlukas_barbers;
drop policy if exists "jlukas insert barbers" on jlukas_barbers;
drop policy if exists "jlukas update barbers" on jlukas_barbers;
drop policy if exists "jlukas delete barbers" on jlukas_barbers;
create policy "jlukas read barbers" on jlukas_barbers for select using (true);
create policy "jlukas insert barbers" on jlukas_barbers for insert with check (true);
create policy "jlukas update barbers" on jlukas_barbers for update using (true);
create policy "jlukas delete barbers" on jlukas_barbers for delete using (true);

drop policy if exists "jlukas read services" on jlukas_services;
drop policy if exists "jlukas insert services" on jlukas_services;
drop policy if exists "jlukas update services" on jlukas_services;
create policy "jlukas read services" on jlukas_services for select using (true);
create policy "jlukas insert services" on jlukas_services for insert with check (true);
create policy "jlukas update services" on jlukas_services for update using (true);

drop policy if exists "jlukas read products" on jlukas_products;
drop policy if exists "jlukas insert products" on jlukas_products;
drop policy if exists "jlukas update products" on jlukas_products;
drop policy if exists "jlukas delete products" on jlukas_products;
create policy "jlukas read products" on jlukas_products for select using (true);
create policy "jlukas insert products" on jlukas_products for insert with check (true);
create policy "jlukas update products" on jlukas_products for update using (true);
create policy "jlukas delete products" on jlukas_products for delete using (true);

drop policy if exists "jlukas read appointments" on jlukas_appointments;
drop policy if exists "jlukas insert appointments" on jlukas_appointments;
drop policy if exists "jlukas update appointments" on jlukas_appointments;
create policy "jlukas read appointments" on jlukas_appointments for select using (true);
create policy "jlukas insert appointments" on jlukas_appointments for insert with check (true);
create policy "jlukas update appointments" on jlukas_appointments for update using (true);

-- ------------------------------------------------------------
-- Dados iniciais (dá para editar/remover pelo painel do site depois).
-- O "where not exists" evita duplicar se você rodar o script de novo.
-- ------------------------------------------------------------

insert into jlukas_barbers (name, specialty)
select * from (values
  ('Lukas Ferreira', 'Cortes degradê, barba e sobrancelha'),
  ('Rafael Souza', 'Cortes clássicos e infantis')
) as v(name, specialty)
where not exists (select 1 from jlukas_barbers);

insert into jlukas_services (name, price, duration_minutes)
select * from (values
  ('Corte militar', 30, 30),
  ('Corte militar reto', 30, 30),
  ('Corte personalizado', 30, 30),
  ('Cortes infantis', 30, 30),
  ('Corte com tesoura', 35, 40),
  ('Corte em degradê', 30, 30),
  ('Barba', 20, 20),
  ('Barbear com toalha quente', 60, 45),
  ('Tingimento de barba', 15, 15),
  ('Graxa', 20, 15)
) as v(name, price, duration_minutes)
where not exists (select 1 from jlukas_services);

insert into jlukas_products (name, price, description)
select * from (values
  ('Shaving Gel com menta', 40, 'Gel de barbear sem espuma, com mentol. Prepara e acalma a pele para um barbear suave e preciso.'),
  ('Amend hair spray fixação ultra forte', 55, 'Spray de fixação ultra forte e longa duração, ideal para finalizar penteados sem pesar nos fios.'),
  ('Hino''s Holy', 45, 'Óleo para cabelo 140ml. Para cabelos secos e desidratados, deixa o cabelo com aparência natural e brilhosa.')
) as v(name, price, description)
where not exists (select 1 from jlukas_products);
