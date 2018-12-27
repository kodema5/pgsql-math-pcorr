create or replace function math.equ (
    a numeric,
    b numeric,
    e numeric default 1e-10
) returns boolean as $$
    select abs(a-b)<e
$$ language sql strict immutable;
