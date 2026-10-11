-- Run in Supabase SQL Editor (once). All records require authentication.
create table if not exists public.coach_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  pgn text not null default '',
  notes jsonb not null default '{}'::jsonb,
  analyses jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.coach_data enable row level security;
revoke all on public.coach_data from anon;
grant select, insert, update, delete on public.coach_data to authenticated;
drop policy if exists "coach_select_own" on public.coach_data;
drop policy if exists "coach_insert_own" on public.coach_data;
drop policy if exists "coach_update_own" on public.coach_data;
drop policy if exists "coach_delete_own" on public.coach_data;
create policy "coach_select_own" on public.coach_data for select to authenticated using (auth.uid()=user_id);
create policy "coach_insert_own" on public.coach_data for insert to authenticated with check (auth.uid()=user_id);
create policy "coach_update_own" on public.coach_data for update to authenticated using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "coach_delete_own" on public.coach_data for delete to authenticated using (auth.uid()=user_id);
