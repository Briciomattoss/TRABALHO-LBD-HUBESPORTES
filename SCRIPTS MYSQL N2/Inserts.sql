-- ====================================================================
-- ARQUIVO 7: SEED COMPLETO DE DADOS (CARGA DE TESTE DO ECOSSISTEMA)
-- ====================================================================

USE HUBESPORTES;

-- Limpeza preventiva de dados anteriores (respeitando restrições de FK)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Prefere; TRUNCATE TABLE Sobre; TRUNCATE TABLE Denuncia;
TRUNCATE TABLE Mensagem; TRUNCATE TABLE Noticia; TRUNCATE TABLE Inscricao;
TRUNCATE TABLE Historico_Status_Evento; TRUNCATE TABLE Evento;
TRUNCATE TABLE Participante; TRUNCATE TABLE Organizador;
TRUNCATE TABLE Modalidade; TRUNCATE TABLE Usuarios;
TRUNCATE TABLE grupos_usuarios; TRUNCATE TABLE controle_sequencias;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Tabela: grupos_usuarios
INSERT INTO grupos_usuarios (id_grupo, nome_grupo, descricao) VALUES
(1, 'Administrador', 'Acesso irrestrito ao sistema'),
(2, 'Organizador', 'Gerenciador e criador de competições'),
(3, 'Participante', 'Atleta inscrito nas modalidades');

-- 2. Tabela: Modalidade
INSERT INTO Modalidade (id_modalidade, Nome_modalidade) VALUES
(1, 'Futebol de Campo'),
(2, 'Vôlei de Praia'),
(3, 'Basquete 3x3'),
(4, 'Corrida de Rua 10K');

-- 3. Tabela: Usuario (IDs manuais e estáticos para a carga inicial)
INSERT INTO Usuarios (id_usuarios, Nome, Email, Senha, fk_id_grupo, Numero, Rua, Cidade, Bairro, CEP) VALUES
(1, 'Carlos Eduardo', 'carlos.admin@hub.com', 'hash_senha_admin', 1, '10', 'Av. Central', 'Brasília', 'Asa Sul', '70000000'),
(2, 'Mariana Silva', 'mariana.org@hub.com', 'hash_senha_org', 2, '25B', 'Rua das Palmeiras', 'Ceilândia', 'Centro', '72200000'),
(3, 'Bruno Souza', 'bruno.atleta@gmail.com', 'hash_senha_part1', 3, '104', 'QNM 04 Conjunto C', 'Ceilândia', 'Norte', '72210040'),
(4, 'Aline Mendes', 'aline.mendes@gmail.com', 'hash_senha_part2', 3, 'S/N', 'Águas Claras Sul', 'Taguatinga', 'Sul', '71900000');

-- 4. Tabela: Organizador (Especialização de ID 2)
INSERT INTO Organizador (id_usuarios, Credencial, Telefone_1, Telefone_2) VALUES
(2, 'CREF-012345-G/DF', '(61) 98888-7777', '(61) 3333-4444');

-- 5. Tabela: Participante (Especialização de IDs 3 e 4)
INSERT INTO Participante (id_usuarios, Interesses, Nivel_fidelidade) VALUES
(3, 'Futebol, Corrida de Rua', 10),
(4, 'Vôlei de Praia, Basquete', 5);

-- 6. Tabela: Evento
INSERT INTO Evento (id_evento, Titulo, Data_hora, Descricao, Cidade, Bairro, Numero, Rua, fk_id_organizador, fk_id_modalidade, vagas_totais, vagas_disponiveis) VALUES
(1, 'Torneio de Verão de Vôlei', '2026-07-15 08:00:00', 'Grande torneio de vôlei de praia em duplas masculinas e femininas.', 'Brasília', 'Parque da Cidade', 'S/N', 'Estacionamento 04', 2, 2, 20, 20),
(2, 'Circuito Ceilândia de Corrida', '2026-08-20 07:00:00', 'Corrida rústica de 10 quilômetros pelas principais vias.', 'Ceilândia', 'Centro', '1', 'Praça do Trabalhador', 2, 4, 100, 100);

-- 7. Tabela: Historico_Status_Evento
INSERT INTO Historico_Status_Evento (id_historico, novo_status, data_alteracao, fk_id_evento) VALUES
(1, 'Criado', '2026-05-25 10:00:00', 1),
(2, 'Inscrições Abertas', '2026-05-26 09:00:00', 1);

-- 8. Tabela: Inscricao (Atletas se inscrevendo no Evento 1 - Vôlei)
-- Nota: Os gatilhos (triggers) criados no arquivo 03 vão rodar aqui e diminuir automaticamente as vagas de 20 para 18 no evento 1!
INSERT INTO Inscricao (id_inscricao, Valor_pago, status_inscricao, data_inscricao, fk_id_evento, fk_id_usuarios_participante) VALUES
(1, 50.00, 'Confirmada', '2026-05-27 14:22:00', 1, 3),
(2, 50.00, 'Pendente', '2026-05-28 11:05:00', 1, 4);

-- 9. Tabela: Noticia
INSERT INTO Noticia (id_noticia, Titulo, Corpo_noticia, Data_publicacao, fk_id_organizador) VALUES
(1, 'Abertura das inscrições do Vôlei', 'Estão abertas as vagas para o grande circuito de vôlei do Parque da Cidade.', '2026-05-26 09:15:00', 2);

-- 10. Tabela: Mensagem (Interação no mural do Evento 1)
INSERT INTO Mensagem (id_mensagem, Conteudo_texto, Data_envio, fk_id_evento, fk_id_participante) VALUES
(1, 'Alguém procurando dupla para o torneio de vôlei?', '2026-05-27 15:00:00', 1, 3),
(2, 'Link com propaganda enganosa enviado no privado por um bot.', '2026-05-28 08:30:00', 1, 4);

-- 11. Tabela: Denuncia (Atleta denunciando a mensagem ofensiva/bot de ID 2)
INSERT INTO Denuncia (id_denuncia, Motivo, Data_denuncia, Status_denuncia, fk_id_participante, fk_id_mensagem) VALUES
(1, 'Spam e links suspeitos enviados no mural de avisos.', '2026-05-28 09:00:00', 'Em Análise', 3, 2);

-- 12. Tabela: Sobre (N:M - Vincula a notícia ao histórico do evento)
INSERT INTO Sobre (id_sobre, fk_Noticia_id_noticia, fk_Historico_Status_Evento_id_historico) VALUES
(1, 1, 2);

-- 13. Tabela: Prefere (N:M - Preferências esportivas dos atletas)
INSERT INTO Prefere (id_prefere, fk_Usuarios_id_usuarios, fk_Modalidade_id_modalidade) VALUES
(1, 3, 1), -- Bruno prefere Futebol
(2, 4, 2); -- Aline prefere Vôlei

-- ====================================================================
-- 14. CRUCIAL: SINCRONIZAÇÃO DO CONTROLE DE SEQUÊNCIAS DE IDs
-- Como inserimos registros fixos, precisamos ajustar a tabela de controle
-- para que a função 'fn_proximo_id' saiba exatamente de onde continuar.
-- ====================================================================
INSERT INTO controle_sequencias (nome_tabela, ultimo_id) VALUES
('Usuarios', 4),
('Modalidade', 4),
('Evento', 2),
('Historico_Status_Evento', 2),
('Inscricao', 2),
('Noticia', 1),
('Mensagem', 2),
('Denuncia', 1),
('Sobre', 1),
('Prefere', 2);