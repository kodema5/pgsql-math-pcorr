# pgsql-math-parallel-correlation

postgresql pcorr for calculating real-time correlation coefficient

## install

if pgtap is installed, it unit-tests
```
psql -f index.sql
```

## synopsis

math.pcorr_t, T, stores the state of correlations

T::numeric returns the correlation coefficients

pcorr(x,y) is an aggregate function that returns T

T + T combines correlation states

sum(T) is an aggregate function of T

## on real-time correlation

```
-- past periods correlation data
--
drop table history;
create table history (c math.pcorr_t);
with t as (
    select unnest(array[1,2,.3]) x, unnest(array[0,1,.5]) y)
insert into history (c)
    select pcorr(x,y) a from t;

-- current period data
--
drop table current;
create table current (x numeric, y numeric);
insert into current (x,y) values
    (1,0),
    (.2,1),
    (.3,.5);

-- real-time correlation
--
with hist as (select sum(c) a from history),
    curr as (select pcorr(x,y) a from current)
select (hist.a + curr.a)::numeric rt_corr
    from hist, curr;

        rt_corr
------------------------
 0.06482037235521644249
(1 row)
```

