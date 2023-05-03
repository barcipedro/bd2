CREATE OR REPLACE FUNCTION obter_classificacao() RETURNS TABLE (nome_filme TEXT, classificacao TEXT) AS $$
DECLARE
    filme_cur CURSOR FOR SELECT nome, censura FROM filmes;
    filme_rec RECORD;
BEGIN
    FOR filme_rec IN filme_cur LOOP
        IF filme_rec.censura < 16 THEN
            RETURN NEXT (filme_rec.nome, 'infantil');
        ELSIF filme_rec.censura >= 16 AND filme_rec.censura < 18 THEN
            RETURN NEXT (filme_rec.nome, 'adolescente');
        ELSE
            RETURN NEXT (filme_rec.nome, 'adulto');
        END IF;
    END LOOP;
END;

