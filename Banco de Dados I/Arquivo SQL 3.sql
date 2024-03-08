select * from produtos

sp_help produtos

insert into produtos values
('Lápis', 1000, 2, 1)



create procedure cadProd
(
	@descricao varchar(50),
	@estoque int,
	@preco	decimal(10,2)
)
as
begin
	insert into produtos values 
	(@descricao, @estoque, @preco, 1)
end
go


--Teste--
exec cadProd 'Caderno', 1000, 20
go


exec cadProd 'Caneta', 500, 3
go

exec cadProd 'Borracha', 200, 4
go

exec cadProd 'Estojo', 50, 21
go
select * from produtos


select * from pessoas
select * from clientes
go

create procedure cadCli
(
	@nome  varchar(50),
	@cpf   varchar(12),
	@renda decimal(10,2)
)
as
begin
	insert into pessoas values (@nome, @cpf, 1)
	insert into clientes values 
	(@@IDENTITY, @renda, @renda*0.25)
end
go

exec cadCli 'Cleber', '1010', 5000
go

select * from pessoas
select * from clientes
go


select * from pessoas
select * from vendedores
go

create procedure cadVen
(
	@nome varchar(50),
	@cpf varchar(12),
	@salario decimal (10,2)

)
as
begin
	insert into pessoas values (@nome, @cpf, 1)
	insert into vendedores values (@@IDENTITY, @salario)
end
go

exec cadVen 'Fernando', '2020', 2500
go

--------------------------------------------
select * from pedidos
go

create procedure cadPed
(
	@nr int, @cliente int, @vendedor int
)
as
begin
	insert into pedidos
	(nr, data, cliente_codigo, vendedor_codigo)
	values
	(@nr, GETDATE(), @cliente, @vendedor) 
end

exec cadPed 1,1,2
go

select * from pedidos
select * from itens_pedidos
go

create procedure cadItem
(
	@pedido int, @produto int, @qtd int, @preco decimal(10,2)
)
as
begin
	insert into itens_pedidos values 
	(@pedido, @produto, @qtd, @preco)
end
go


exec cadItem 1, 3, 4, 3
go
exec cadItem 1, 4, 7, 3.90
go
exec cadItem 1, 5, 10, 20
select * from itens_pedidos