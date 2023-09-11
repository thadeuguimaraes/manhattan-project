# Aqui está um guia passo a passo para executar uma aplicação Nodejs localmente com Docker, Terraform e acessar um banco de dados Postgres por meio do pgAdmin:

Este guia fornecerá instruções passo a passo sobre como configurar e executar uma aplicação Nodejs local usando Docker e Terraform. Certifique-se de que você já tenha o Docker e o Terraform instalados em sua máquina.

## Pré-requisitos

Certifique-se de que você tenha os seguintes pré-requisitos instalados em sua máquina:

- [Node.js](https://nodejs.org/en)
- [Docker](https://docs.docker.com/get-docker/)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Passo 1: Clone o Repositório

Clone o repositório da aplicação para o seu ambiente local:

```bash
git clone git@github.com:thadeuguimaraes/manhattan-project.git
cd repositorio
```

## Passo 2: Configure as Variáveis de Ambiente 
Defina as variáveis de ambiente necessárias para a aplicação. Normalmente, essas variáveis são definidas em um arquivo `.env`, mas pode variar dependendo do projeto.

## Passo 3: Crie as Imagens Docker para as Aplicações 

Antes de executar suas aplicações, você precisa criar as imagens Docker para o frontend e o backend. Siga estas etapas para fazer isso:
### 3.1: Frontend

Navegue até o diretório da aplicação frontend:

```bash
cd frontend
```
Agora, execute o seguinte comando para criar a imagem Docker:
```bash
docker build -t my-frontend-app:1.0 .
```
Isso criará uma imagem Docker chamada my-frontend-app com a tag 1.0. Certifique-se de ajustar os nomes e tags de acordo com suas preferências.

### 3.2: Backend

Navegue até o diretório da aplicação backend:
```bash
cd ../backend
```
Da mesma forma, execute o seguinte comando para criar a imagem Docker para o backend:

```bash
docker build -t my-backend-app:1.0 .
```
Isso criará uma imagem Docker chamada my-backend-app com a tag 1.0 para a aplicação backend.

Agora que você criou as imagens Docker para ambas as aplicações, você pode prosseguir com os passos anteriores para executar seus contêineres usando o Docker Compose.

Lembre-se de que esses comandos assumem que você tem um Dockerfile configurado corretamente em cada diretório de aplicação. Certifique-se de personalizar os nomes e tags das imagens conforme necessário para corresponder à sua configuração.

## Passo 4: Inicialize o Terraform para iniciar todos os contêineres Docker e conexões.

No diretório do terraform, execute o seguinte comando para inicializar o Terraform:


4.1
```bash
terraform init
```
Isso instalará quaisquer provedores ou módulos necessários para sua infraestrutura.

4.2
```bash
terraform fmt
```
O comando terraform fmt é usado para formatar (indentar e organizar) os arquivos de configuração do Terraform.
Isso ajuda a manter um estilo de código consistente em toda a equipe e torna os arquivos mais legíveis.

4.3
```bash
terraform validate
```
O comando terraform validate verifica a sintaxe e a semântica dos arquivos de configuração do Terraform.
Ele identifica erros comuns antes de aplicar qualquer alteração, economizando tempo e evitando problemas futuros.

4.4
```bash
terraform plan
```
Execute um plano do Terraform para verificar as alterações propostas em sua infraestrutura:Revise cuidadosamente o plano e verifique se ele reflete as alterações desejadas.
Quando estiver satisfeito com o plano, aplique as alterações à sua infraestrutura:

4.5
```bash
terraform apply
```
Confirme a aplicação digitando "yes" quando solicitado.
Esse comando também irá criar um arquivo chamado "ip_output.txt" contendo o endereço IP do container PostgreSQL. Iremos usar esse IP para configurar o "Register Server" no campo "Host name/address" do banco de dados.

## Passo 5: Acesse sua Aplicação
Abra um navegador da web e acesse sua aplicação através do endereço local ou do IP fornecido pelo Terraform.

localhost:8080 frontend
localhost:3000 backend
localhost:5050 pgAdmin

## Passo 6: Acesse o pgAdmin e o Banco de Dados PostgreSQL
1.Liste os contêineres em execução usando o seguinte comando Docker:

```bash
docker ps
```
1. Abra o pgAdmin no seu navegador da web e faça login com as credenciais fornecidas.
2. No painel do pgAdmin, clique em "Add New Server" para configurar a conexão com o PostgreSQL.
3. Na aba "General", forneça um nome para o servidor (pode ser qualquer nome descritivo).
4. Na aba "Connection", preencha as seguintes informações:
- Em "Host name/address", insira o endereço IP do contêiner PostgreSQL que você anotou no passo `4.5`.
- Certifique-se de que o campo "Port" esteja configurado para 5432 (a porta padrão do PostgreSQL).
- Em "Maintenence database", insira o nome do banco de dados que você configurou nas variáveis de ambiente ou no Docker Compose. Certifique-se de que corresponda ao nome do banco de dados que você deseja acessar.
- Em "Username", insira seu nome de usuário PostgreSQL.
- Em "Password", insira sua senha PostgreSQL.
5. Clique em "Save" para salvar as configurações do servidor.
6. Agora, você pode clicar no servidor recém-configurado no painel do pgAdmin e estabelecer uma conexão com o Banco de Dados PostgreSQL. Certifique-se de que as informações fornecidas correspondam às configurações do seu ambiente local.

Isso permitirá que você acesse o pgAdmin e se conecte ao Banco de Dados PostgreSQL localmente. Certifique-se de inserir as informações corretas para evitar problemas de conexão.

## Passo 8: Verificando a Tabela Criada com o Terraform

Após criar a tabela usando o script SQL definido no arquivo `main.tf` do Terraform, siga estas etapas para verificar se a tabela foi criada corretamente e visualizar os dados:

1. No painel de navegação à esquerda, expanda o servidor PostgreSQL que você acabou de adicionar.

2. Clique com o botão direito em "Servers(1)" e escolha o banco de dados que você deseja usar.

4. Navegue até "Databases" => "postgres" => "Schemas" => "public" => "Tables" => "Users" => "Columns" e verifique se os itens da tabela foram criados corretamente.

5. Clique com o botão direito em "Users" e selecione a opção "View/Edit Data" para visualizar os dados da tabela. Escolha a forma como você gostaria de visualizar a tabela, por exemplo, "View Data" ou "Edit Data" => All Rows, para realizar operações de visualização ou edição dos dados.

## Passo 9: Limpando Toda a Infraestrutura do Terraform e Docker

### No Terraform:
1.Abra um terminal e navegue até o diretório onde você possui seus arquivos do Terraform.
2.Execute o seguinte comando para destruir todos os recursos provisionados:
```bash
terraform destroy
```
3.O Terraform solicitará sua confirmação para destruir os recursos. Digite yes quando solicitado e pressione Enter.
4.Aguarde enquanto o Terraform remove todos os recursos. Isso pode levar algum tempo, dependendo da complexidade da infraestrutura.

### No Docker:
1.Abra um terminal e navegue até o diretório raiz do seu projeto, onde você possui seu o arquivo Dockerfile.
```bash
docker rmi -f $(docker images -a -q)
```
Isso removerá todas as imagens Docker no seu sistema.

Agora, toda a infraestrutura criada com o Terraform e os contêineres Docker relacionados ao seu projeto devem estar completamente limpos.

Certifique-se de que deseja prosseguir com essa operação, pois ela será irreversível e excluirá todos os recursos e dados associados à infraestrutura e aos contêineres Docker criados.
