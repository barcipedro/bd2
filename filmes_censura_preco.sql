DROP PROCEDURE IF EXISTS filmes_censura_preco;

CREATE OR REPLACE PROCEDURE filmes_censura_preco() AS $$
DECLARE
   cursor_filme CURSOR FOR SELECT nome, preco_sugerido_locacao, censura FROM filme FOR UPDATE;
   nome_filme VARCHAR(100);
   censura_filme INTEGER;
   preco NUMERIC;
   novo_preco NUMERIC;
BEGIN
    OPEN cursor_filme;
    RAISE info 'FILME - PRECO SUGERIDO';
    
    LOOP
       FETCH cursor_filme INTO nome_filme, preco, censura_filme;
       EXIT WHEN NOT FOUND;

       IF censura_filme = 12 THEN
           novo_preco := preco * 1.05;
           RAISE info '% - %', nome_filme, novo_preco;
           UPDATE filme 
           SET preco_sugerido_locacao = novo_preco 
           WHERE CURRENT OF cursor_filme;
       ELSIF censura_filme = 16 THEN
           novo_preco := preco * 1.1;
           RAISE info '% - %', nome_filme, novo_preco;
           UPDATE filme 
           SET preco_sugerido_locacao = novo_preco 
           WHERE CURRENT OF cursor_filme;
       ELSIF censura_filme = 18 THEN
           novo_preco := preco * 1.15;
           RAISE info '% - %', nome_filme, novo_preco;
           UPDATE filme 
           SET preco_sugerido_locacao = novo_preco 
           WHERE CURRENT OF cursor_filme;
       ELSE
           novo_preco := preco * 1.02;
           RAISE info '% - %', nome_filme, novo_preco;
           UPDATE filme 
           SET preco_sugerido_locacao = novo_preco 
           WHERE CURRENT OF cursor_filme;
       END IF;
    END LOOP;
    
    CLOSE cursor_filme;
END;
$$ LANGUAGE plpgsql;

CALL filmes_censura_preco();

SELECT * FROM filme;
