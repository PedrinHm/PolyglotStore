# Comandos para Consulta de Dados no Redis


## 🚀 Preparação

Antes de executar os comandos, acesse o console do Redis com:

```bash
docker-compose exec redis redis-cli
```

---

## 📦 1. Consultas de Cache

### Dados de Produtos

```redis
# Consultar um produto específico pelo ID
GET cache:produto:1

# Consultar vários produtos de uma só vez
MGET cache:produto:1 cache:produto:2 cache:produto:3

# Verificar tempo de expiração de um item em cache (em segundos)
TTL cache:produto:1
```

### Dados de Categorias

```redis
# Consultar categoria específica
GET cache:categoria:1

# Listar todas as chaves de categorias
KEYS cache:categoria:*
```

### Dados de Usuários

```redis
# Consultar dados de um usuário específico
GET cache:usuario:101

# Verificar se um usuário específico existe no cache
EXISTS cache:usuario:102
```

### Operações Gerais de Cache

```redis
KEYS cache:*

# Contar número de produtos em cache
KEYS cache:produto:* | COUNT

# Listar apenas as chaves que expiram em menos de 30 minutos
# Este comando requer script Lua
EVAL "local keys = redis.call('KEYS', ARGV[1]); local result = {}; local count = 0; for i, key in ipairs(keys) do local ttl = redis.call('TTL', key); if ttl < tonumber(ARGV[2]) and ttl > 0 then count = count + 1; result[count] = key end end return result;" 0 "cache:*" "1800"
```

---

## 🛒 2. Consulta de Carrinhos de Compras

### Consultas Básicas

```redis
# Obter todos os campos do carrinho de um usuário específico
HGETALL carrinho:101

# Obter apenas os itens do carrinho
HGET carrinho:101 itens

# Obter o valor total do carrinho
HGET carrinho:101 valorTotal

# Verificar tempo de expiração do carrinho
TTL carrinho:101

# Verificar se um usuário tem carrinho ativo
EXISTS carrinho:103
```

### Consultas Avançadas

```redis
# Listar todos os carrinhos existentes
KEYS carrinho:*

# Encontrar carrinhos com mais de 2 itens
# Este comando requer script Lua ou processamento no aplicativo
EVAL "local keys = redis.call('KEYS', ARGV[1]); local result = {}; local count = 0; for i, key in ipairs(keys) do local total = tonumber(redis.call('HGET', key, 'totalItens')); if total > 2 then count = count + 1; result[count] = key end end return result;" 0 "carrinho:*"

# Encontrar carrinhos que expiram em menos de 12 horas (43200 segundos)
EVAL "local keys = redis.call('KEYS', ARGV[1]); local result = {}; local count = 0; for i, key in ipairs(keys) do local ttl = redis.call('TTL', key); if ttl < tonumber(ARGV[2]) and ttl > 0 then count = count + 1; result[count] = key end end return result;" 0 "carrinho:*" "43200"
```

---

## ✏️ 3. Operações de Atualização

### Cache de Produtos

```redis
# Adicionar novo produto ao cache com expiração de 1 hora
SET cache:produto:7 '{"id":7,"nome":"Smartwatch Pro","preco":899.90,"estoque":40}' EX 3600

# Atualizar informações de um produto existente
SET cache:produto:4 '{"id":4,"nome":"Fone de Ouvido Bluetooth","preco":299.90,"estoque":100}' EX 3600

# Incrementar estoque de um produto (requer recuperação, modificação e salvamento do JSON)
# Na prática, use scripts Lua ou funções específicas da aplicação
GET cache:produto:1
SET cache:produto:1 '{"id":1,"nome":"Smartphone XYZ","preco":1299.99,"estoque":55}' EX 3600

# Remover um produto do cache
DEL cache:produto:6
```

### Manipulação de Carrinhos

```redis
# Criar um novo carrinho
HSET carrinho:106 timestamp "$(date +%s)"
HSET carrinho:106 itens '[{"produtoId":3,"quantidade":1,"preco":3200.00}]'
HSET carrinho:106 totalItens 1
HSET carrinho:106 valorTotal 3200.00
EXPIRE carrinho:106 86400

# Atualizar campos específicos do carrinho
HSET carrinho:101 totalItens 4
HSET carrinho:101 valorTotal 6099.88
HSET carrinho:101 itens '[{"produtoId":1,"quantidade":2,"preco":1299.99},{"produtoId":3,"quantidade":1,"preco":3200.00},{"produtoId":4,"quantidade":1,"preco":299.90}]'

# Remover um carrinho
DEL carrinho:103

# Renovar o tempo de expiração de um carrinho (por mais 24 horas)
EXPIRE carrinho:102 86400
```
