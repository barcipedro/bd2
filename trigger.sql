----- QUESTAO 1
CREATE OR REPLACE FUNCTION atualizar_valor_locacao()
    RETURNS TRIGGER AS $$
BEGIN
    IF EXTRACT(DOW FROM NEW.dt_saida) = 6 THEN  
        NEW.preco_aplicado := NEW.preco_aplicado * 1.1; 
    ELSIF EXTRACT(DOW FROM NEW.dt_saida) = 1 THEN  
        NEW.preco_aplicado := NEW.preco_aplicado / 1.1; 
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_valor_locacao
    BEFORE INSERT ON locacao
    FOR EACH ROW
    EXECUTE FUNCTION atualizar_valor_locacao();

----- QUESTAO 2
CREATE TABLE log_locacoes_abaixo_sugerido (
    id SERIAL PRIMARY KEY,
    id_locacao INT,
    data_registro TIMESTAMP DEFAULT NOW(),
    mensagem TEXT
);

CREATE OR REPLACE FUNCTION registrar_log_locacao_abaixo_sugerido()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.preco_aplicado < NEW.preco_sugerido THEN
        INSERT INTO log_locacoes_abaixo_sugerido (id_locacao, mensagem)
        VALUES (NEW.id, 'Preço de locação abaixo do sugerido.');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_locacao_abaixo_sugerido
    AFTER INSERT ON locacao
    FOR EACH ROW
    EXECUTE FUNCTION registrar_log_locacao_abaixo_sugerido();


---QUESTAO 3


CREATE SEQUENCE profissional_cinema_id_seq;

CREATE OR REPLACE FUNCTION set_profissional_cinema_id()
    RETURNS TRIGGER AS $$
BEGIN
    NEW.cod_profissional_cinema := nextval('profissional_cinema_id_seq');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_auto_increment_id
    BEFORE INSERT ON profissional_cinema
    FOR EACH ROW
    WHEN (NEW.cod_profissional_cinema IS NULL)
    EXECUTE FUNCTION set_profissional_cinema_id();
