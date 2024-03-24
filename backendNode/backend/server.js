const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

// Configuração do banco de dados
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '@Inspiron1',
    database: 'db_assistente'
});

// Conectando ao banco de dados
db.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('Conectado ao banco de dados MySQL');
});

const app = express();

// Aqui aplicamos o CORS de maneira global
app.use(cors());

// Definindo a rota GET para /notebooks
app.get('/notebooks', (req, res) => {
    let sql = 'SELECT * FROM notebooks';
    db.query(sql, (err, results) => {
        if (err) throw err;
        res.send(results);
    });
});

// Iniciando o servidor
const PORT = process.env.PORT || 8000;
app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});
