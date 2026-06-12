-- ====================================================================
-- ARQUIVO 1: ESTRUTURA DE TABELAS, RELACIONAMENTOS E ÍNDICES
-- ====================================================================

CREATE DATABASE HUBESPORTES;
USE HUBESPORTES;
-- Tabela de suporte para o sistema personalizado de geração de IDs
CREATE TABLE controle_sequencias (
    nome_tabela VARCHAR(50) PRIMARY KEY,
    ultimo_id INT NOT NULL DEFAULT 0
);

-- Tabela obrigatória para controle de permissões e agrupamento
CREATE TABLE grupos_usuarios (
    id_grupo INT PRIMARY KEY,
    nome_grupo VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

-- Entidade base de Usuários (sem AUTO_INCREMENT)
CREATE TABLE Usuarios (
    id_usuarios INT PRIMARY KEY, 
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL,
    fk_id_grupo INT NOT NULL,
    Numero VARCHAR(10) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    Cidade VARCHAR(80) NOT NULL,
    Bairro VARCHAR(80) NOT NULL,
    CEP CHAR(8) NOT NULL,
    CONSTRAINT fk_usuarios_grupo FOREIGN KEY (fk_id_grupo) REFERENCES grupos_usuarios(id_grupo)
);

-- Tabela de Domínio simples
CREATE TABLE Modalidade (
    id_modalidade INT PRIMARY KEY,
    Nome_modalidade VARCHAR(50) NOT NULL
);

-- Especialização: Organizador
CREATE TABLE Organizador (
    id_usuarios INT PRIMARY KEY,
    Credencial VARCHAR(50) NOT NULL,
    Telefone_1 VARCHAR(15) NOT NULL,
    Telefone_2 VARCHAR(15),
    CONSTRAINT fk_organizador_usuarios FOREIGN KEY (id_usuarios) REFERENCES Usuarios(id_usuarios) ON DELETE CASCADE
);

-- Especialização: Participante
CREATE TABLE Participante (
    id_usuarios INT PRIMARY KEY,
    Interesses VARCHAR(255),
    Nivel_fidelidade INT DEFAULT 0,
    CONSTRAINT fk_participante_usuarios FOREIGN KEY (id_usuarios) REFERENCES Usuarios(id_usuarios) ON DELETE CASCADE
);

-- Entidade: Evento
CREATE TABLE Evento (
    id_evento INT PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    Data_hora DATETIME NOT NULL,
    Descricao TEXT NOT NULL,
    Cidade VARCHAR(80) NOT NULL,
    Bairro VARCHAR(80) NOT NULL,
    Numero VARCHAR(10) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    fk_id_organizador INT NOT NULL,
    fk_id_modalidade INT NOT NULL,
    vagas_totais INT NOT NULL DEFAULT 50,
    vagas_disponiveis INT NOT NULL DEFAULT 50,
    CONSTRAINT fk_evento_organizador FOREIGN KEY (fk_id_organizador) REFERENCES Organizador(id_usuarios),
    CONSTRAINT fk_evento_modalidade FOREIGN KEY (fk_id_modalidade) REFERENCES Modalidade(id_modalidade)
);

-- Entidade: Histórico de Status
CREATE TABLE Historico_Status_Evento (
    id_historico INT PRIMARY KEY,
    novo_status VARCHAR(30) NOT NULL,
    data_alteracao DATETIME NOT NULL,
    fk_id_evento INT NOT NULL,
    CONSTRAINT fk_historico_evento FOREIGN KEY (fk_id_evento) REFERENCES Evento(id_evento) ON DELETE CASCADE
);

-- Entidade Crítica: Inscrição (sem AUTO_INCREMENT)
CREATE TABLE Inscricao (
    id_inscricao INT PRIMARY KEY, 
    Valor_pago DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status_inscricao VARCHAR(30) NOT NULL,
    data_inscricao DATETIME NOT NULL,
    fk_id_evento INT NOT NULL,
    fk_id_usuarios_participante INT NOT NULL,
    CONSTRAINT fk_inscricao_evento FOREIGN KEY (fk_id_evento) REFERENCES Evento(id_evento) ON DELETE CASCADE,
    CONSTRAINT fk_inscricao_participante FOREIGN KEY (fk_id_usuarios_participante) REFERENCES Participante(id_usuarios) ON DELETE CASCADE
);

-- Entidade: Notícia
CREATE TABLE Noticia (
    id_noticia INT PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    Corpo_noticia TEXT NOT NULL,
    Data_publicacao DATETIME NOT NULL,
    fk_id_organizador INT NOT NULL,
    CONSTRAINT fk_noticia_organizador FOREIGN KEY (fk_id_organizador) REFERENCES Organizador(id_usuarios) ON DELETE CASCADE
);

-- Entidade: Mensagem
CREATE TABLE Mensagem (
    id_mensagem INT PRIMARY KEY,
    Conteudo_texto TEXT NOT NULL,
    Data_envio DATETIME NOT NULL,
    fk_id_evento INT NOT NULL,
    fk_id_participante INT NOT NULL,
    CONSTRAINT fk_mensagem_evento FOREIGN KEY (fk_id_evento) REFERENCES Evento(id_evento) ON DELETE CASCADE,
    CONSTRAINT fk_mensagem_participante FOREIGN KEY (fk_id_participante) REFERENCES Participante(id_usuarios) ON DELETE CASCADE
);

-- Entidade Crítica: Denúncia (sem AUTO_INCREMENT)
CREATE TABLE Denuncia (
    id_denuncia INT PRIMARY KEY,
    Motivo TEXT NOT NULL,
    Data_denuncia DATETIME NOT NULL,
    Status_denuncia VARCHAR(20) NOT NULL,
    fk_id_participante INT NOT NULL,
    fk_id_mensagem INT NOT NULL,
    CONSTRAINT fk_denuncia_participante FOREIGN KEY (fk_id_participante) REFERENCES Participante(id_usuarios),
    CONSTRAINT fk_denuncia_mensagem FOREIGN KEY (fk_id_mensagem) REFERENCES Mensagem(id_mensagem) ON DELETE CASCADE
);

-- Tabela de Associação N:M - Sobre
CREATE TABLE Sobre (
    id_sobre INT PRIMARY KEY,
    fk_Noticia_id_noticia INT NOT NULL,
    fk_Historico_Status_Evento_id_historico INT NOT NULL,
    CONSTRAINT fk_sobre_noticia FOREIGN KEY (fk_Noticia_id_noticia) REFERENCES Noticia(id_noticia) ON DELETE CASCADE,
    CONSTRAINT fk_sobre_historico FOREIGN KEY (fk_Historico_Status_Evento_id_historico) REFERENCES Historico_Status_Evento(id_historico) ON DELETE CASCADE
);

-- Tabela de Associação N:M - Prefere
CREATE TABLE Prefere (
    id_prefere INT PRIMARY KEY,
    fk_Usuarios_id_usuarios INT NOT NULL,
    fk_Modalidade_id_modalidade INT NOT NULL,
    CONSTRAINT fk_prefere_usuario FOREIGN KEY (fk_Usuarios_id_usuarios) REFERENCES Usuarios(id_usuarios) ON DELETE CASCADE,
    CONSTRAINT fk_prefere_modalidade FOREIGN KEY (fk_Modalidade_id_modalidade) REFERENCES Modalidade(id_modalidade) ON DELETE CASCADE
);

-- Índices secundários para otimização de buscas recorrentes da aplicação
CREATE INDEX idx_usuarios_email ON Usuarios(Email);
CREATE INDEX idx_evento_data ON Evento(Data_hora);
CREATE INDEX idx_inscricao_participante ON Inscricao(fk_id_usuarios_participante);