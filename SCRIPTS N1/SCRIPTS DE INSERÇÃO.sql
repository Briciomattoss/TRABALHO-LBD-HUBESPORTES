-- ==========================================
-- SCRIPTS DE INSERÇÃO DE DADOS (POPULAÇÃO)
-- ==========================================

-- 1. Modalidades
INSERT INTO Modalidade (Nome_modalidade) VALUES
('Futebol'),
('Corrida'),
('Ciclismo'),
('FutVôlei'), 
('Basquete');

-- 2. Inserindo os Usuários Base
-- Os IDs serão gerados automaticamente (1 a 5) - AUTO_INCREMENT
INSERT INTO Usuario (Nome, Email, Senha, tipo_usuario, Numero, Rua, Cidade, Bairro, CEP) VALUES
('Fabrício Matos de Sousa', 'fabricio@email.com', 'senha123', 'O', '10', 'Rua A', 'Brasília', 'Taguatinga', '70000000'),
('Daniel Fernandes', 'daniel@email.com', 'senha123', 'O', '20', 'Rua B', 'Brasília', 'Águas Claras', '71000000'),
('Gabriel Ferreira', 'gabriel@email.com', 'senha123', 'P', '30', 'Rua C', 'Brasília', 'Ceilândia', '72000000'),
('Pedro Henrique', 'pedro@email.com', 'senha123', 'P', '40', 'Rua D', 'Brasília', 'Plano Piloto', '73000000'),
('Lucas Santos', 'lucas@email.com', 'senha123', 'P', '50', 'Rua E', 'Brasília', 'Guará', '74000000');

-- 3. Definindo os Organizadores (Usuários 1 e 2)
INSERT INTO Organizador (id_usuario, Credencial, Telefone_1, Telefone_2) VALUES
(1, 'CREF-001', '61999991111', NULL),
(2, 'CREF-002', '61999992222', '61888882222');

-- 4. Definindo os Participantes (Usuários 3, 4 e 5)
INSERT INTO Participante (id_usuario, Interesses, Nivel_fidelidade) VALUES
(3, 'Futebol e Corrida', 10),
(4, 'Basquete e Ciclismo', 5),
(5, 'FutVôlei e Futebol', 20);

-- 5. Criando os Eventos 
-- (Relacionando os organizadores 1 e 2, e às modalidades cadastradas)
INSERT INTO Evento (Titulo, Data_hora, Descricao, Cidade, Bairro, Numero, Rua, fk_id_organizador, fk_id_modalidade) VALUES
('GrandVôlei', '2026-05-10 09:00:00', 'Torneio de FutVôlei da região. Tragam sua dupla!', 'Brasília', 'Taguatinga', 'S/N', 'Parque Ecológico', 1, 4),
('FutDosCrias', '2026-05-15 19:00:00', 'Pelada semanal dos crias. Nível amador.', 'Brasília', 'Ceilândia', '12', 'Quadra Central', 2, 1),
('CorreFoFo', '2026-05-20 07:00:00', 'Corrida matinal focada em iniciantes e bem-estar.', 'Brasília', 'Plano Piloto', 'S/N', 'Eixão do Lazer', 1, 2);

-- 6. Registrando o Histórico de Status dos Eventos recém-criados
INSERT INTO Historico_Status_Evento (novo_status, data_alteracao, fk_id_evento) VALUES
('Aberto', '2026-04-18 08:00:00', 1),
('Aberto', '2026-04-18 08:30:00', 2),
('Planejamento', '2026-04-18 09:00:00', 3);

-- 7. Realizando as Inscrições dos Participantes nos Eventos
INSERT INTO Inscricao (Valor_pago, status_inscricao, data_inscricao, fk_id_evento, fk_id_usuario_participante) VALUES
(50.00, 'Confirmada', '2026-04-18 10:00:00', 1, 5), -- Lucas inscrito no GrandVôlei
(0.00, 'Confirmada', '2026-04-18 11:30:00', 2, 3),  -- Gabriel inscrito no FutDosCrias
(15.50, 'Pendente', '2026-04-18 14:00:00', 3, 4);   -- Pedro inscrito no CorreFoFo

-- 8. Populando a tabela de Preferências (N:M entre Usuário e Modalidade)
INSERT INTO Prefere (fk_Usuario_id_usuario, fk_Modalidade_id_modalidade) VALUES
(3, 1), -- Gabriel prefere Futebol
(3, 2), -- Gabriel prefere Corrida
(4, 5), -- Pedro prefere Basquete
(5, 4); -- Lucas prefere FutVôlei