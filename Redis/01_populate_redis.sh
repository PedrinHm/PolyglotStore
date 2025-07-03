#!/bin/bash
# Script para popular o Redis com dados de cache e carrinho de compras

# Executar este script após iniciar o Redis com o Docker Compose.
# docker-compose exec redis sh -c "sh /redis-scripts/01_populate_redis.sh"
#---------------------------------------------------------------------------

REDIS_HOST=redis_cache
REDIS_PORT=6379

# Limpar todos os dados do Redis
redis-cli -h $REDIS_HOST -p $REDIS_PORT FLUSHALL

echo "Populando Redis com dados de cache..."

# Produtos populares
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:produto:1" '{"id":1,"nome":"Smartphone XYZ","preco":1299.99,"estoque":50}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:produto:2" '{"id":2,"nome":"Notebook ABC","preco":4500.00,"estoque":20}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:produto:3" '{"id":3,"nome":"Smart TV 55\"","preco":3200.00,"estoque":15}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:produto:4" '{"id":4,"nome":"Fone Bluetooth","preco":199.90,"estoque":100}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:produto:5" '{"id":5,"nome":"Tablet Pro","preco":2100.00,"estoque":30}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:produto:6" '{"id":6,"nome":"Monitor 27\"","preco":999.99,"estoque":25}' EX 3600

# Categorias
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:categoria:1" '{"id":1,"nome":"Eletrônicos","produtos_count":120}' EX 7200
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:categoria:2" '{"id":2,"nome":"Informática","produtos_count":85}' EX 7200
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:categoria:3" '{"id":3,"nome":"Celulares","produtos_count":45}' EX 7200
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:categoria:4" '{"id":4,"nome":"Acessórios","produtos_count":60}' EX 7200

# Usuários frequentes
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:usuario:101" '{"id":101,"nome":"João Silva","nivel":"premium"}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:usuario:102" '{"id":102,"nome":"Maria Oliveira","nivel":"premium"}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:usuario:103" '{"id":103,"nome":"Carlos Souza","nivel":"comum"}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:usuario:104" '{"id":104,"nome":"Ana Paula","nivel":"comum"}' EX 3600
redis-cli -h $REDIS_HOST -p $REDIS_PORT SET "cache:usuario:105" '{"id":105,"nome":"Fernanda Lima","nivel":"premium"}' EX 3600

echo "Populando Redis com dados de carrinho de compras..."

# Carrinho do usuário 101
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:101" "timestamp" "$(date +%s)"
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:101" "itens" '[{"produtoId":1,"quantidade":2,"preco":1299.99},{"produtoId":3,"quantidade":1,"preco":3200.00}]'
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:101" "totalItens" "3"
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:101" "valorTotal" "5799.98"

# Carrinho do usuário 102
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:102" "timestamp" "$(date +%s)"
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:102" "itens" '[{"produtoId":2,"quantidade":1,"preco":4500.00}]'
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:102" "totalItens" "1"
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:102" "valorTotal" "4500.00"

# Carrinho do usuário 103 (vazio)
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:103" "timestamp" "$(date +%s)"
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:103" "itens" "[]"
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:103" "totalItens" "0"
redis-cli -h $REDIS_HOST -p $REDIS_PORT HSET "carrinho:103" "valorTotal" "0.00"

# Configurar tempo de expiração para os carrinhos (24 horas = 86400 segundos)
redis-cli -h $REDIS_HOST -p $REDIS_PORT EXPIRE "carrinho:101" 86400
redis-cli -h $REDIS_HOST -p $REDIS_PORT EXPIRE "carrinho:102" 86400
redis-cli -h $REDIS_HOST -p $REDIS_PORT EXPIRE "carrinho:103" 86400

echo "Dados inseridos com sucesso no Redis!"
