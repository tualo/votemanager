
CREATE OR REPLACE PROCEDURE `cleanup_wahlschein_history`()
BEGIN
    DECLARE limit_size INT DEFAULT 1000;
    DECLARE counter INT DEFAULT 0; 
    DECLARE startoffset INT DEFAULT 0; 

    for looper in ( with x as (
        select 
            id,
            row_number() over (order by id) x,
            if ( (row_number() over (order by id)) % limit_size =1,1,0) doit
        from 
            wahlschein
        )
        select x.*  from x where doit = 1
    ) do
        -- select concat("Loop ",counter) as info;

        drop temporary table if exists w;

        set startoffset = counter*limit_size;
        create temporary table w as 
            with w as (
                select id from wahlschein  order by id limit startoffset, limit_size
            ),
            a as (select uid, wahlscheinstatus, updated_at, id , row_number() over (partition by id order by updated_at) as rank from wahlschein_history where id in (select id from w) ),
            b as ( select id,max(rank) max_rank from a group by id)
            select 
                a.uid, 
                a.wahlscheinstatus, 
                a.id, 
                a.updated_at, 
                a.rank,
                if(a.rank in ( 1, b.max_rank ),1,0) keep 
                    
            from 
                a 
                join b on a.id = b.id
        ;
        -- select uid from w where keep = 0;
        delete from wahlschein_history where uid in ( select uid from w where keep = 0 );
        set counter = counter + 1;

    end for;


END




CREATE OR REPLACE PROCEDURE `cleanup_wahlschein_history_single`()
BEGIN
    DECLARE limit_size INT DEFAULT 1000;
    DECLARE counter INT DEFAULT 0; 
    DECLARE startoffset INT DEFAULT 0; 

    for looper in (  
        select 
            id
        from 
            wahlschein
        -- limit 1000
         
    ) do
        -- select concat("Loop ",counter) as info;

        drop temporary table if exists w;

        set startoffset = counter*limit_size;
        create temporary table w as 
            with w as (
                select id from wahlschein  order by id limit startoffset, limit_size
            ),
            a as (select uid, wahlscheinstatus, updated_at, id , row_number() over (partition by id order by updated_at) as rank from wahlschein_history 
            where id = looper.id),   
            b as ( select id,max(rank) max_rank from a group by id)
            select 
                a.uid, 
                a.wahlscheinstatus, 
                a.id, 
                a.updated_at, 
                a.rank,
                if(a.rank in ( 1, b.max_rank ),1,0) keep 
                    
            from 
                a 
                join b on a.id = b.id
        ;
        
        for r in (select uid from w where keep = 0) do
            delete from wahlschein_history where wahlschein_history.uid = r.uid ;
        end for;
        set counter = counter + 1;

    end for;


END