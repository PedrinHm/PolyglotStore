-- FUNÇÃO PARA ADICIONAR MARCA
CREATE OR REPLACE FUNCTION public.cadastrar_marca(
    _nome VARCHAR(100),
    _descricao TEXT,
    _criado_por INT
)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE
    nova_marca_id INT;
BEGIN

    IF NOT EXISTS (SELECT 1 FROM public.usuarios WHERE id = _criado_por AND administrador = TRUE AND deletado = FALSE) THEN
        RAISE EXCEPTION 'Apenas administradores podem cadastrar novas marcas.';
    END IF;

    INSERT INTO public.marcas (nome, descricao, criado_por)
    VALUES (_nome, _descricao, _criado_por)
    RETURNING id INTO nova_marca_id;

    RETURN nova_marca_id;
END;
$$;

-- FUNÇÃO PARA CADASTRAR PRODUTO
CREATE OR REPLACE FUNCTION public.cadastrar_produto(
    _marcas_id INT,
    _nome VARCHAR(255),
    _descricao TEXT,
    _valor NUMERIC(10, 2),
    _criado_por INT
)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE
    novo_produto_id INT;
BEGIN

    IF NOT EXISTS (SELECT 1 FROM public.usuarios WHERE id = _criado_por AND administrador = TRUE AND deletado = FALSE) THEN
        RAISE EXCEPTION 'Apenas administradores podem cadastrar novos produtos.';
    END IF;

    INSERT INTO public.produtos (marcas_id, nome, descricao, valor, criado_por)
    VALUES (_marcas_id, _nome, _descricao, _valor, _criado_por)
    RETURNING id INTO novo_produto_id;

    INSERT INTO public.estoqueprodutos (produtos_id, quantidade)
    VALUES (novo_produto_id, 0);

    RETURN novo_produto_id;
END;
$$;

-- FUNÇÃO PARA ADICIONAR ESTOQUE
CREATE OR REPLACE FUNCTION public.adicionar_estoque(
    _produto_id INT,
    _quantidade INT
)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE
    nova_quantidade INT;
BEGIN

    IF _quantidade <= 0 THEN
        RAISE EXCEPTION 'A quantidade a ser adicionada ao estoque deve ser positiva.';
    END IF;

    UPDATE public.estoqueprodutos
    SET quantidade = quantidade + _quantidade
    WHERE produtos_id = _produto_id
    RETURNING quantidade INTO nova_quantidade;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto com ID % não encontrado no estoque.', _produto_id;
    END IF;

    RETURN nova_quantidade;
END;
$$;

-- FUNÇÃO PARA ADICIONAR CLIENTE
CREATE OR REPLACE FUNCTION public.cadastrar_cliente(
    _email VARCHAR(255),
    _senha VARCHAR(255),
    _nome VARCHAR(255),
    _cpf VARCHAR(14),
    _telefone VARCHAR(20),
    _data_nascimento DATE
)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE
    novo_usuario_id INT;
    novo_cliente_id INT;
BEGIN

    INSERT INTO public.usuarios (email, senha, nome, cpf)
    VALUES (_email, _senha, _nome, _cpf)
    RETURNING id INTO novo_usuario_id;

    INSERT INTO public.clientes (usuarios_id, telefone, data_nascimento)
    VALUES (novo_usuario_id, _telefone, _data_nascimento)
    RETURNING id INTO novo_cliente_id;

    RETURN novo_cliente_id;
END;
$$;

-- FUNÇÃO PARA CADASTRAR ADMINISTRADOR
CREATE OR REPLACE FUNCTION public.cadastrar_administrador(
    _email VARCHAR(255),
    _senha VARCHAR(255),
    _nome VARCHAR(255),
    _cpf VARCHAR(14)
)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE
    novo_admin_id INT;
BEGIN
    INSERT INTO public.usuarios (email, senha, nome, cpf, administrador)
    VALUES (_email, _senha, _nome, _cpf, TRUE)
    RETURNING id INTO novo_admin_id;

    RETURN novo_admin_id;
END;
$$;

-- FUNÇÃO PARA ADICIONAR ENDEREÇO DE CLIENTE
CREATE OR REPLACE FUNCTION public.cadastrar_endereco_cliente(
    _clientes_id INT,
    _rua VARCHAR(255),
    _cep VARCHAR(9),
    _cidade_id INT,
    _endereco_principal BOOLEAN DEFAULT FALSE
)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE
    novo_endereco_id INT;
BEGIN

    IF _endereco_principal = TRUE THEN
        UPDATE public.enderecoclientes
        SET endereco_principal = FALSE
        WHERE clientes_id = _clientes_id;
    END IF;

    INSERT INTO public.enderecoclientes (clientes_id, rua, cep, cidade_id, endereco_principal)
    VALUES (_clientes_id, _rua, _cep, _cidade_id, _endereco_principal)
    RETURNING id INTO novo_endereco_id;

    RETURN novo_endereco_id;
END;
$$;

-- FUNÇÃO PARA DESATIVAR UM ADM/CLIENTE
CREATE OR REPLACE FUNCTION public.desativar_usuario(_usuario_id INT)
RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
    _cliente_id INT;
BEGIN

    UPDATE public.usuarios SET deletado = TRUE WHERE id = _usuario_id;
    IF NOT FOUND THEN RETURN FALSE; END IF;

    SELECT id INTO _cliente_id FROM public.clientes WHERE usuarios_id = _usuario_id;
    IF _cliente_id IS NOT NULL THEN
        UPDATE public.clientes SET deletado = TRUE WHERE id = _cliente_id;
        UPDATE public.enderecoclientes SET deletado = TRUE WHERE clientes_id = _cliente_id;
    END IF;

    RETURN TRUE;
END;
$$;

-- FUNÇÃO PARA DESATIVAR UMA MARCA
CREATE OR REPLACE FUNCTION public.desativar_marca(_marca_id INT, _admin_id INT)
RETURNS BOOLEAN LANGUAGE plpgsql AS $$
BEGIN

    IF NOT EXISTS (SELECT 1 FROM public.usuarios WHERE id = _admin_id AND administrador = TRUE AND deletado = FALSE) THEN
        RAISE EXCEPTION 'Apenas administradores podem desativar marcas.';
    END IF;

    IF EXISTS (SELECT 1 FROM public.produtos WHERE marcas_id = _marca_id AND deletado = FALSE) THEN
        RAISE EXCEPTION 'Não é possível desativar uma marca que possui produtos ativos.';
    END IF;

    UPDATE public.marcas
    SET deletado = TRUE, deletado_por = _admin_id
    WHERE id = _marca_id;

    RETURN FOUND;
END;
$$;

-- FUNÇÃO PARA DESATIVAR UM PRODUTO
CREATE OR REPLACE FUNCTION public.desativar_produto(_produto_id INT, _admin_id INT)
RETURNS BOOLEAN LANGUAGE plpgsql AS $$
BEGIN

    IF NOT EXISTS (SELECT 1 FROM public.usuarios WHERE id = _admin_id AND administrador = TRUE AND deletado = FALSE) THEN
        RAISE EXCEPTION 'Apenas administradores podem desativar produtos.';
    END IF;

    UPDATE public.produtos
    SET deletado = TRUE, deletado_por = _admin_id
    WHERE id = _produto_id;
    IF NOT FOUND THEN RETURN FALSE; END IF;

    UPDATE public.estoqueprodutos
    SET deletado = TRUE
    WHERE produtos_id = _produto_id;

    RETURN TRUE;
END;
$$;

-- FUNÇÃO PARA DESATIVAR UM ENDEREÇO
CREATE OR REPLACE FUNCTION public.desativar_endereco_cliente(_endereco_id INT)
RETURNS BOOLEAN LANGUAGE plpgsql AS $$
BEGIN
    UPDATE public.enderecoclientes
    SET deletado = TRUE
    WHERE id = _endereco_id;

    RETURN FOUND;
END;
$$;

-- FUNÇÃO PARA REALIZAR PEDIDO (Acredito que seria melhor no backend, mas como não temos... rsrs)
CREATE OR REPLACE FUNCTION public.realizar_pedido(
    _usuario_id INT,
    _ids_produtos INT[],
    _quantidades INT[]
)
RETURNS JSON LANGUAGE plpgsql AS $$
DECLARE
    i INT;
    estoque_atual INT;
    cliente_info JSON;
    itens_pedido_json JSON;
    valor_total_pedido NUMERIC;
    pedido_json JSON;
BEGIN
    IF array_length(_ids_produtos, 1) IS NULL OR array_length(_quantidades, 1) IS NULL THEN
        RAISE EXCEPTION 'As listas de produtos e quantidades não podem ser vazias.';
    END IF;

    IF array_length(_ids_produtos, 1) <> array_length(_quantidades, 1) THEN
        RAISE EXCEPTION 'A lista de produtos e quantidades deve ter o mesmo tamanho.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM public.usuarios WHERE id = _usuario_id AND deletado = FALSE) THEN
        RAISE EXCEPTION 'Usuário com ID % não encontrado ou inativo.', _usuario_id;
    END IF;

    FOR i IN 1..array_length(_ids_produtos, 1)
    LOOP
        SELECT ep.quantidade INTO estoque_atual
        FROM public.estoqueprodutos ep
        JOIN public.produtos p ON ep.produtos_id = p.id
        WHERE ep.produtos_id = _ids_produtos[i] AND p.deletado = FALSE;

        IF NOT FOUND OR estoque_atual IS NULL THEN
            RAISE EXCEPTION 'Produto com ID % não existe ou está inativo.', _ids_produtos[i];
        END IF;

        IF estoque_atual < _quantidades[i] THEN
            RAISE EXCEPTION 'Estoque insuficiente para o produto ID %. Em estoque: %, Pedido: %.', _ids_produtos[i], estoque_atual, _quantidades[i];
        END IF;
    END LOOP;

    FOR i IN 1..array_length(_ids_produtos, 1)
    LOOP
        UPDATE public.estoqueprodutos
        SET quantidade = quantidade - _quantidades[i]
        WHERE produtos_id = _ids_produtos[i];
    END LOOP;

    SELECT
        json_build_object(
            'nome', u.nome,
            'endereco', CONCAT(ec.rua, ', CEP: ', ec.cep),
            'documento', u.cpf
        )
    INTO cliente_info
    FROM public.usuarios u
    JOIN public.clientes c ON u.id = c.usuarios_id
    JOIN public.enderecoclientes ec ON c.id = ec.clientes_id
    WHERE u.id = _usuario_id AND ec.endereco_principal = TRUE;

    WITH itens_input AS (
        SELECT * FROM unnest(_ids_produtos, _quantidades) AS t(id, qtd)
    )
    SELECT
        json_agg(
            json_build_object(
                'idProduto', p.id,
                'nome', p.nome,
                'descricao', p.descricao,
                'valor', p.valor,
                'valorPago', p.valor,
                'quantidade', i.qtd
            )
        ),
        sum(p.valor * i.qtd)
    INTO itens_pedido_json, valor_total_pedido
    FROM itens_input i
    JOIN public.produtos p ON i.id = p.id;

    pedido_json := json_build_object(
        'idUsuario', _usuario_id,
        'cliente', cliente_info,
        'itensPedido', itens_pedido_json,
        'valorTotal', valor_total_pedido,
        'dataPedido', NOW(),
        'pagamento', json_build_object(
            'formaPagamento', 'Pendente',
            'status', 'Aguardando Pagamento',
            'dataPagamento', NULL
        ),
        'historicoStatus', json_build_array(
            json_build_object(
                'tipoStatus', 'Criado',
                'dataRealizacao', NOW()
            )
        ),
        'status', 'Criado'
    );

    RETURN pedido_json;
END;
$$;