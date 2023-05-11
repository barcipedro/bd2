---- QUESTÃO 1
DROP FUNCTION IF EXISTS classificar();

CREATE OR REPLACE FUNCTION classificar()
RETURNS TABLE (nome VARCHAR, classificacao VARCHAR)
AS $$
DECLARE
    filme_atual filme%ROWTYPE;
    cursor_filmes CURSOR FOR SELECT * FROM filme;
BEGIN
    OPEN cursor_filmes;
    LOOP
        FETCH cursor_filmes INTO filme_atual;
        EXIT WHEN NOT FOUND;
        
        IF filme_atual.censura < 16 THEN
            classificacao := 'Infantil';
        ELSIF filme_atual.censura >= 16 AND filme_atual.censura < 18 THEN
            classificacao := 'Adolescente';
        ELSE
            classificacao := 'Adulto';
        END IF;
        
        nome := filme_atual.nome;
        
        RETURN NEXT;
    END LOOP;
    
    CLOSE cursor_filmes;
END;
$$ LANGUAGE plpgsql;
