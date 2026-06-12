-- ====================================================================
-- ARQUIVO 5: STORED PROCEDURES (Mínimo 2 exigidas)
-- ====================================================================

USE HUBESPORTES;

DELIMITER //

-- PROCEDURE 1: Inserção padronizada de usuários gerando chaves primárias via Function
CREATE PROCEDURE sp_cadastrar_usuarios(
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255),
    IN p_grupo INT,
    IN p_numero VARCHAR(10),
    IN p_rua VARCHAR(100),
    IN p_cidade VARCHAR(80),
    IN p_bairro VARCHAR(80),
    IN p_cep CHAR(8)
)
BEGIN
    DECLARE v_novo_id INT;
    SET v_novo_id = fn_proximo_id('Usuarios');
    
    INSERT INTO Usuarios (id_usuarios, Nome, Email, Senha, fk_id_grupo, Numero, Rua, Cidade, Bairro, CEP)
    VALUES (v_novo_id, p_nome, p_email, p_senha, p_grupo, p_numero, p_rua, p_cidade, p_bairro, p_cep);
END //

-- PROCEDURE 2: Exclusão lógica/física segura de inscrição e estorno automático de vaga
CREATE PROCEDURE sp_cancelar_inscricao(
    IN p_id_inscricao INT
)
BEGIN
    DECLARE v_id_evento INT;
    
    SELECT fk_id_evento INTO v_id_evento FROM Inscricao WHERE id_inscricao = p_id_inscricao;
    
    DELETE FROM Inscricao WHERE id_inscricao = p_id_inscricao;
    
    UPDATE Evento 
    SET vagas_disponiveis = vagas_disponiveis + 1 
    WHERE id_evento = v_id_evento;
END //

DELIMITER ;