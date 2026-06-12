-- ====================================================================
-- ARQUIVO 2: STORED FUNCTIONS (Mínimo 2 exigidas)
-- ====================================================================

USE HUBESPORTES;

DELIMITER //

-- FUNÇÃO 1: Mecanismo próprio de geração incremental e atômica de IDs
CREATE FUNCTION fn_proximo_id(p_nome_tabela VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_id INT;
    
    INSERT IGNORE INTO controle_sequencias (nome_tabela, ultimo_id) VALUES (p_nome_tabela, 0);
    
    UPDATE controle_sequencias 
    SET ultimo_id = ultimo_id + 1 
    WHERE nome_tabela = p_nome_tabela;
    
    SELECT ultimo_id INTO v_id FROM controle_sequencias WHERE nome_tabela = p_nome_tabela;
    
    RETURN v_id;
END //

-- FUNÇÃO 2: Verificação lógica de lotação de vagas de um evento
CREATE FUNCTION fn_evento_lotado(p_id_evento INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_disponiveis INT;
    SELECT vagas_disponiveis INTO v_disponiveis FROM Evento WHERE id_evento = p_id_evento;
    IF v_disponiveis <= 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END //

DELIMITER ;