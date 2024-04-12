create database lanchonete_cco
go

use lanchonete_cco
go

create table categorias
(
	codigo int not null identity,
	nome varchar(50) not null,
	constraint pk_categorias primary key (codigo)
)
go


insert into categorias values ('Hamburguer'),('Frango'),('Filé'),('Vegetariano'),('Vegano')

select * from categorias


create table lanches
(
	codigo int not null identity,
	nome varchar(50) not null,
	preco decimal(10,2) not null,
	calorias int not null,	
	categoria_codigo int  not null,
	
	constraint pk_lanches primary key(codigo),
	constraint fk_categorias_lanches foreign key(categoria_codigo) references categorias
)
go

select * from lanches


insert into lanches values ('X-Bacon', 20, 850, 1)
insert into lanches values ('Filé Tudo', 25, 900, 3)
insert into lanches values ('Beringela Turbo',22, 150, 4)


create table fabricantes
(
	codigo int not null identity,
	nome varchar(50) not null,
	constraint pk_fabricantes primary key(codigo)
)
go

select * from fabricantes
insert into fabricantes values ('Coca-Cola Company')
insert into fabricantes values ('Poty')

create table bebidas
(
	codigo int not null identity,
	nome varchar(50) not null,
	estoque int not null,
	preco decimal(10,2) not null,
	fabricante_codigo int not null,

	constraint pk_bebidas primary key(codigo),
	constraint fk_fabricantes_bebidas foreign key(fabricante_codigo) references fabricantes
)
go

insert into bebidas values ('Fanta Laranja 350 ML', 100, 5, 1)
insert into bebidas values ('Agua com Gás Levity', 100, 4, 2)

select * from bebidas


create table ufs
(
	sigla char(02) not null,
	nome varchar(50) not null,
	constraint pk_ufs primary key(sigla)
)
go

insert into ufs values ('SP', 'São Paulo')
insert into ufs values ('RN', 'Rio Grande do Norte')
insert into ufs values ('RS', 'Rio Grande do Sul')

select * from ufs


Create table cidades
(
	codigo int  not null,
	nome varchar(50) not null,
	uf_sigla char(02) not null,
	constraint pk_cidades primary key(codigo),
	constraint fk_ufs_cidades foreign key(uf_sigla) references ufs
)
go

insert into cidades values(3549805, 'São José do Rio Preto', 'SP')
insert into cidades values(2408102, 'Natal', 'RN')
insert into cidades values(4309209, 'Gramado', 'RS')

create table ceps
(
	nr varchar(10) not null,
	cidade_codigo int not null,

	constraint pk_ceps primary key (nr),
	constraint fk_cidades_ceps foreign key (cidade_codigo) references cidades
)
go

select * from cidades

insert into ceps values ('15030-620',3549805)
insert into ceps values ('15093-314',3549805)



create table pessoas
(
	codigo int not null identity,
	nome varchar(50) not null,
	cpf varchar(12) not null,
	cep_nr varchar(10) not null,
	logradouro varchar(100) not null,
	nr	varchar(5) not null,

	constraint pk_pessoas primary key(codigo),
	constraint fk_ceps_pessoas foreign key (cep_nr) references ceps,
	constraint	uq_pessoas_cpf unique(cpf) 
)
go


insert into pessoas values ('Fernando Batman', '1010', '15030-620', 'Rua X', '1000')
insert into pessoas values ('Cadão', '2020', '15093-314', 'Rua Y', '500')

select * from fabricantes
select * from lanches
select * from categorias


create table telefones
(
	pessoa_codigo int not null,
	nr varchar(15) not null,
	constraint pk_telefones primary key(pessoa_codigo, nr),
	constraint fk_pessoas_telefones foreign key(pessoa_codigo) references pessoas
)
go

insert into telefones values (1, '3030-3030')
insert into telefones values (1, '1010-1010')
insert into telefones values (1, '2020-2020')
insert into telefones values (2, '55555-5555')
select * from telefones

create table clientes
(
	pessoa_codigo int not null,
	estrelas decimal(2,1) not null default 1,
	constraint pk_clientes primary key(pessoa_codigo),
	constraint fk_pessoas_clientes foreign key(pessoa_codigo) references pessoas
)
go

select * from pessoas
select * from clientes
insert into clientes(pessoa_codigo) values (2)

create table funcionarios
(
	pessoa_codigo int not null,
	salario decimal(7,2) not null default 1412,
	constraint pk_funcionarios primary key(pessoa_codigo),
	constraint fk_pessoas_funcionarios foreign key(pessoa_codigo) references pessoas
)
go

insert into funcionarios(pessoa_codigo) values (1)


select * from pessoas
select * from funcionarios
select * from clientes

create table entregadores
(
	pessoa_codigo int not null,
	valor_diaria decimal(7,2) not null default 80,
	constraint pk_entregadores primary key(pessoa_codigo),
	constraint fk_pessoas_entregadores foreign key(pessoa_codigo) references pessoas
)
go

insert into entregadores values (1, 90)


create table entregas
(
	codigo int not null identity,
	data_hora datetime not null default getdate(),
	status int not null default 1,
	entregador_codigo int not null,
	constraint pk_entregas primary key(codigo),
	constraint fk_entregador_entregas foreign key (entregador_codigo) references entregadores
)
go

insert into entregas (entregador_codigo) values (1)


create table pedidos
(
	nr int not null identity,
	data datetime not null default getdate(),
	total decimal(7,2) null default 0,
	status int not null default 1,
	cliente_codigo int not null,
	funcionarios_codigo int not null,
	entrega_codigo int,
	constraint pk_pedidos primary key(nr),
	constraint fk_clientes_pedidos foreign key(cliente_codigo) references clientes,
	constraint fk_funcionarios_pedidos foreign key(funcionarios_codigo) references funcionarios,
	constraint fk_entregas_pedidos foreign key (entrega_codigo) references entregas, 
)
go


insert into pedidos(cliente_codigo, funcionarios_codigo) values (2,1)

create table pedidos_lanches
(
	pedido_nr int not null,
	lanche_codigo int not null, 
	qtd int not null,
	constraint pk_pedidoslanches primary key(pedido_nr, lanche_codigo),
	constraint fk_pedidos_pedidoslanches foreign key(pedido_nr) references pedidos,
	constraint fk_lanches_pedidoslanches foreign key(lanche_codigo) references lanches,

)
go


insert into pedidos_lanches values (1, 1, 3)
insert into pedidos_lanches values (1, 3, 5)

create table pedidos_bebidas
(
	pedido_nr int not null,
	bebida_codigo int not null, 
	qtd int not null,
	constraint pk_pedidosbebidas primary key(pedido_nr, bebida_codigo),
	constraint fk_pedidos_pedidosbebidas foreign key(pedido_nr) references pedidos,
	constraint fk_bebidas_pedidosbebidas foreign key(bebida_codigo) references bebidas,

)
go



select * from pedidos

insert into pedidos_bebidas values (1, 1, 10)
insert into pedidos_bebidas values (1, 2, 1)


update pedidos set total = 250, entrega_codigo = 1 where nr = 1 