import http from 'http';
import PG from 'pg';

const port = Number(process.env.PORT || 3000);
const user = process.env.POSTGRES_USER;
const pass = process.env.POSTGRES_PASSWORD;
const host = process.env.POSTGRES_HOST || 'postgres'; // Nome do serviço do contêiner do PostgreSQL
const db_port = process.env.POSTGRES_PORT || '5432'; // Porta padrão do PostgreSQL
const db_name = process.env.POSTGRES_DB;

const client = new PG.Client({
  user: user,
  password: pass,
  host: host,
  port: db_port,
  database: db_name,
});

let successfulConnection = false;

http.createServer(async (req, res) => {
  console.log(`Request: ${req.url}`);

  if (req.url === "/api") {
    client.connect()
      .then(() => { successfulConnection = true })
      .catch(err => console.error('Database not connected -', err.stack));

    res.setHeader("Content-Type", "application/json");
    res.writeHead(200);

    let result;

    try {
      result = (await client.query("SELECT * FROM users")).rows[0];
    } catch (error) {
      console.error(error);
    }

    const data = {
      database: successfulConnection,
      userAdmin: result?.role === "admin"
    }

    res.end(JSON.stringify(data));
  } else {
    res.writeHead(503);
    res.end("Internal Server Error");
  }

}).listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
