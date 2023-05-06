CREATE OR REPLACE FUNCTION par_impar(num IN INTEGER)
RETURNS VARCHAR
AS
$$
BEGIN
    IF num % 2 = 0 THEN
        RETURN 'Par';
    ELSE
        RETURN 'Ímpar';
    END IF;
END;
$$
LANGUAGE plpgsql;
SELECT par_impar(7);
