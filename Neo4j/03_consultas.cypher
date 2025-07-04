// Produtos ordenados por número de vendas
MATCH (c:Cliente)-[r:COMPROU]->(p:Produto)
RETURN COUNT(p) AS total_vendas, p.descricao
ORDER BY COUNT(p) DESC;

// Avaliação média de cada produto, ordenado por nota média e número de avaliações
MATCH (c:Cliente)-[r:AVALIOU]->(p:Produto)
RETURN p.descricao, COUNT(r) AS total_avaliacoes, AVG(r.estrela) AS media_avaliacao
ORDER BY media_avaliacao DESC, total_avaliacoes DESC;

// Categorias com maior quantidade de vendas
MATCH (c:Cliente)-[r:COMPROU]->(p:Produto)-[r2:PERTENCE_A]->(c2:Categoria)
RETURN c2.descricao AS categoria, COUNT(r) AS qtd_vendida
ORDER BY qtd_vendida DESC;

// Filtragem colaborativa (produto comprado junto):
// Encontra outros produtos comprados na mesma compra da "Caixa de Som Sony SRS-XB12"
MATCH (c:Cliente)-[r:COMPROU]->(p:Produto)
WITH c, r.datahora AS data_compra, collect(p.descricao) AS produtos
WHERE size(produtos) > 1 AND 'Caixa de Som Sony SRS-XB12' IN produtos
RETURN c.nome, data_compra, produtos;

// Filtragem colaborativa (User-User):
// Recomenda produtos comprados por clientes com histórico semelhante ao de Ana
MATCH (c:Cliente {nome: 'Ana'})-[:COMPROU]->(p:Produto),
      (c2:Cliente)-[:COMPROU]->(p),
      (c2)-[:COMPROU]->(p2:Produto)
WHERE c <> c2 AND NOT (c)-[:COMPROU]->(p2)
RETURN p2.descricao AS produto_recomendado,
       COUNT(c2) AS pessoas_que_compraram,
       COLLECT(DISTINCT c2.nome) AS clientes_similares;

// Produtos visualizados por um cliente mas que ele ainda não comprou
MATCH (c:Cliente {nome: 'Ana'})-[:VISUALIZOU]->(p:Produto)
WHERE NOT (c)-[:COMPROU]->(p)
RETURN p.descricao AS produto_recomendado;

// Clientes influenciadores:
// Identifica clientes cujas avaliações positivas foram seguidas por novas compras do produto
MATCH (c:Cliente)-[a:AVALIOU]->(p:Produto)
WHERE a.estrela >= 4 AND EXISTS(a.datahora)
WITH c, p, a.datahora AS data_avaliacao
MATCH (outro:Cliente)-[b:COMPROU]->(p)
WHERE b.datahora > data_avaliacao AND outro <> c
RETURN c.nome AS influenciador,
       COUNT(b) AS vendas_influenciadas,
       COLLECT(DISTINCT p.descricao) AS produtos_influenciados
ORDER BY vendas_influenciadas DESC;
