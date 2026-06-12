const express = require('express');
const mysql = require('mysql2');
const path = require('path');

const app = express();
const PORT = 3000;

// Configura o Express para servir os arquivos da interface de forma estática
app.use(express.static(path.join(__dirname, 'public')));

// Conexão segura utilizando as credenciais definidas no seu DCL.sql
const db = mysql.createConnection({
    host: 'localhost',
    user: 'usr_participante',
    password: 'AtletaSenha#2026',
    database: 'HUBESPORTES',
    port: 3306
});

db.connect((err) => {
    if (err) {
        console.error('❌ Erro de conexão no MySQL:', err.message);
        return;
    }
    console.log('🚀 Conectado com sucesso ao HUBESPORTES como "usr_participante"!');
});

// Endpoint da API que consome a VIEW requisitada
app.get('/api/vagas-eventos', (req, res) => {
    const query = 'SELECT * FROM vw_dashboard_vagas_eventos';
    
    db.query(query, (err, results) => {
        if (err) {
            console.error('Erro ao consultar a View:', err);
            return res.status(500).json({ error: 'Erro interno ao consultar dados do servidor.' });
        }
        res.json(results);
    });
});

app.listen(PORT, () => {
    console.log(`🌍 Servidor rodando em: http://localhost:${PORT}`);
});