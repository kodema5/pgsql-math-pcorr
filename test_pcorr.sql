create or replace function math.test_pcorr() returns setof text as $$
declare
    arr_a1 numeric array = array[1,2,.3];
    arr_a2 numeric array = array[1,.2,.3];
    arr_a numeric array = arr_a1 || arr_a2;

    arr_b1 numeric array = array[0,1,.5];
    arr_b2 numeric array = array[0,1,.5];
    arr_b numeric array = arr_b1 || arr_b2;

    c1 math.pcorr_t;
    c2 math.pcorr_t;
    p math.pcorr_t;
    s math.pcorr_t;
    c numeric;
begin

    with foo as (select unnest(arr_a) x, unnest(arr_b) y)
    select corr(x,y) into c from foo;

    with foo as (select unnest(arr_a) x, unnest(arr_b) y)
    select (pcorr(x,y)).* into p from foo;

    return next ok( math.equ(c,p::numeric), 'corr and pcorr are equiv');

    with foo as (select unnest(arr_a1) x, unnest(arr_b1) y)
    select (pcorr(x,y)).* into c1 from foo;

    with foo as (select unnest(arr_a2) x, unnest(arr_b2) y)
    select (pcorr(x,y)).* into c2 from foo;

    return next ok(c1 + c2 = p, 'can add two math.pcorr_t');

    select (sum(x)).* into s
    from (select unnest(array[c1,c2]) x) foo;

    return next ok(s = p, 'can aggregate sum');
end;
$$ language plpgsql;