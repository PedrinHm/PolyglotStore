
select
	p.nome as produto,
	e.quantidade as quantidade_estoque,
	p.valor as valor_produto,
	p.valor * e.quantidade as valor_x_quantidade,
	m.nome as marca
from
	produtos p
join marcas m on
	p.marcas_id = m.id
	and m.deletado is false
join estoqueprodutos e on
	e.produtos_id = p.id
	and e.deletado is false
where p.deletado is false
order by
	m.nome;

--Quantidade de clientes cadastrados(endereço principal) por estado
select
	count(c.id),
	e2.nome
from
	usuarios u
join clientes c on
	u.id = c.usuarios_id
	and c.deletado is false
join enderecoclientes e on
	e.clientes_id = c.id
	and e.endereco_principal is true
	and e.deletado is false
join cidades c2 on
	c2.id = e.cidade_id
join estados e2 on
	c2.estado_id = e2.id
where
	u.deletado is false
group by
	2;

--Clientes com mais de um estado cadastrados em seus endereços
select
	u.nome,
	e2.nome as estadoprincipal,
	string_agg(e4.nome, ', ') as estados_secundario
from
	usuarios u
join clientes c on
	u.id = c.usuarios_id
	and c.deletado is false
join enderecoclientes e on
	e.clientes_id = c.id
	and e.endereco_principal is true
	and e.deletado is false
join cidades c2 on
	c2.id = e.cidade_id
join estados e2 on
	c2.estado_id = e2.id
join enderecoclientes e3 on
	e3.clientes_id = c.id
	and e3.endereco_principal is false
	and e3.deletado is false
join cidades c3 on
	c3.id = e3.cidade_id
join estados e4 on
	c3.estado_id = e4.id
where
	u.deletado is false
	and e <> e4
group by
	1,
	2
order by
	u.nome;