
INSERT INTO Auditoria VALUES 
(
    generateUUIDv4(), 
    'SELECT', 
    'SELECT * FROM usuarios WHERE ativo = 1', 
    12.5, 
    1001, 
    now(), 
    today()
),
(
    generateUUIDv4(), 
    'INSERT', 
    'INSERT INTO produtos (nome, preco) VALUES (''Notebook'', 3499.90)', 
    45.8, 
    1002, 
    now() - INTERVAL 1 DAY, 
    today() - 1
),
(
    generateUUIDv4(), 
    'UPDATE', 
    'UPDATE pedidos SET status = ''enviado'' WHERE id = 1023', 
    30.1, 
    1003, 
    now() - INTERVAL 2 DAY, 
    today() - 2
),
(
    generateUUIDv4(), 
    'DELETE', 
    'DELETE FROM logs WHERE data < ''2024-01-01''', 
    78.3, 
    1004, 
    now() - INTERVAL 3 DAY, 
    today() - 3
);
