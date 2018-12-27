
create or replace function math.coeff(
    a math.pcorr_t
) returns numeric as $$
declare
    d numeric;
begin
    d = (a.n*a.xx-a.sx*a.sx)*(a.n*a.yy-a.sy*a.sy);

    if d = 0 then return null; end if;

    return ((a.n*a.xy)-(a.sx*a.sy))/sqrt(d);
end;
$$ language plpgsql immutable strict;

create cast ( math.pcorr_t as numeric )
    with function math.coeff(math.pcorr_t)
    as assignment;

