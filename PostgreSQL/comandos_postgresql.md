-- EXEMPLOS DE USO DAS FUNÇÕES
SELECT public.cadastrar_administrador('pedro@bancodedados.com.br', 'senha123', 'Pedro Mendes', '128.456.789-10');

SELECT public.cadastrar_marca('Funko', 'Empresa famosa por seus bonecos colecionáveis da cultura pop.', 1);

SELECT public.cadastrar_produto(16, 'Funko Pop! Homem de Ferro', 'Figura colecionável de vinil do Homem de Ferro no momento icônico do filme Vingadores.', 189.90, 1);

SELECT public.adicionar_estoque(37, 5);

SELECT public.cadastrar_cliente('natanzin@email.com', 'natan123', 'Natan Martins', '987.654.321-00', '(81) 99876-5432', '1991-11-05');

SELECT public.cadastrar_endereco_cliente(29, 'Avenida Copacabana, 777', '22020-002', 3349, true);

SELECT public.cadastrar_endereco_cliente(29, 'Rua da Lapa, 50', '20021-180', 3349, false);

SELECT public.desativar_endereco_cliente(47);

SELECT public.desativar_produto(37, 31);

SELECT public.desativar_usuario(2);

SELECT public.desativar_marca(16, 1);

SELECT public.realizar_pedido(
     7,
     ARRAY[26, 25], -- IDs dos produtos
     ARRAY[2, 1]    -- Quantidades
 );

