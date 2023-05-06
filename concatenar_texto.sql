CREATE OR REPLACE FUNCTION concatenar_textos(texto1 IN VARCHAR, texto2 IN VARCHAR)
RETURNS VARCHAR AS $$
BEGIN
  RETURN texto1 || texto2;
END;
$$ LANGUAGE plpgsql;
SELECT concatenar_textos('Bem vindo a tabela de filmes, ', 'use com gosto!') AS resultado;

