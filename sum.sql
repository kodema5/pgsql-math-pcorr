drop aggregate if exists sum(math.pcorr_t);

create aggregate public.sum (
    math.pcorr_t
) (
    sfunc = math.add,
    stype = math.pcorr_t,
    initcond = '(0,0,0,0,0,0)'
);

