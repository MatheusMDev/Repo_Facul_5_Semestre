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
	
	create table telefones
	(
		pessoa_codigo int not null,
		numero varchar(15) not null,

		constraint pk_telefone primary key(pessoa_codigo, numero),
		constraint fk_pessoas_telefones foreign key(pessoa_codigo) references pessoas,
	)
	go

	
		
	create table clientes
	(
		pessoa_codigo int not null,
		score int not null,
		classificacao_codigo int not null,

		constraint pk_clientes primary key(pessoa_codigo),
		constraint fk_pessoas_clientes foreign key(pessoa_codigo) references pessoas,
		constraint ck_score check (score >= 0 and score <= 1000),
		constraint fk_classificacoes_clientes foreign key (classificacao_codigo) references classificacoes
	)
	go



	create table tecnicos
	(
		pessoa_codigo int not null, --filho:não em identity
		valor_diaria decimal (10,2) not null,

		--Restrições --
		constraint pk_tecnicos primary key(pessoa_codigo),
		constraint fk_pessoas_tecnicos foreign key(pessoa_codigo) references pessoas,
		constraint ck_valor_diaria check (valor_diaria > 0)
	)
	go


	create table funcionarios
	(
		pessoa_codigo int not null,
		salario decimal(10,2) not null,
		especialidade_codigo int not null,

		--restrições -- 
		constraint pk_funcionarios primary key(pessoa_codigo),
		constraint fk_pessoas_funcionarios foreign key(pessoa_codigo) references pessoas,
		constraint ck_salario check (salario > 0),
		constraint fk_especialidades_funcionarios foreign key (especialidade_codigo) references especialidades
	)
	go

	create table equipamentos
	(
		codigo int not null identity,
		nome varchar(50) not null,
		descricao varchar(50) not null,
		obs varchar(max) null,
		status int,
		tipo_codigo int not null,
	
		-- Restrições --
		constraint pk_equipamentos primary key(codigo),
		constraint ck_equipamentos_status check(status >= 1 and status <= 10),
		constraint fk_tipos_equipamentos foreign key (tipo_codigo) references tipos,
	)
	go


	create table locacoes
	(
		nr int not null identity,
		data_inicio datetime not null,
		data_termino datetime not null,
		total decimal(10,2) null,
		status int null,
		cliente_codigo int not null,
		funcionario_codigo int not null,


		--Restrições--
		constraint pk_locacoes primary key(nr),
		constraint ck_locacoes_total check(total > 0),
		constraint ck_locacoes_datas check(data_termino > data_inicio),
		constraint ck_locacoes_status check (status in (1,2,3)),
		constraint fk_clientes_locacoes foreign key(cliente_codigo) references clientes,
		constraint fk_funcionarios_locacoes foreign key(funcionario_codigo) references funcionarios,
	)
	go

	create table os
	(
		nr int not null identity,
		data_chamado datetime not null,
		data_termino datetime not null,
		status int null,
		locacao_nr int not null,
		tecnico_codigo int null,
		funcionario_codigo int not null,

		--Restrições--
		constraint pk_os primary key(nr),
		constraint ck_os_status check(status in(1,2,3,4,5)),
		constraint ck_os_datas check(data_termino > data_chamado),
		constraint fk_locacao_os foreign key (locacao_nr) references locacoes,
		constraint fk_tecnicos_os foreign key(tecnico_codigo) references tecnicos,
		constraint fk_funcionarios_os foreign key(funcionario_codigo) references funcionarios,
	)
	go

	create table parcelas
	(
		locacao_nr int not null,
		nr int not null,
		data_vencimento date not null,
		valor decimal(10,2) not null,
		data_pagamento date null,
		valor_pago decimal(10,2) null,
		juros decimal(10,2) null,
		multa decimal (10,2) null

		--Restrições--
		constraint pk_parcelas primary key(locacao_nr, nr),
		constraint fk_locacoes_parcelas foreign key (locacao_nr) references locacoes
	)
	go

	create table locacoes_equipamentos
	(
		locacao_nr int not null,
		equipamento_codigo int not null

		--Restrições-- 
		constraint pk_loca_equipa primary key(locacao_nr, equipamento_codigo),
		constraint fk_locacoes_loca_equipa foreign key (locacao_nr) references locacoes,
		constraint fk_equipamentos_loca_equipa foreign key (equipamento_codigo) references equipamentos,
	)
	go