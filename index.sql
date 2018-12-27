\if :pgsql_math_pcorr
\else
\set pgsql_math_pcorr true

create schema if not exists math;

-- pcorr parallel correlation
drop type if exists math.pcorr_t cascade;
create type math.pcorr_t as (
    n numeric,
    xy numeric,
    xx numeric,
    yy numeric,
    sx numeric,
    sy numeric
);

\i pcorr.sql
\i coeff.sql
\i add.sql
\i sum.sql

\i test.sql

\endif