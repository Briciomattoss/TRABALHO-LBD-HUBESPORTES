-- ==========================================
-- SELECTS (ANTES DO UPDATE)
-- ==========================================

-- 1. Verificando a Inscrição do Pedro Henrique (id_inscricao = 3)
-- Printar antes de confirmar o pagamento
SELECT id_inscricao, Valor_pago, status_inscricao, fk_id_usuario_participante 
FROM Inscricao 
WHERE id_inscricao = 3;

-- 2. Verificando o horário do evento 'FutDosCrias' (id_evento = 2)
-- Printar antes de Daniel adiar a pelada
SELECT id_evento, Titulo, Data_hora 
FROM Evento 
WHERE id_evento = 2;

-- 3. Verificando o endereço atual do Gabriel Ferreira (id_usuario = 3)
-- Printar antes da mudança de rua
SELECT id_usuario, Nome, Rua, Numero 
FROM Usuario 
WHERE id_usuario = 3;
