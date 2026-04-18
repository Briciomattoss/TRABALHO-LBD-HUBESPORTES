-- ==========================================
-- SCRIPTS DE MANIPULAÇÃO: UPDATES
-- UPDATES EM RELAÇÃO AO EXEMPLO DOS 3 SELECTS
-- ==========================================

-- 1. O Participante Pedro Henrique pagou a inscrição do 'CorreFoFo'.
-- Atualiza o status para Confirmada e insere o valor pago.
UPDATE Inscricao 
SET status_inscricao = 'Confirmada', Valor_pago = 15.50 
WHERE id_inscricao = 3;

-- 2. O Organizador Daniel precisou adiar a pelada 'FutDosCrias' em 1 horinha.
UPDATE Evento 
SET Data_hora = '2026-05-15 20:00:00' 
WHERE id_evento = 2;

-- 3. O usuário Gabriel Ferreira trocou de número de telefone (atualizando o endereço/contato na tabela mãe).
UPDATE Usuario 
SET Numero = '35', Rua = 'Rua C Nova' 
WHERE id_usuario = 3;

