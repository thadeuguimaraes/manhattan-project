# Use uma imagem base adequada para sua aplicação (exemplo: Node.js)
FROM node:14

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
