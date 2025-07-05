# 🌐 Comandos para Consulta e Manipulação de Dados no Neo4j

---

## 🚀 Preparação

O banco de dados Neo4j é iniciado localmente via Docker Compose. Após iniciado, você pode interagir com ele por:

### Via Browser

Acesse [http://localhost:7474](http://localhost:7474) e conecte-se com as credenciais padrão:

- **Username**: `neo4j`  
- **Password**: `password` (você será solicitado a trocar na primeira vez)

### Via Cypher Shell (Opcional)

```bash
docker exec -it neo4j_db cypher-shell -u neo4j -p password
```

---

## 🧱 1. Criação da Estrutura (Nós e Relacionamentos)

Os scripts para modelagem de dados estão localizados na pasta `PolyglotStore/Neo4j/`.

### 📌 Arquivo: `01_nos.cypher`

Cria os **nós principais**:

- `(:Cliente {nome})` – Clientes que interagem com os produtos
- `(:Produto {descricao})` – Itens disponíveis para visualização e compra
- `(:Marca {nome})` – Fabricantes dos produtos
- `(:Categoria {descricao})` – Classificação temática dos produtos

### 🔗 Arquivo: `02_relacionamentos.cypher`

Cria os **relacionamentos entre os nós** com propriedades importantes:

#### Produto → Marca

```cypher
(:Produto)-[:FABRICADO_POR]->(:Marca)
```

#### Produto → Categoria

```cypher
(:Produto)-[:PERTENCE_A]->(:Categoria)
```

#### Cliente → Produto

Relacionamentos com atributos temporais e de avaliação:

- `(:Cliente)-[:VISUALIZOU {datahora}]→(:Produto)`
- `(:Cliente)-[:COMPROU {datahora}]→(:Produto)`
- `(:Cliente)-[:AVALIOU {datahora, estrela, comentario?}]→(:Produto)`

---

## ✏️ 2. Consultas e Análises (Cypher)

As principais consultas analíticas e de recomendação estão em `PolyglotStore/Neo4j/03_consultas.cypher`.

### 🔍 Consultas Simples

#### Produtos mais vendidos

```cypher
MATCH (c:Cliente)-[r:COMPROU]->(p:Produto)
RETURN COUNT(p) AS total_vendas, p.descricao
ORDER BY COUNT(p) DESC;
```

#### Avaliação média dos produtos

```cypher
MATCH (c:Cliente)-[r:AVALIOU]->(p:Produto)
RETURN p.descricao, COUNT(r) AS total_avaliacoes, AVG(r.estrela) AS media_avaliacao
ORDER BY media_avaliacao DESC, total_avaliacoes DESC;
```

#### Categorias com mais vendas

```cypher
MATCH (c:Cliente)-[r:COMPROU]->(p:Produto)-[:PERTENCE_A]->(c2:Categoria)
RETURN c2.descricao AS categoria, COUNT(r) AS qtd_vendida
ORDER BY qtd_vendida DESC;
```

---

## 🤝 3. Recomendação e Filtragem Colaborativa

### 🔄 Produtos comprados juntos (item-item)

```cypher
MATCH (c:Cliente)-[r:COMPROU]->(p:Produto)
WITH c, r.datahora AS data_compra, collect(p.descricao) AS produtos
WHERE size(produtos) > 1 AND 'Caixa de Som Sony SRS-XB12' IN produtos
RETURN c.nome, data_compra, produtos;
```

### 👥 Filtragem colaborativa por similaridade de usuários (user-user)

```cypher
MATCH (c:Cliente {nome: 'Ana'})-[:COMPROU]->(p:Produto),
      (c2:Cliente)-[:COMPROU]->(p),
      (c2)-[:COMPROU]->(p2:Produto)
WHERE c <> c2 AND NOT (c)-[:COMPROU]->(p2)
RETURN p2.descricao AS produto_recomendado,
       COUNT(c2) AS pessoas_que_compraram,
       COLLECT(DISTINCT c2.nome) AS clientes_similares;
```

### 👁️ Produtos visualizados e não comprados

```cypher
MATCH (c:Cliente {nome: 'Ana'})-[:VISUALIZOU]->(p:Produto)
WHERE NOT (c)-[:COMPROU]->(p)
RETURN p.descricao AS produto_recomendado;
```

---

### 🧠 Influência por avaliação

Identifica clientes cujas **avaliações positivas (≥ 4 estrelas)** foram seguidas por novas compras do mesmo produto:

```cypher
MATCH (c:Cliente)-[a:AVALIOU]->(p:Produto)
WHERE a.estrela >= 4 AND EXISTS(a.datahora)
WITH c, p, a.datahora AS data_avaliacao
MATCH (outro:Cliente)-[b:COMPROU]->(p)
WHERE b.datahora > data_avaliacao AND outro <> c
RETURN c.nome AS influenciador,
       COUNT(b) AS vendas_influenciadas,
       COLLECT(DISTINCT p.descricao) AS produtos_influenciados
ORDER BY vendas_influenciadas DESC;
```

---

## 📂 Organização dos Arquivos

```
PolyglotStore/
└── Neo4j/
    ├── nos.cypher              # Criação dos nós
    ├── relacionamentos.cypher  # Relacionamentos entre entidades
    ├── consultar.cypher        # Consultas e recomendações em Cypher
```