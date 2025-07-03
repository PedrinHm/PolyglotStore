CREATE TABLE Auditoria
(
    idOperacao UUID COMMENT 'Identificador único da operação',
    tipoOperacao Enum8('SELECT' = 1, 'INSERT' = 2, 'UPDATE' = 3, 'DELETE' = 4) COMMENT 'Tipo de operação executada',
    queryOperacao String COMMENT 'Query SQL executada',
    tempoOperacao Float32 COMMENT 'Tempo de execução da operação em milissegundos',
    idUsuario UInt64 COMMENT 'Identificador do usuário que executou a operação',
    dataRealizacao DateTime COMMENT 'Data e hora da execução da operação',
    dataDia Date COMMENT 'Data (sem hora) usada para particionamento'
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(dataDia)
ORDER BY (dataRealizacao, idUsuario)
TTL dataRealizacao + INTERVAL 6 MONTH DELETE
SETTINGS index_granularity = 8192;
