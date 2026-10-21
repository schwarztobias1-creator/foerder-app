-- Förderfinder: initial versioned benefit catalog (Supabase/PostgreSQL)
-- Only reviewed, published versions may be shown as authoritative.
create extension if not exists pgcrypto;

create table if not exists public.benefits (
 id uuid primary key default gen_random_uuid(),
 slug text not null unique,
 title text not null,
 jurisdiction text not null,
 category text not null,
 created_at timestamptz not null default now()
);

create table if not exists public.benefit_versions (
 id uuid primary key default gen_random_uuid(),
 benefit_id uuid not null references public.benefits(id) on delete cascade,
 version_number integer not null check (version_number > 0),
 valid_from date not null,
 valid_to date,
 status text not null default 'draft' check (status in ('draft','review_required','published','superseded')),
 summary text not null,
 rules jsonb not null default '{}'::jsonb,
 checked_at timestamptz,
 reviewed_at timestamptz,
 reviewer_note text,
 created_at timestamptz not null default now(),
 unique(benefit_id,version_number),
 check(valid_to is null or valid_to >= valid_from),
 check(status <> 'published' or (checked_at is not null and reviewed_at is not null))
);
create index if not exists benefit_versions_lookup on public.benefit_versions(benefit_id,status,valid_from,valid_to);

create table if not exists public.benefit_sources (
 id uuid primary key default gen_random_uuid(),
 benefit_version_id uuid not null references public.benefit_versions(id) on delete cascade,
 official_url text not null check (official_url ~ '^https://'),
 source_title text not null,
 accessed_at timestamptz,
 content_fingerprint text,
 created_at timestamptz not null default now()
);

create table if not exists public.source_checks (
 id uuid primary key default gen_random_uuid(),
 official_url text not null check (official_url ~ '^https://'),
 checked_at timestamptz not null default now(),
 result text not null check(result in ('unchanged','changed','unavailable','error')),
 fingerprint text,
 change_summary text,
 review_required boolean not null default false
);

alter table public.benefits enable row level security;
alter table public.benefit_versions enable row level security;
alter table public.benefit_sources enable row level security;
alter table public.source_checks enable row level security;

-- Public users see only benefits that have an approved version.
drop policy if exists "public benefit catalog" on public.benefits;
create policy "public benefit catalog" on public.benefits for select to anon, authenticated
 using (exists(select 1 from public.benefit_versions v where v.benefit_id=id and v.status='published'));
drop policy if exists "public published benefit versions" on public.benefit_versions;
create policy "public published benefit versions" on public.benefit_versions for select to anon, authenticated
 using (status='published');
drop policy if exists "public published sources" on public.benefit_sources;
create policy "public published sources" on public.benefit_sources for select to anon, authenticated
 using (exists(select 1 from public.benefit_versions v where v.id=benefit_version_id and v.status='published'));
-- No client-side policies for writes or source_checks. Use privileged server-side jobs.
-- Do not put service-role keys in browser JavaScript.
