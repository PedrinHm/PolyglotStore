-- Últimas operações registradas
SELECT *
FROM Auditoria
ORDER BY dataRealizacao DESC
LIMIT 50;

-- Consultas feitas por um usuário específico
SELECT *
FROM Auditoria
WHERE idUsuario = 1001
ORDER BY dataRealizacao DESC;

-- Operações realizadas em um intervalo de tempo
SELECT *
FROM Auditoria
WHERE dataRealizacao BETWEEN now() - INTERVAL 7 DAY AND now()
ORDER BY dataRealizacao DESC;

-- Contagem de operações por tipo
SELECT tipoOperacao, count(*) AS total
FROM Auditoria
GROUP BY tipoOperacao
ORDER BY total DESC;

-- Top usuários que mais realizaram operações
SELECT idUsuario, count(*) AS totalOperacoes
FROM Auditoria
GROUP BY idUsuario
ORDER BY totalOperacoes DESC
LIMIT 10;

-- Volume de operações por dia
SELECT dataDia, count(*) AS total
FROM Auditoria
GROUP BY dataDia
ORDER BY dataDia DESC;

-- Palavras-chave mais comuns nas queries
SELECT count(*) AS total, tipoOperacao
FROM Auditoria
WHERE positionCaseInsensitive(queryOperacao, 'DROP') > 0
GROUP BY tipoOperacao;
