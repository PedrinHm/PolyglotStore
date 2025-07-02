#!/bin/bash
set -e

# Aguarda o MongoDB estar pronto
# O healthcheck no docker-compose já faz algo similar, mas um loop aqui garante
# que o shell script não tente importar antes que o mongo esteja escutando.
echo "Aguardando o MongoDB iniciar..."
until mongosh --host localhost --port 27017 --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 1)' > /dev/null 2>&1; do
  printf '.'
  sleep 1
done
echo "MongoDB está pronto!"

# Define as variáveis de ambiente para autenticação, se necessário
# Se você não estiver usando autenticação (que é o caso padrão do seu docker-compose para o initdb.d),
# pode remover as flags -u e -p, ou deixar como está para ser mais robusto.
MONGO_USER="${MONGO_INITDB_ROOT_USERNAME:-user}"
MONGO_PASS="${MONGO_INITDB_ROOT_PASSWORD:-password}"
MONGO_DB="${POSTGRES_DB:-datadrivenstore}" # Usando o mesmo nome de DB do Postgres para consistência

echo "Importando dados para o banco de dados: $MONGO_DB"

# Importa categoriaProdutos.json
mongoimport --host localhost --port 27017 \
            --authenticationDatabase admin -u "$MONGO_USER" -p "$MONGO_PASS" \
            --db "$MONGO_DB" --collection categoriaProdutos --file /docker-entrypoint-initdb.d/categoriaProdutos.json \
            --jsonArray --drop
echo "Importado categoriaProdutos.json"

# Importa pedidos.json
mongoimport --host localhost --port 27017 \
            --authenticationDatabase admin -u "$MONGO_USER" -p "$MONGO_PASS" \
            --db "$MONGO_DB" --collection pedidos --file /docker-entrypoint-initdb.d/pedidos.json \
            --jsonArray --drop
echo "Importado pedidos.json"

# Importa perfilUsuarios.json
mongoimport --host localhost --port 27017 \
            --authenticationDatabase admin -u "$MONGO_USER" -p "$MONGO_PASS" \
            --db "$MONGO_DB" --collection perfilUsuarios --file /docker-entrypoint-initdb.d/perfilUsuarios.json \
            --jsonArray --drop
echo "Importado perfilUsuarios.json"

echo "Todos os dados JSON foram importados com sucesso para o MongoDB."