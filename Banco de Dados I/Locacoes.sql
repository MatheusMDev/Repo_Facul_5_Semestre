	create database locacao_cco
	go

	use locacao_cco
	go

	Create table especialidades
	(
		codigo int         not null identity,
		nome   varchar(50) not null
	
		-- Restrição -- 
		constraint pk_especialidade primary key(codigo)
	)
	go

	/*
	alter table especialidades
	drop [pk_especialidade]

	alter table especialidades
	add constraint pk_chavinha primary key(codigo)
	*/

	create table classificacoes
	(
		codigo int not null identity,
		nome   varchar(50) not null

		-- Restrição -- 
		constraint pk_classificacao primary key(codigo)
	)
	go

	-- select * from sys.tables

	Create table tipos
	(
		codigo int not null identity,
		nome   varchar(50) not null,
		valor_diaria decimal(10,2),
		status	int  null,

		--Restrições--

		constraint pk_tipos primary key (codigo),
		constraint ch_diaria check (valor_diaria >= 0),
		constraint ck_status check (status in(1,2,3,4))
	)
	go


	create table pessoas
	(
		codigo int not null identity,
		nome varchar(50) not null,
		cpf varchar(12) not null,
		status int null,

		--Restrições--
		constraint pk_pessoas primary key(codigo),
		constraint uq_cpf unique(cpf),
		constraint ck_p_status check(status in(0,1))
	)
	go

	create table emails
	(
		pessoa_codigo int not null,
		endereco varchar(100) not null,
		
		--Restrições--
		constraint pk_emails primary key(pessoa_codigo, endereco) --Chave composta

	)
	go