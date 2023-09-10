import http from 'http';
import PG from 'pg';
import dotenv from 'dotenv';

dotenv.config(); // Carrega as variáveis de ambiente do arquivo .env

const port = Number(process.env.PORT || 3000);
const user = process.env.POSTGRES_USER; 
const pass = process.env.POSTGRES_PW; 
const host = process.env.POSTGRES_HOST || 'postgres';
const db_port = process.env.POSTGRES_PORT || '5432';
const db_name = process.env.POSTGRES_DB;

const client = new PG.Client({
  user,
  password: pass,
  host,
  port: db_port,
  database: db_name,
});

let successfulConnection = false;

http.createServer(async (req, res) => {
  console.log(`Request: ${req.url}`);

  if (req.url === "/api") {
    try {
      await client.connect();
      const result = (await client.query("SELECT * FROM users")).rows[0];

      const data = {
        database: true, // A conexão bem-sucedida indica que o banco de dados está acessível
        userAdmin: result?.role === "admin",
      };

      res.setHeader("Content-Type", "application/json");
      res.writeHead(200);
      res.end(JSON.stringify(data));
    } catch (error) {
      console.error('Error:', error);
      res.writeHead(500); // Internal Server Error
      res.end("Internal Server Error");
    } finally {
      // Certifique-se de fechar a conexão com o banco de dados após o uso
      await client.end();
    }
  } else {
    res.writeHead(404); // Página não encontrada
    res.end("Not Found");
  }
}).listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
