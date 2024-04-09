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