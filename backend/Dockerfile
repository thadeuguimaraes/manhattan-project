# Use a imagem oficial do Node.js como base
FROM node:14

# Crie um diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o arquivo package.json e package-lock.json para o diretório de trabalho
COPY package*.json ./

#COPY nginx.conf /etc/nginx/conf.d/default.conf

# Instale as dependências da aplicação
RUN npm install

# Copie os arquivos da aplicação para o diretório de trabalho
COPY . .

# Exponha a porta em que a aplicação irá rodar (3000 no seu caso)
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "index.js"]
