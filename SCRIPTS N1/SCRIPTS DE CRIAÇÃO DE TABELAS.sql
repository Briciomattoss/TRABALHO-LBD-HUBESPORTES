-- ==========================================
-- 					BASE
-- ==========================================

CREATE DATABASE HUBESPORTES;
-- DROP DATABASE HUBESPORTES;
USE HUBESPORTES;

-- ==========================================
-- 1. TABELAS BASE
-- ==========================================

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Senha VARCHAR(255) NOT NULL,
    tipo_usuario CHAR(1) NOT NULL,
    Numero VARCHAR(10) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    Cidade VARCHAR(80) NOT NULL,
    Bairro VARCHAR(80) NOT NULL,
    CEP CHAR(8) NOT NULL
);

CREATE TABLE Modalidade (
    id_modalidade INT PRIMARY KEY AUTO_INCREMENT,
    Nome_modalidade VARCHAR(50) NOT NULL
);

-- ==========================================
-- 2. TABELAS FILHAS (Herança de Usuário)
-- ==========================================

CREATE TABLE Organizador (
    id_usuario INT PRIMARY KEY,
    Credencial VARCHAR(50) NOT NULL,
    Telefone_1 VARCHAR(15) NOT NULL,
    Telefone_2 VARCHAR(15),
    CONSTRAINT fk_organizador_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Participante (
    id_usuario INT PRIMARY KEY,
    Interesses VARCHAR(255),
    Nivel_fidelidade INT DEFAULT 0,
    CONSTRAINT fk_participante_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

-- ==========================================
-- 3.	EVENTOS
-- ==========================================

CREATE TABLE Evento (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(100) NOT NULL,
    Data_hora DATETIME NOT NULL,
    Descricao TEXT NOT NULL,
    Cidade VARCHAR(80) NOT NULL,
    Bairro VARCHAR(80) NOT NULL,
    Numero VARCHAR(10) NOT NULL,
    Rua VARCHAR(100) NOT NULL,
    fk_id_organizador INT NOT NULL,
    fk_id_modalidade INT NOT NULL,
    CONSTRAINT fk_evento_organizador FOREIGN KEY (fk_id_organizador) REFERENCES Organizador(id_usuario),
    CONSTRAINT fk_evento_modalidade FOREIGN KEY (fk_id_modalidade) REFERENCES Modalidade(id_modalidade)
);

CREATE TABLE Historico_Status_Evento (
    id_historico INT PRIMARY KEY AUTO_INCREMENT,
    novo_status VARCHAR(30) NOT NULL,
    data_alteracao DATETIME NOT NULL,
    fk_id_evento INT NOT NULL,
    CONSTRAINT fk_historico_evento FOREIGN KEY (fk_id_evento) REFERENCES Evento(id_evento) ON DELETE CASCADE
);

CREATE TABLE Inscricao (
    id_inscricao INT PRIMARY KEY AUTO_INCREMENT,
    Valor_pago DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status_inscricao VARCHAR(30) NOT NULL,
    data_inscricao DATETIME NOT NULL,
    fk_id_evento INT NOT NULL,
    fk_id_usuario_participante INT NOT NULL,
    CONSTRAINT fk_inscricao_evento FOREIGN KEY (fk_id_evento) REFERENCES Evento(id_evento) ON DELETE CASCADE,
    CONSTRAINT fk_inscricao_participante FOREIGN KEY (fk_id_usuario_participante) REFERENCES Participante(id_usuario) ON DELETE CASCADE
);

-- ==========================================
-- 4. COMUNICAÇÃO E MURAL
-- ==========================================

CREATE TABLE Noticia (
    id_noticia INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(100) NOT NULL,
    Corpo_noticia TEXT NOT NULL,
    Data_publicacao DATETIME NOT NULL,
    fk_id_organizador INT NOT NULL,
    CONSTRAINT fk_noticia_organizador FOREIGN KEY (fk_id_organizador) REFERENCES Organizador(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Mensagem (
    id_mensagem INT PRIMARY KEY AUTO_INCREMENT,
    Conteudo_texto TEXT NOT NULL,
    Data_envio DATETIME NOT NULL,
    fk_id_evento INT NOT NULL,
    fk_id_participante INT NOT NULL,
    CONSTRAINT fk_mensagem_evento FOREIGN KEY (fk_id_evento) REFERENCES Evento(id_evento) ON DELETE CASCADE,
    CONSTRAINT fk_mensagem_participante FOREIGN KEY (fk_id_participante) REFERENCES Participante(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Denuncia (
    id_denuncia INT PRIMARY KEY AUTO_INCREMENT,
    Motivo TEXT NOT NULL,
    Data_denuncia DATETIME NOT NULL,
    Status_denuncia VARCHAR(20) NOT NULL,
    fk_id_participante INT NOT NULL,
    fk_id_mensagem INT NOT NULL,
    CONSTRAINT fk_denuncia_participante FOREIGN KEY (fk_id_participante) REFERENCES Participante(id_usuario),
    CONSTRAINT fk_denuncia_mensagem FOREIGN KEY (fk_id_mensagem) REFERENCES Mensagem(id_mensagem) ON DELETE CASCADE
);

-- ==========================================
-- 5. TABELAS DE ASSOCIAÇÃO (N:M)
-- ==========================================

CREATE TABLE Sobre (
    id_sobre INT PRIMARY KEY AUTO_INCREMENT,
    fk_Noticia_id_noticia INT NOT NULL,
    fk_Historico_Status_Evento_id_historico INT NOT NULL,
    CONSTRAINT fk_sobre_noticia FOREIGN KEY (fk_Noticia_id_noticia) REFERENCES Noticia(id_noticia) ON DELETE CASCADE,
    CONSTRAINT fk_sobre_historico FOREIGN KEY (fk_Historico_Status_Evento_id_historico) REFERENCES Historico_Status_Evento(id_historico) ON DELETE CASCADE
);

CREATE TABLE Prefere (
    id_prefere INT PRIMARY KEY AUTO_INCREMENT,
    fk_Usuario_id_usuario INT NOT NULL,
    fk_Modalidade_id_modalidade INT NOT NULL,
    CONSTRAINT fk_prefere_usuario FOREIGN KEY (fk_Usuario_id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_prefere_modalidade FOREIGN KEY (fk_Modalidade_id_modalidade) REFERENCES Modalidade(id_modalidade) ON DELETE CASCADE
);