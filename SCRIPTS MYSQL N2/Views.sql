-- ====================================================================
-- ARQUIVO 4: VIEWS (Mínimo 2 exigidas)
-- ====================================================================

-- VIEW 1: Relatório consolidado para listagem de inscrições na interface administrativa
USE HUBESPORTES;

CREATE VIEW vw_relatorio_inscritos AS
SELECT 
    i.id_inscricao,
    e.Titulo AS Nome_Evento,
    e.Data_hora AS Data_Evento,
    e.Cidade AS Cidade_Evento,
    u.Nome AS Nome_Participante,
    u.Email AS Email_Participante,
    i.status_inscricao AS Status_Inscricao,
    i.data_inscricao AS Data_Inscricao
FROM Inscricao i
INNER JOIN Evento e ON i.fk_id_evento = e.id_evento
INNER JOIN Usuarios u ON i.fk_id_usuarios_participante = u.id_usuarios;

-- VIEW 2: Dashboard de vagas em tempo real por modalidade para a tela do usuário comum
CREATE VIEW vw_dashboard_vagas_eventos AS
SELECT 
    e.Titulo AS Evento,
    m.Nome_modalidade AS Modalidade,
    e.vagas_totais AS Capacidade_Maxima,
    e.vagas_disponiveis AS Vagas_Restantes,
    GROUP_CONCAT(u.Nome SEPARATOR ', ') AS Participantes
FROM Evento e
JOIN Modalidade m ON e.fk_id_modalidade = m.id_modalidade
LEFT JOIN Inscricao i ON e.id_evento = i.fk_id_evento
LEFT JOIN Usuarios u ON i.fk_id_usuarios_participante = u.id_usuarios
GROUP BY e.id_evento, e.Titulo, m.Nome_modalidade, e.vagas_totais, e.vagas_disponiveis;



