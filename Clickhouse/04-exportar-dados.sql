-- Exportar dados para relatórios CSV
SELECT * FROM Auditoria INTO OUTFILE 'auditoria.csv' FORMAT CSV;

SELECT 
    idOperacao,
    tipoOperacao,
    queryOperacao,
    tempoOperacao,
    idUsuario,
    dataRealizacao
FROM Auditoria
WHERE dataRealizacao BETWEEN now() - INTERVAL 30 DAY AND now()
ORDER BY dataRealizacao DESC, idUsuario
INTO OUTFILE 'auditoria_ultimos_30_dias.csv'
FORMAT CSVWithNames;


-- Exportar dados para relatórios JSON
SELECT * FROM Auditoria INTO OUTFILE 'auditoria.json' FORMAT JSON;