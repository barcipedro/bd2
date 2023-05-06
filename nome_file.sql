CREATE OR REPLACE FUNCTION nome_filme(cod NUMERIC)
RETURNS VARCHAR AS
$$
DECLARE
	nome_pt VARCHAR;
    nome_en VARCHAR;
BEGIN
    SELECT nome, nome_original INTO nome_pt, nome_en FROM filme WHERE cod_filme = cod;
    RETURN '|PT|' || nome_pt || ',|EN| ' || nome_en; 
END;
$$ LANGUAGE plpgsql;
