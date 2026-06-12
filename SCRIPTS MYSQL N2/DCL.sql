-- ====================================================================
-- ARQUIVO 6: CONTROLE DE ACESSO AVANÇADO (DCL - ROLES E USUÁRIOS)
-- ====================================================================

USE HUBESPORTES;

-- 1. APURAÇÃO/REMOÇÃO DE USUÁRIOS E ROLES ANTIGOS (Para fins de reexecução)
DROP ROLE IF EXISTS 'role_admin_hub', 'role_organizador_hub', 'role_participante_hub';
DROP USER IF EXISTS 'usr_admin'@'localhost', 'usr_organizador'@'localhost', 'usr_participante'@'localhost', 'app_hubesportes'@'localhost';

-- 2. CRIAÇÃO DOS PAPÉIS DE ACESSO (ROLES)
CREATE ROLE 'role_admin_hub', 'role_organizador_hub', 'role_participante_hub';

-- 3. ATRIBUIÇÃO DE PRIVILÉGIOS DETALHADOS PARA CADA ROLE
-- Nível 1: Administrador (Controle total do banco de dados)
GRANT ALL PRIVILEGES ON HUBESPORTES.* TO 'role_admin_hub';

-- Nível 2: Organizador (Pode gerenciar Eventos, Notícias, Históricos e ler cadastros)
GRANT SELECT, INSERT, UPDATE, DELETE ON HUBESPORTES.Evento TO 'role_organizador_hub';
GRANT SELECT, INSERT, UPDATE, DELETE ON HUBESPORTES.Noticia TO 'role_organizador_hub';
GRANT SELECT, INSERT, UPDATE, DELETE ON HUBESPORTES.Historico_Status_Evento TO 'role_organizador_hub';
GRANT SELECT, INSERT, UPDATE, DELETE ON HUBESPORTES.Sobre TO 'role_organizador_hub';
GRANT SELECT ON HUBESPORTES.Usuarios TO 'role_organizador_hub';
GRANT SELECT ON HUBESPORTES.Participante TO 'role_organizador_hub';
GRANT SELECT ON HUBESPORTES.Modalidade TO 'role_organizador_hub';
GRANT SELECT ON HUBESPORTES.vw_relatorio_inscritos TO 'role_organizador_hub';
GRANT EXECUTE ON HUBESPORTES.* TO 'role_organizador_hub';

-- Nível 3: Participante / Atleta (Acesso restrito a inscrições, visualização de painéis e interações)
GRANT SELECT ON HUBESPORTES.Evento TO 'role_participante_hub';
GRANT SELECT ON HUBESPORTES.Modalidade TO 'role_participante_hub';
GRANT SELECT ON HUBESPORTES.vw_dashboard_vagas_eventos TO 'role_participante_hub';
GRANT SELECT, INSERT, UPDATE ON HUBESPORTES.Inscricao TO 'role_participante_hub';
GRANT SELECT, INSERT ON HUBESPORTES.Mensagem TO 'role_participante_hub';
GRANT INSERT ON HUBESPORTES.Denuncia TO 'role_participante_hub';
GRANT EXECUTE ON HUBESPORTES.* TO 'role_participante_hub';

-- 4. CRIAÇÃO DOS USUÁRIOS FÍSICOS
CREATE USER 'usr_admin'@'localhost' IDENTIFIED BY 'AdminMaster2026!';
CREATE USER 'usr_organizador'@'localhost' IDENTIFIED BY 'OrgEsportes@123';
CREATE USER 'usr_participante'@'localhost' IDENTIFIED BY 'AtletaSenha#2026';

-- 5. VINCULAÇÃO DOS USUÁRIOS AOS SEUS RESPECTIVOS PAPÉIS
GRANT 'role_admin_hub' TO 'usr_admin'@'localhost';
GRANT 'role_organizador_hub' TO 'usr_organizador'@'localhost';
GRANT 'role_participante_hub' TO 'usr_participante'@'localhost';

-- 6. CONFIGURAÇÃO DE ATIVAÇÃO AUTOMÁTICA DOS PAPÉIS NO LOGIN (Obrigatório no MySQL)
SET DEFAULT ROLE ALL TO 'usr_admin'@'localhost';
SET DEFAULT ROLE ALL TO 'usr_organizador'@'localhost';
SET DEFAULT ROLE ALL TO 'usr_participante'@'localhost';

