-- ==========================================
-- SCRIPTS DE MANIPULAÇÃO: SELECTS COM GROUP BY E ORDER BY 
-- ==========================================

-- 1. Qual é o total de inscritos em cada evento? 
-- (Agrupa pelo nome do evento e ordena do mais cheio para o mais vazio).
SELECT e.Titulo, COUNT(i.id_inscricao) AS Total_Inscritos 
FROM Evento e 
LEFT JOIN Inscricao i ON e.id_evento = i.fk_id_evento 
GROUP BY e.Titulo 
ORDER BY Total_Inscritos DESC;

-- 2. Quantos eventos existem cadastrados para cada Modalidade no sistema?
-- (Agrupa pela modalidade e ordena em ordem alfabética crescente - ASC).
SELECT m.Nome_modalidade, COUNT(e.id_evento) AS Quantidade_Eventos 
FROM Modalidade m 
LEFT JOIN Evento e ON m.id_modalidade = e.fk_id_modalidade 
GROUP BY m.Nome_modalidade 
ORDER BY m.Nome_modalidade ASC;