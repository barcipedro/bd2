CREATE OR REPLACE FUNCTION fatorial(num IN INTEGER)
RETURNS INTEGER
AS
$$
DECLARE
    resultado INTEGER := 1;
    i INTEGER := 1;
BEGIN
    WHILE i <= num LOOP
        resultado := resultado * i;
        i := i + 1;
    END LOOP;
    RETURN resultado;
END;
$$
LANGUAGE plpgsql;
SELECT fatorial(6);
