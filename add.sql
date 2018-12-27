create or replace function math.add(
    a math.pcorr_t,
    b math.pcorr_t
)
returns math.pcorr_t as $$
begin
    a.n = a.n + b.n;
    a.xy = a.xy + b.xy;
    a.xx = a.xx + b.xx;
    a.yy = a.yy + b.yy;
    a.sx = a.sx + b.sx;
    a.sy = a.sy + b.sy;
    return a;
end;
$$ language plpgsql immutable strict;

create operator public.+ (
    leftarg = math.pcorr_t,
    rightarg = math.pcorr_t,
    procedure = math.add,
    commutator = +
);
