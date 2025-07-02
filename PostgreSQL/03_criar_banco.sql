-- =================================================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS
-- Descrição: Cria a estrutura completa do banco de dados, incluindo
-- tabelas, relacionamentos e gatilhos de auditoria.
-- =================================================================

-- =================================================================
-- FUNÇÃO DE GATILHO (TRIGGER FUNCTION)
-- Atualiza automaticamente o campo 'atualizado_em' em qualquer update.
-- =================================================================
CREATE OR REPLACE FUNCTION public.trigger_set_timestamp()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.atualizado_em = NOW();
  RETURN NEW;
END;
$$;

CREATE TABLE public.usuarios (
	id serial4 NOT NULL PRIMARY KEY,
	email varchar(255) NOT NULL UNIQUE,
	senha varchar(255) NOT NULL,
	nome varchar(255) NOT NULL,
	cpf varchar(14) NOT NULL UNIQUE,
	administrador bool NOT NULL DEFAULT false,
	criado_em timestamptz NULL DEFAULT CURRENT_TIMESTAMP,
	atualizado_em timestamptz NULL,
	deletado bool NOT NULL DEFAULT false
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.usuarios
FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

CREATE TABLE public.clientes (
	id serial4 NOT NULL PRIMARY KEY,
	usuarios_id int4 NOT NULL UNIQUE,
	telefone varchar(20) NULL,
	data_nascimento date NULL,
	criado_em timestamptz NULL DEFAULT CURRENT_TIMESTAMP,
	atualizado_em timestamptz NULL,
	deletado bool NOT NULL DEFAULT false,
	CONSTRAINT fk_clientes_usuarios FOREIGN KEY (usuarios_id) REFERENCES public.usuarios(id) ON DELETE CASCADE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.clientes
FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

CREATE TABLE public.enderecoclientes (
	id serial4 NOT NULL PRIMARY KEY,
	clientes_id int4 NOT NULL,
	rua varchar(255) NOT NULL,
	cep varchar(9) NOT NULL,
	cidade_id int4 NOT NULL,
	endereco_principal bool NOT NULL DEFAULT false,
	criado_em timestamptz NULL DEFAULT CURRENT_TIMESTAMP,
	atualizado_em timestamptz NULL,
	deletado bool NOT NULL DEFAULT false,
	CONSTRAINT fk_endereco_clientes FOREIGN KEY (clientes_id) REFERENCES public.clientes(id) ON DELETE CASCADE,
	CONSTRAINT fk_endereco_cidade FOREIGN KEY (cidade_id) REFERENCES public.cidades(id) ON DELETE CASCADE
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.enderecoclientes
FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

CREATE TABLE public.marcas (
	id serial4 NOT NULL PRIMARY KEY,
	nome varchar(100) NOT NULL UNIQUE,
	descricao text NULL,
	criado_em timestamptz NULL DEFAULT CURRENT_TIMESTAMP,
	criado_por int4 NULL,
	atualizado_em timestamptz NULL,
	atualizado_por int4 NULL,
	deletado bool NOT NULL DEFAULT false,
	deletado_por int4 NULL,
	CONSTRAINT fk_marcas_criado_por FOREIGN KEY (criado_por) REFERENCES public.usuarios(id),
	CONSTRAINT fk_marcas_atualizado_por FOREIGN KEY (atualizado_por) REFERENCES public.usuarios(id),
	CONSTRAINT fk_marcas_deletado_por FOREIGN KEY (deletado_por) REFERENCES public.usuarios(id)
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.marcas
FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

CREATE TABLE public.produtos (
	id serial4 NOT NULL PRIMARY KEY,
	marcas_id int4 NOT NULL,
	nome varchar(255) NOT NULL,
	descricao text NULL,
	valor numeric(10, 2) NOT NULL CHECK (valor >= 0),
	criado_em timestamptz NULL DEFAULT CURRENT_TIMESTAMP,
	criado_por int4 NULL,
	atualizado_em timestamptz NULL,
	atualizado_por int4 NULL,
	deletado bool NOT NULL DEFAULT false,
	deletado_por int4 NULL,
	CONSTRAINT fk_produtos_marcas FOREIGN KEY (marcas_id) REFERENCES public.marcas(id) ON DELETE RESTRICT,
	CONSTRAINT fk_produtos_criado_por FOREIGN KEY (criado_por) REFERENCES public.usuarios(id),
	CONSTRAINT fk_produtos_atualizado_por FOREIGN KEY (atualizado_por) REFERENCES public.usuarios(id),
	CONSTRAINT fk_produtos_deletado_por FOREIGN KEY (deletado_por) REFERENCES public.usuarios(id)
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.produtos
FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

CREATE TABLE public.estoqueprodutos (
	id serial4 NOT NULL PRIMARY KEY,
	produtos_id int4 NOT NULL UNIQUE,
	quantidade int4 NOT NULL DEFAULT 0,
	criado_em timestamptz NULL DEFAULT CURRENT_TIMESTAMP,
	atualizado_em timestamptz NULL,
	deletado bool NOT NULL DEFAULT false,
	CONSTRAINT fk_estoque_produtos FOREIGN KEY (produtos_id) REFERENCES public.produtos(id) ON DELETE CASCADE,
	CONSTRAINT chk_quantidade_nao_negativa CHECK ((quantidade >= 0))
);

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.estoqueprodutos
FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();
