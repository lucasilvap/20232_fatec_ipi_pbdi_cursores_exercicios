-- 1.1 Escreva um cursor que exiba as variáveis rank e youtuber de toda 
-- tupla que tiver video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.

DO $$
DECLARE
    cur_cursor REFCURSOR;
    tupla RECORD;
BEGIN
    OPEN cur_cursor SCROLL FOR
        SELECT rank, youtuber, video_count
        FROM tb_top_youtubers
        WHERE video_count >= 1000
        AND (category LIKE '%Sports%' OR category LIKE '%Music%'); 

    LOOP
        FETCH cur_cursor INTO tupla;
        EXIT WHEN NOT FOUND;
        -- Exibe Rank, Youtuber e Video Count
        RAISE NOTICE 'Rank: %, Youtuber: %, Video Count: %', tupla.rank, tupla.youtuber, tupla.video_count;
    END LOOP;

    CLOSE cur_cursor;
END;
$$


 --1.2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa:
DO $$
DECLARE
    cur_cursor REFCURSOR;
    tupla RECORD;
BEGIN
    OPEN cur_cursor SCROLL FOR
        SELECT youtuber
        FROM tb_top_youtubers
        ORDER BY youtuber;

    FETCH LAST FROM cur_cursor INTO tupla;

    WHILE FOUND
    LOOP
        RAISE NOTICE 'Youtuber: %', tupla.youtuber;
        FETCH PRIOR FROM cur_cursor INTO tupla;
    END LOOP;

    CLOSE cur_cursor;
END;
$$