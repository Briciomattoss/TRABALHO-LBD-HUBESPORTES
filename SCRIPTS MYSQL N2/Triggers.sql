-- ====================================================================
-- ARQUIVO 3: TRIGGERS (Mínimo 2 exigidas)
-- ====================================================================

USE HUBESPORTES;

DELIMITER //

-- TRIGGER 1: Validação preventiva antes de persistir uma inscrição
CREATE TRIGGER tg_valida_vagas_antes_inscricao
BEFORE INSERT ON Inscricao
FOR EACH ROW
BEGIN
    IF fn_evento_lotado(NEW.fk_id_evento) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Não há vagas disponíveis para este evento esportivo.';
    END IF;
END //

-- TRIGGER 2: Atualização automática de saldos após confirmação
CREATE TRIGGER tg_reduz_vagas_inscricao
AFTER INSERT ON Inscricao
FOR EACH ROW
BEGIN
    UPDATE Evento 
    SET vagas_disponiveis = vagas_disponiveis - 1 
    WHERE id_evento = NEW.fk_id_evento;
END //

DELIMITER ;