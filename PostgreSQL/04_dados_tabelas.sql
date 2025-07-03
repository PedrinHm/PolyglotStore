-- Inserindo dados na tabela 'usuarios' (Lote 1)
INSERT INTO public.usuarios (email, senha, nome, cpf, administrador) values
('nicolas.dias@example.com.br', 'senha_hash_313', 'Nicolas Dias', '890.123.456-79', true),
('davi.lima@example.com.br', 'senha_hash_789', 'Davi Lima', '333.444.555-66', true),
('miguel.oliveira@example.com.br', 'senha_hash_123', 'Miguel Oliveira', '111.222.333-44', false),
('sophia.santos@example.com.br', 'senha_hash_456', 'Sophia Santos', '222.333.444-55', false),
('helena.souza@example.com.br', 'senha_hash_101', 'Helena Souza', '444.555.666-77', false),
('arthur.ferreira@example.com.br', 'senha_hash_112', 'Arthur Ferreira', '555.666.777-88', false),
('alice.rodrigues@example.com.br', 'senha_hash_131', 'Alice Rodrigues', '666.777.888-99', false),
('heitor.alves@example.com.br', 'senha_hash_415', 'Heitor Alves', '777.888.999-00', false),
('laura.pereira@example.com.br', 'senha_hash_161', 'Laura Pereira', '888.999.000-11', false),
('theo.gomes@example.com.br', 'senha_hash_718', 'Theo Gomes', '999.000.111-22', false),
('maria.costa@example.com.br', 'senha_hash_191', 'Maria Costa', '000.111.222-33', false),
('gael.martins@example.com.br', 'senha_hash_202', 'Gael Martins', '123.456.789-10', false),
('valentina.araujo@example.com.br', 'senha_hash_212', 'Valentina Araujo', '234.567.890-12', false),
('bernardo.melo@example.com.br', 'senha_hash_222', 'Bernardo Melo', '345.678.901-23', false),
('helena.barbosa@example.com.br', 'senha_hash_232', 'Helena Barbosa', '456.789.012-34', false),
('ravi.ribeiro@example.com.br', 'senha_hash_242', 'Ravi Ribeiro', '567.890.123-45', false),
('isabella.carvalho@example.com.br', 'senha_hash_301', 'Isabella Carvalho', '678.901.234-56', false),
('lucas.gomes@example.com.br', 'senha_hash_302', 'Lucas Gomes', '789.012.345-67', false),
('manuela.martins@example.com.br', 'senha_hash_303', 'Manuela Martins', '890.123.456-78', false),
('lucca.rocha@example.com.br', 'senha_hash_304', 'Lucca Rocha', '901.234.567-89', false),
('lorenzo.almeida@example.com.br', 'senha_hash_305', 'Lorenzo Almeida', '012.345.678-90', false),
('julia.nunes@example.com.br', 'senha_hash_306', 'Júlia Nunes', '123.456.789-01', false),
('pedro.santos@example.com.br', 'senha_hash_307', 'Pedro Santos', '234.567.890-13', false),
('livia.silva@example.com.br', 'senha_hash_308', 'Lívia Silva', '345.678.901-24', false),
('benjamin.mendes@example.com.br', 'senha_hash_309', 'Benjamin Mendes', '456.789.012-35', false),
('giovanna.ribeiro@example.com.br', 'senha_hash_310', 'Giovanna Ribeiro', '567.890.123-46', false),
('matheus.castro@example.com.br', 'senha_hash_311', 'Matheus Castro', '678.901.234-57', false),
('beatriz.fernandes@example.com.br', 'senha_hash_312', 'Beatriz Fernandes', '789.012.345-68', false),
('cecilia.barros@example.com.br', 'senha_hash_314', 'Cecília Barros', '901.234.567-90', false),
('samuel.freitas@example.com.br', 'senha_hash_315', 'Samuel Freitas', '012.345.678-91', false);

-- Inserindo dados na tabela 'clientes' associados aos usuários criados (Lote 1)
-- Os IDs dos usuários são assumidos como sendo de 1 a 15, na ordem de inserção acima.
INSERT INTO public.clientes (usuarios_id, telefone, data_nascimento) VALUES
(3, '(31) 99999-8888', '1985-01-30'),
(4, '(41) 98888-7777', '1995-11-10'),
(5, '(51) 97777-6666', '1988-03-25'),
(6, '(61) 96666-5555', '2000-07-07'),
(7, '(71) 95555-4444', '1998-12-01'),
(8, '(81) 94444-3333', '1993-09-18'),
(9, '(91) 93333-2222', '1999-04-12'),
(10, '(12) 92222-1111', '1991-06-28'),
(11, '(22) 91111-0000', '1980-02-20'),
(12, '(32) 98765-1234', '2001-10-05'),
(13, '(42) 91234-8765', '1997-05-14'),
(14, '(52) 95432-1876', '1994-08-03'),
(15, '(62) 98712-3456', '2002-03-09'),
(16, '(71) 91234-5678', '1996-02-11'),
(17, '(81) 92345-6789', '1993-04-23'),
(18, '(91) 93456-7890', '2003-01-19'),
(19, '(13) 94567-8901', '1989-07-30'),
(20, '(23) 95678-9012', '1984-11-25'),
(21, '(33) 96789-0123', '2000-09-14'),
(22, '(43) 97890-1234', '1998-06-08'),
(23, '(53) 98901-2345', '1995-10-17'),
(24, '(63) 99012-3456', '1992-12-21'),
(25, '(73) 90123-4567', '2001-08-02'),
(26, '(83) 91234-5679', '1997-03-16'),
(27, '(93) 92345-6790', '1994-05-29'),
(28, '(14) 93456-7891', '1987-09-09'),
(29, '(24) 94567-8902', '2002-07-27'),
(30, '(34) 95678-9013', '1999-11-04');

select * from clientes;

INSERT INTO public.enderecoclientes (clientes_id, rua, cep, cidade_id, endereco_principal) VALUES
-- Cliente 1
(1, 'Rua das Magnólias, 10A', '01001-000', floor(random() * 5570) + 1, true),
(1, 'Avenida Ibirapuera, 1500', '01310-200', floor(random() * 5570) + 1, false),
-- Cliente 2
(2, 'Rua das Orquídeas, 25', '20040-030', floor(random() * 5570) + 1, true),
-- Cliente 3
(3, 'Avenida Afonso Pena, 500', '30130-001', floor(random() * 5570) + 1, true),
(3, 'Rua da Bahia, 1200', '30160-011', floor(random() * 5570) + 1, false),
(3, 'Praça Sete de Setembro, 10', '30130-010', floor(random() * 5570) + 1, false),
-- Cliente 4
(4, 'Rua das Araucárias, 415', '80010-010', floor(random() * 5570) + 1, true),
-- Cliente 5
(5, 'Avenida Borges de Medeiros, 78', '90020-021', floor(random() * 5570) + 1, true),
(5, 'Rua dos Andradas, 990', '90020-006', floor(random() * 5570) + 1, false),
-- Cliente 6
(6, 'Quadra SQS 308 Bloco K, 308', '70355-110', floor(random() * 5570) + 1, true),
-- Cliente 7
(7, 'Avenida Sete de Setembro, 1234', '40060-001', floor(random() * 5570) + 1, true),
(7, 'Rua Chile, 15', '40020-000', floor(random() * 5570) + 1, false),
-- Cliente 8
(8, 'Rua da Moeda, 50', '50030-040', floor(random() * 5570) + 1, true),
-- Cliente 9
(9, 'Avenida Presidente Vargas, 800', '66017-000', floor(random() * 5570) + 1, true),
(9, 'Travessa Campos Sales, 200', '66015-060', floor(random() * 5570) + 1, false),
(9, 'Rua Ó de Almeida, 55', '66015-180', floor(random() * 5570) + 1, false),
-- Cliente 10
(10, 'Rua XV de Novembro, 1010', '11010-150', floor(random() * 5570) + 1, true),
-- Cliente 11
(11, 'Rua do Imperador, 333', '25620-002', floor(random() * 5570) + 1, true),
-- Cliente 12
(12, 'Rua Halfeld, 777', '36010-003', floor(random() * 5570) + 1, true),
(12, 'Avenida Rio Branco, 2000', '36015-510', floor(random() * 5570) + 1, false),
-- Cliente 13
(13, 'Rua das Laranjeiras, 45', '89201-000', floor(random() * 5570) + 1, true),
-- Cliente 14
(14, 'Avenida Beira Mar, 987', '88015-200', floor(random() * 5570) + 1, true),
(14, 'Rua Felipe Schmidt, 654', '88010-001', floor(random() * 5570) + 1, false),
-- Cliente 15
(15, 'Avenida Goiás, 321', '74003-010', floor(random() * 5570) + 1, true),
-- Cliente 16
(16, 'Rua das Acácias, 111', '41820-021', floor(random() * 5570) + 1, true),
(16, 'Avenida Tancredo Neves, 222', '41820-020', floor(random() * 5570) + 1, false),
-- Cliente 17
(17, 'Rua do Sol, 333', '53020-030', floor(random() * 5570) + 1, true),
-- Cliente 18
(18, 'Travessa Piedade, 444', '69010-130', floor(random() * 5570) + 1, true),
(18, 'Avenida Eduardo Ribeiro, 555', '69005-160', floor(random() * 5570) + 1, false),
(18, 'Rua 10 de Julho, 666', '69010-060', floor(random() * 5570) + 1, false),
-- Cliente 19
(19, 'Rua Amador Bueno, 777', '12210-090', floor(random() * 5570) + 1, true),
-- Cliente 20
(20, 'Avenida Brasil, 888', '28941-042', floor(random() * 5570) + 1, true),
(20, 'Rua da Praia, 999', '28940-346', floor(random() * 5570) + 1, false),
-- Cliente 21
(21, 'Rua dos Inconfidentes, 101', '35400-000', floor(random() * 5570) + 1, true),
-- Cliente 22
(22, 'Alameda da Serra, 202', '34006-059', floor(random() * 5570) + 1, true),
(22, 'Rodovia MG-030, 303', '34000-000', floor(random() * 5570) + 1, false),
-- Cliente 23
(23, 'Rua Visconde de Nácar, 404', '80410-201', floor(random() * 5570) + 1, true),
-- Cliente 24
(24, 'Avenida Padre Cacique, 505', '90810-240', floor(random() * 5570) + 1, true),
(24, 'Rua Gen. Rondon, 606', '90910-440', floor(random() * 5570) + 1, false),
(24, 'Travessa Escobar, 707', '90810-200', floor(random() * 5570) + 1, false),
-- Cliente 25
(25, 'Rua do Comércio, 808', '76801-054', floor(random() * 5570) + 1, true),
-- Cliente 26
(26, 'Avenida Epitácio Pessoa, 909', '58039-000', floor(random() * 5570) + 1, true),
-- Cliente 27
(27, 'Rua dos Barés, 121', '69005-020', floor(random() * 5570) + 1, true),
(27, 'Avenida Floriano Peixoto, 232', '69005-230', floor(random() * 5570) + 1, false),
-- Cliente 28
(28, 'Rua Direita, 343', '35800-000', floor(random() * 5570) + 1, true);

select * from enderecoclientes e;

INSERT INTO public.marcas (nome, descricao, criado_por) VALUES
('Nike', 'Marca de artigos esportivos.', 3),
('Adidas', 'Marca de artigos esportivos, concorrente da Nike.', 11),
('Apple', 'Empresa de tecnologia famosa por iPhones, iPads e Macs.', 20),
('Samsung', 'Conglomerado multinacional de tecnologia.', 28),
('Coca-Cola', 'Marca de bebidas não alcoólicas.', 3),
('Toyota', 'Fabricante de automóveis japonesa.', 11),
('Microsoft', 'Empresa de software, famosa pelo Windows e Office.', 20),
('Amazon', 'Gigante do comércio eletrônico e computação em nuvem.', 28),
('Google', 'Empresa de serviços online e software.', 3),
('Natura', 'Empresa brasileira de cosméticos.', 11),
('Havaianas', 'Marca brasileira de sandálias.', 20),
('Petrobras', 'Empresa petrolífera estatal brasileira.', 28),
('Itaú Unibanco', 'Maior banco privado do Brasil.', 3),
('Bradesco', 'Instituição bancária brasileira.', 11),
('Ambev', 'Companhia de bebidas, dona de marcas como Skol, Brahma e Antarctica.', 20);

select * from marcas;

INSERT INTO public.produtos (marcas_id, nome, descricao, valor, criado_por) VALUES
-- Nike (ID: 1)
(1, 'Tênis Nike Air Max 90', 'Clássico tênis da Nike, confortável e estiloso.', 799.99, 3),
(1, 'Camiseta Nike Dri-FIT', 'Camiseta para atividades físicas com tecnologia que afasta o suor.', 149.90, 11),
(1, 'Shorts Nike Challenger', 'Shorts de corrida leve e com bolsos.', 229.99, 3),
-- Adidas (ID: 2)
(2, 'Tênis Adidas Superstar', 'Ícone da moda urbana, com a clássica biqueira de borracha.', 499.99, 11),
(2, 'Camisa de Time Flamengo I', 'Camisa oficial do time de futebol Flamengo, temporada 2024.', 349.99, 20),
(2, 'Agasalho Adidas Essentials', 'Conjunto de moletom para conforto no dia a dia.', 449.90, 11),
-- Apple (ID: 3)
(3, 'iPhone 15 Pro', 'Smartphone com chip A17 Pro, sistema de câmera Pro e design em titânio.', 9299.00, 20),
(3, 'MacBook Air M3', 'Notebook ultrafino com o poderoso chip M3 da Apple.', 12499.00, 28),
(3, 'Apple Watch Series 9', 'Relógio inteligente com novos gestos e tela mais brilhante.', 4999.00, 20),
-- Samsung (ID: 4)
(4, 'Smartphone Samsung Galaxy S24 Ultra', 'Smartphone com Galaxy AI, câmera de 200MP e S Pen integrada.', 8999.00, 28),
(4, 'Smart TV 55" Crystal UHD 4K', 'Televisão com resolução 4K, design slim e processador Crystal.', 3299.00, 3),
(4, 'Geladeira Bespoke Family Hub', 'Geladeira inteligente com painel interativo e design customizável.', 21999.00, 28),
-- Coca-Cola (ID: 5)
(5, 'Coca-Cola Original 2L', 'Refrigerante de cola, garrafa de 2 litros.', 9.99, 3),
(5, 'Coca-Cola Sem Açúcar 350ml', 'Versão sem açúcar do refrigerante, lata de 350ml.', 4.50, 11),
-- Toyota (ID: 6)
(6, 'Toyota Corolla Cross XRE', 'SUV híbrido com design moderno e tecnologia embarcada.', 178590.00, 11),
(6, 'Toyota Hilux SRX Plus', 'Picape robusta com motor a diesel e tração 4x4.', 334890.00, 20),
-- Microsoft (ID: 7)
(7, 'Microsoft 365 Personal', 'Assinatura anual do pacote Office com 1TB de armazenamento na nuvem.', 299.00, 20),
(7, 'Controle Sem Fio Xbox Series', 'Controle para consoles Xbox e PC.', 499.00, 28),
-- Amazon (ID: 8)
(8, 'Echo Dot (5ª geração)', 'Smart speaker com Alexa, som de alta definição e controle de casa inteligente.', 429.00, 28),
(8, 'Kindle Paperwhite (16 GB)', 'Leitor de livros digitais com tela de 6,8” e temperatura de luz ajustável.', 799.00, 3),
-- Google (ID: 9)
(9, 'Google Nest Mini (2ª geração)', 'Smart speaker com Google Assistente para músicas, notícias e mais.', 349.00, 3),
(9, 'Smartphone Google Pixel 8 Pro', 'Smartphone com câmera avançada e recursos de IA do Google.', 7999.00, 11),
-- Natura (ID: 10)
(10, 'Desodorante Colônia Kaiak Masculino', 'Fragrância aromática aquática para o dia a dia.', 149.90, 11),
(10, 'Polpa Desodorante Hidratante para o Corpo Ekos Castanha', 'Hidratante corporal com óleo de castanha, nutrição intensa.', 89.90, 20),
-- Havaianas (ID: 11)
(11, 'Havaianas Top', 'O modelo clássico e democrático da Havaianas.', 39.99, 20),
(11, 'Havaianas Slim', 'Modelo com tiras mais finas e delicadas.', 49.99, 28),
-- Petrobras (ID: 12)
(12, 'Gasolina Petrobras Grid', 'Gasolina aditivada para maior desempenho e limpeza do motor.', 5.99, 28),
(12, 'Diesel S-10 Petrobras', 'Óleo diesel com menor teor de enxofre.', 6.20, 3),
-- Itaú Unibanco (ID: 13)
(13, 'Anuidade Cartão de Crédito Personnalité', 'Serviço de anuidade para cartão de crédito com benefícios exclusivos.', 1200.00, 3),
(13, 'Seguro de Vida Itaú', 'Plano de seguro de vida com diversas coberturas.', 600.00, 11),
-- Bradesco (ID: 14)
(14, 'Cesta de Serviços Prime', 'Pacote de serviços bancários para clientes de alta renda.', 950.00, 11),
(14, 'Consórcio de Imóvel', 'Plano de consórcio para aquisição de imóveis.', 850.00, 20),
-- Ambev (ID: 15)
(15, 'Cerveja Skol Pilsen 350ml', 'Lata da cerveja leve e refrescante.', 3.99, 20),
(15, 'Cerveja Brahma Duplo Malte 600ml', 'Garrafa de cerveja com sabor mais encorpado.', 8.50, 28),
(15, 'Guaraná Antarctica 2L', 'Refrigerante de guaraná, garrafa de 2 litros.', 8.99, 3);

INSERT INTO public.estoqueprodutos (produtos_id, quantidade) VALUES
(1, floor(random() * 100) + 20),
(2, floor(random() * 200) + 50),
(3, floor(random() * 150) + 30),
(4, floor(random() * 100) + 20),
(5, floor(random() * 80) + 15),
(6, floor(random() * 120) + 25),
(7, floor(random() * 50) + 10),
(8, floor(random() * 30) + 5),
(9, floor(random() * 60) + 10),
(10, floor(random() * 40) + 8),
(11, floor(random() * 90) + 12),
(12, floor(random() * 25) + 5),
(13, floor(random() * 1000) + 200),
(14, floor(random() * 1000) + 300),
(15, floor(random() * 15) + 2),
(16, floor(random() * 10) + 1),
(17, floor(random() * 300) + 50),
(18, floor(random() * 250) + 40),
(19, floor(random() * 180) + 30),
(20, floor(random() * 150) + 25),
(21, floor(random() * 220) + 45),
(22, floor(random() * 100) + 15),
(23, floor(random() * 300) + 80),
(24, floor(random() * 250) + 70),
(25, floor(random() * 500) + 150),
(26, floor(random() * 400) + 120),
(27, floor(random() * 9999) + 1000),
(28, floor(random() * 9999) + 1000),
(29, 0), 
(30, 0), 
(31, 0), 
(32, 0), 
(33, floor(random() * 5000) + 1000),
(34, floor(random() * 4000) + 800),
(35, floor(random() * 6000) + 1500);
