select exists (select 1 from pg_available_extensions where name='pgtap') as has_pgtap
\gset
\if :has_pgtap

\ir equ.sql
\ir test_corr.sql
\ir test_pcorr.sql

select * from public.runtests('math'::name);

drop function if exists math.test_corr();
drop function if exists math.test_pcorr();

\endif


