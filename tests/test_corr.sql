create or replace function math.test_corr() returns setof text as $$
declare
    arr1 numeric array = '{1,2,.3,1,.2,.3}';
    arr2 numeric array = '{0,1,.5,0,1,.5}';
    a numeric;
    b numeric;
begin
    with foo as (select unnest(arr1) x, unnest(arr2) y)
    select corr(x,y)::numeric, pcorr(x,y)::numeric
    into a, b
    from foo;

    return next ok( math.equ(a,b), 'corr and pcorr are equiv');

    with foo as (select unnest(arr1) x, unnest(arr1) y)
    select corr(x,y)::numeric, pcorr(x,y)::numeric
    into a, b
    from foo;
    return next ok( a = 1 and b = 1, 'on same array, returns 1');
end;
$$ language plpgsql;