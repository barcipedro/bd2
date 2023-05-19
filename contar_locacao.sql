CREATE PROCEDURE alocation ()
AS $$
DECLARE 
  aloca INT;
  f VARCHAR(100);
  cur CURSOR FOR SELECT nome, count(nome) as alocacoes from filme f, (SELECT COD_FILME FROM EXEMPLAR E, LOCACAO L WHERE L.COD_EXEMPLAR = E.COD_EXEMPLAR) a where  
f.COD_FILME = a.COD_FILME 
group by f.nome
ORDER BY f.nome ASC; 
BEGIN
  OPEN CUR;
  LOOP 
    FETCH NEXT IN CUR INTO f, aloca;
    EXIT WHEN NOT FOUND;
    RAISE INFO '% - %', f, aloca; 
  END LOOP;
  close cur;  
END;
$$ language plpgsql;
CALL alocation();
