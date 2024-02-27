create database est_cco
go

use est_cco 
go

create table cores -- tabela criada
(
	codigo int         not null primary key identity,
	nome   varchar(50) not null
)
go

insert into cores values ('Verde') -- inserir na tabela

select * from cores -- consultar a tabela

insert into cores values -- inserir na tabela
('Azul'),
('Vermelho'),
('Branco')


begin tran -- Abrir transação

delete from cores -- deletar tudo da tabela

delete from cores where codigo > 4 -- deletar apenas os maiores da 4

rollback -- Fecha e não valida a transação

--------------------------------------------------------------

create table modelos
(
	codigo    int         not null primary key identity,
	descricao varchar(50) not null
)
go

select * from modelos

insert into modelos values 
('Gol'),
('Fox'),
('Civic')

---------------------------------------------------------------

create table veiculos
(
	placa         varchar(10) not null primary key, -- não vamos informar o autoincremento do identity pois a placa nós vamos informar
	cor_codigo    int         not null references cores,
	modelo_codigo int	      not null references modelos
)
go

insert into veiculos values
('AAA-1010',1,3)


insert into veiculos values
('AAA-2020',4,1)

select * from cores
select * from modelos
select * from veiculos


create table vagas
(
	numero int not null primary key identity,
	status int	   null
)
go

insert into vagas values
(1), (1),(1)

select * from vagas


create table entradas
(
	nr int not null primary key identity,
	data_hora_chegada datetime not null,
	data_hora_saida datetime null,
	total decimal(10,2)		 null,
	veiculos_placa varchar(10) not null references veiculos,
	vaga_numero int not null references vagas
)
go

select * from entradas

insert into entradas
(data_hora_chegada, veiculos_placa, vaga_numero)
values(getdate(),'AAA-1010',2)

update vagas set status = 0 where numero = 2 -- para alterar apenas a vaga de numero 2, então é somente feito where variavel e depois  = o valor.