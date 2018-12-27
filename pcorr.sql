
create or replace function math.pcorr(
    a math.pcorr_t,
    x numeric,
    y numeric
) returns math.pcorr_t as $$
begin
    a.n = coalesce(a.n, 0) + 1;
    a.xy = coalesce(a.xy, 0) + (x * y);
    a.xx = coalesce(a.xx, 0) + (x * x);
    a.yy = coalesce(a.yy, 0) + (y * y);
    a.sx = coalesce(a.sx, 0) + x;
    a.sy = coalesce(a.sy, 0) + y;
    return a;
end;
$$ language plpgsql strict immutable;


drop aggregate if exists pcorr(numeric,numeric);

create aggregate pcorr(
    numeric,
    numeric
) (
    sfunc = math.pcorr,
    stype = math.pcorr_t,
    initcond = '(0.,0.,0.,0.,0.,0.)'
);
