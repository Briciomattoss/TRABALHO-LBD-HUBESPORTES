# 🏆 HUB ESPORTES

## 📌 Sobre o Projeto
O **HUB ESPORTES** é um software mobile idealizado para atuar como um centralizador de eventos esportivos por região. O sistema funciona como um ponto de encontro onde organizadores podem anunciar práticas esportivas (desde torneios amadores a aulas) e os moradores da comunidade podem encontrar essas atividades de forma organizada e acessível. A plataforma integra geolocalização para listar os eventos mais próximos ao usuário em tempo real.

A motivação principal é democratizar o acesso à informação sobre práticas esportivas, dando visibilidade a pequenos eventos locais e conectando jovens atletas, adultos e produtores em um ambiente simples e intuitivo.

## 👥 Equipe (Grupo 8)
* Fabrício Matos de Sousa
* Daniel Fernandes
* Gabriel Ferreira

## 🎓 Contexto Acadêmico
Projeto desenvolvido para a disciplina de **Laboratório de Banco de Dados** (3º Semestre do curso de Análise e Desenvolvimento de Sistemas) da **Universidade Católica de Brasília (UCB)**.
* **Professor:** Jefferson Salomão Rodrigues

## ⚙️ Escopo e Funcionalidades
* **Gestão de Usuários Especializada:** O sistema diferencia Organizadores (que gerenciam os anúncios) de Participantes (que buscam os eventos), cada um com atributos e responsabilidades específicas.
* **Controle de Eventos e Modalidades:** Criação e manutenção de eventos categorizados por modalidades esportivas (Futebol, Basquete, Ciclismo, etc.), permitindo que o usuário defina suas preferências.
* **Ciclo de Inscrição e Participação:** Gerenciamento completo das inscrições dos participantes em eventos, incluindo o controle de histórico de status e datas.
* **Comunicação e Suporte:** Sistema de chat interno (Mensagens) para tirar dúvidas diretamente com os organizadores, além de mecanismos de Denúncia para garantir a segurança da comunidade.
* **Mural de Informações e Notificações:** Exibição de um mural de notícias atualizado e avisos sobre os eventos.

## 🗄️ Modelagem do Banco de Dados
O banco de dados foi construído seguindo as melhores práticas de modelagem relacional:
1. **Modelo Conceitual (DER):** Desenvolvido no brModelo para mapeamento das regras de negócio.
2. **Modelo Lógico:** Tradução das cardinalidades, definição de chaves primárias (PK), chaves estrangeiras (FK) e resolução de heranças e relações N:M.
3. **Modelo Físico:** Scripts SQL com restrições de integridade (`NOT NULL`, `ON DELETE CASCADE`, etc.), focados na sintaxe do SGBD **MySQL**.

## 🚀 Como Executar
1. Clone este repositório em sua máquina local.
2. Abra o seu SGBD de preferência compatível com MySQL (ex: MySQL Workbench, DBeaver, HeidiSQL).
3. Execute o arquivo de **Criação de Tabelas** para gerar o banco de dados.
4. Execute o arquivo de **Inserção** para popular o banco com os usuários, modalidades e eventos iniciais.
5. Utilize os scripts de manipulação e junção (JOINs) para testar a extração de dados e validar as regras de negócio.
