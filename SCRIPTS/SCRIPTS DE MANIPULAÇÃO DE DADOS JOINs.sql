-- ==========================================
-- SCRIPTS DE MANIPULAÇÃO: JOINs
-- ==========================================

-- 1. Quais são todos os eventos cadastrados e quem é o Organizador (Nome) de cada um?
SELECT e.Titulo, e.Data_hora, e.Bairro, u.Nome AS Nome_Organizador 
FROM Evento e 
INNER JOIN Organizador o ON e.fk_id_organizador = o.id_usuario
INNER JOIN Usuario u ON o.id_usuario = u.id_usuario;

-- 2. Quem são os participantes inscritos no evento 'FutDosCrias' (id_evento = 2)?
SELECT u.Nome, i.status_inscricao, i.Valor_pago 
FROM Inscricao i 
INNER JOIN Participante p ON i.fk_id_usuario_participante = p.id_usuario
INNER JOIN Usuario u ON p.id_usuario = u.id_usuario
WHERE i.fk_id_evento = 2;

-- 3. Quais são os esportes (Modalidades) favoritos do Gabriel Ferreira?
SELECT u.Nome, m.Nome_modalidade 
FROM Prefere pr
INNER JOIN Usuario u ON pr.fk_Usuario_id_usuario = u.id_usuario
INNER JOIN Modalidade m ON pr.fk_Modalidade_id_modalidade = m.id_modalidade
WHERE u.Nome = 'Gabriel Ferreira';

