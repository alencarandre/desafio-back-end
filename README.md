# Desafio programação

Importador de CNAB.

Essa aplicação foi desenvolvida para trabalhar como micro-serviços, sendo os componentes:

- frontend
Responsável pela iteração com o usúario. Disponibiliza um mecanismo para importar um aquivo CNAB e visualizar os dados importados

- processing-file
Recebe o arquivo importado, faz o parse, valida e envia para salvar

- save-record
Recebe registro a registro do arquivo parseado e armazena no banco de dados. Também provê mecanismos para consulta dos dados gravados.

## Dependencias

- docker
- docker-compose

Certifique-se de que não há outras aplicações ocupando as seguintes portas:

- 8080
- 5432
- 6379
- 3000
- 3001
- 3002

## Setup inicial

Execute os comandos abaixo para criar os databases

```sh
docker-compose run --rm frontend sh bin/database
docker-compose run --rm save-record sh bin/database
```
## Executando a aplicação

```sh
docker-compose up
```

Após o download, build das images e inicio das aplicações, acesso 

[http://localhost:3000](http://localhost:3000)

## Considerações

Estou considerando um arquivo CNAB com 80 colunas. Menos que 80 colunas, não irá importar
