Claro, aqui está o texto formatado em Markdown.

# Comandos para Consulta e Manipulação de Dados no MongoDB

## 🚀 Preparação

O banco de dados MongoDB é configurado e inicializado via Docker Compose. Pode-se conectar a ele de duas maneiras:

### Via Terminal (mongosh)

Acesse a shell interativa do MongoDB dentro do contêiner com o seguinte comando:

```bash
mongosh -u user -p password --authenticationDatabase admin
```

Uma vez conectado, selecione a base de dados do projeto:

```javascript
use datadrivenstore;
```

### Via SGBD (Ferramenta Gráfica como MongoDB Compass)

Utilize os seguintes dados para se conectar ao banco de dados:

  * **Connection String:** `mongodb://user:password@localhost:27017/datadrivenstore?authSource=admin`
  * **Host:** `localhost`
  * **Porta:** `27017`
  * **Authentication Database:** `admin`
  * **Usuário (User):** `user`
  * **Senha (Password):** `password`
  * **Nome do Banco de Dados (Database):** `datadrivenstore`

## 📦 1. Estrutura de Dados e Importação

Os dados do MongoDB são armazenados em coleções (semelhantes a tabelas em SQL) como documentos BSON (formato binário do JSON). A importação inicial é feita pelo script `01_import_mongo_data.sh`.

### Coleções Principais

  * **pedidos:** Armazena o histórico completo de pedidos, incluindo dados do cliente, itens comprados, valores, status do pagamento e o histórico de cada etapa do processo.
  * **perfilUsuarios:** Contém dados ricos e flexíveis sobre os usuários, como preferências de marcas e categorias, dados demográficos e listas de desejos. Ideal para personalização e marketing.
  * **categoriaProdutos:** Mapeia a relação entre produtos e suas múltiplas categorias, permitindo uma organização de catálogo flexível.

## 2\. Consultas Essenciais para E-commerce

A seguir, uma seleção de consultas úteis para a aplicação de e-commerce, organizadas por coleção.

### Coleção: `pedidos`

```javascript
// Histórico de Pedidos de um Cliente Específico
// Encontra todos os pedidos do usuário com id "7" e os ordena do mais recente para o mais antigo.
db.pedidos.find({ idUsuario: "7" }).sort({ dataPedido: -1 });
```

```javascript
// Total de Vendas e Número de Pedidos num Período
// Calcula o valor total vendido e o número de pedidos realizados nos últimos 30 dias.
db.pedidos.aggregate([
  {
    $match: {
      dataPedido: {
        $gte: new Date(new Date().setDate(new Date().getDate() - 30))
      },
      status: { $nin: ["Cancelado", "Recusado"] }
    }
  },
  {
    $group: {
      _id: null,
      valorTotalVendido: { $sum: "$valorTotal" },
      numeroDePedidos: { $sum: 1 }
    }
  }
]);
```

### Coleção: `perfilUsuarios`

```javascript
// Ver a Lista de Desejos de um Cliente
// Retorna apenas a lista de desejos do usuário com id "1".
db.perfilUsuarios.findOne({ idUsuario: "1" }, { _id: 0, listaDesejos: 1 });
```

```javascript
// Encontrar Clientes para uma Campanha de Marketing Específica
// Segmenta clientes interessados em "Esportes" e na marca "Nike".
db.perfilUsuarios.find({
  "preferencias.categorias_interesse": "Esportes",
  "preferencias.marcas_favoritas": "Nike"
});
```

### Consultas Combinadas (`perfilUsuarios` e `categoriaProdutos`)

```javascript
// Recomendações de Produtos com Base em Categorias de Interesse

// Passo 1: Obter as categorias de interesse do utilizador (Ex: idUsuario '4')
const perfil = db.perfilUsuarios.findOne({ idUsuario: "4" });
const categoriasInteresse = perfil.preferencias.categorias_interesse; 

// Passo 2: Encontrar produtos que correspondam a essas categorias
db.categoriaProdutos.find({ "categorias.nome": { $in: categoriasInteresse } });
```