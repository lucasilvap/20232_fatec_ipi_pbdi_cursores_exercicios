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

-- 1.3 Faça uma pesquisa sobre o anti-pattern chamado RBAR - Row By Agonizing Row. Explique com suas palavras do que se trata.

-- RBAR (Row By Agonizing Row) é um anti-pattern que se refere a um método de processamento de dados em que cada linha ou registro
-- de um conjunto de dados é processado de forma individual e sequencial. Isso significa que, em vez de aproveitar a capacidade de
-- processamento em lote dos sistemas de banco de dados e realizar operações em conjuntos de dados, cada linha é processada uma de cada vez.

-- Esse padrão é "agonizante" porque é ineficiente e geralmente leva a um desempenho ruim em operações que poderiam ser executadas
-- muito mais rapidamente em um conjunto de dados inteiro. É como "agonizar" sobre cada linha, processando-as uma por uma, em vez 
-- de realizar operações em massa.

-- Exemplos comuns de RBAR incluem o uso inadequado de loops em SQL ou linguagens de programação para iterar sobre resultados de 
-- consultas em vez de aproveitar as capacidades de conjunto de dados do banco de dados. Isso pode levar a consultas lentas e ineficientes
-- , especialmente em grandes conjuntos de dados.

-- A boa prática é evitar o RBAR sempre que possível e procurar maneiras de usar consultas SQL e operações em conjunto de dados para alcançar
-- o mesmo resultado de forma mais eficiente. Isso geralmente envolve o uso de agregações, junções e outras técnicas de consulta em SQL.
