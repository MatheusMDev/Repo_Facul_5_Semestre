CREATE DATABASE segundo_projeto_

USE segundo_projeto_
GO

CREATE TABLE Pessoas
(
	codigo INT NOT NULL IDENTITY,
	nome VARCHAR(50) NOT NULL,
	CPF VARCHAR(12) NOT NULL,
	status int,

	PRIMARY KEY(codigo),
	UNIQUE(CPF),
	CHECK (status in (1, 2, 3, 4)) --estar contido em (se for algum desses numeros ok)
)
GO

CREATE TABLE Clientes
(
	pessoa_codigo INT NOT NULL,
	renda DECIMAL(10,2) NOT NULL,
	credito MONEY NOT NULL,

	PRIMARY KEY(pessoa_codigo),
	CHECK(renda > 0), -- vai checar se a renda for > 0 pra permitir a inser��o dos dados
	CHECK(credito > 0),
	FOREIGN KEY(pessoa_codigo) REFERENCES Pessoas
)
GO

CREATE TABLE Vendedores
(
	pessoa_codigo INT NOT NULL,
	salario DECIMAL(10,2) NOT NULL,

	PRIMARY KEY(pessoa_codigo),
	CHECK(salario > 0),
	FOREIGN KEY(pessoa_codigo) REFERENCES Pessoas
)
GO

sp_help Vendedores -- exibe todas as infos da tabela


CREATE TABLE Produtos
(
	codigo INT NOT NULL IDENTITY,
	decricao VARCHAR(50) NOT NULL,
	valor DECIMAL(10,2) NOT NULL,
	estoque INT NOT NULL,
	status INT,

	PRIMARY KEY(codigo),
	CHECK (estoque >= 0),
	CHECK (valor > 0),
	CHECK (status >= 1 and status <= 10)
)
GO

CREATE TABLE Pedidos
(
	nr INT NOT NULL,
	data DATETIME NOT NULL,
	valor DECIMAL(10,2),
	status INT NOT NULL,
	cliente_codigo INT NOT NULL, -- cliente faz N pedidos
	vendedor_codigo INT NOT NULL, -- vendedor registra N pedidos

	PRIMARY KEY(nr),
	CHECK(valor > 0),
	CHECK (status in (1, 2, 3, 4, 5)),
	FOREIGN KEY (cliente_codigo) REFERENCES Clientes,
	FOREIGN KEY (vendedor_codigo) REFERENCES Vendedores,
)
GO

CREATE TABLE Itens_Pedidos -- TABELA CRIADA P/ N -> N
(
	pedido_numero INT NOT NULL,
	produto_codigo INT NOT NULL,
	qtd_vendida INT NOT NULL,
	preco_vendido MONEY NOT NULL,

	PRIMARY KEY(pedido_numero, produto_codigo), -- chave primaria composta
	FOREIGN KEY(pedido_numero) REFERENCES Pedidos,
	FOREIGN KEY(produto_codigo) REFERENCES Produtos,
	CHECK(qtd_vendida > 0),
	CHECK(preco_vendido > 0)
)
GO

-- CRIANDO UM LOOP PARA INSERIR OS DADOS
DECLARE @i int
SET @i = 1
WHILE @i > 0
BEGIN -- abre chave do while
	INSERT INTO Produtos VALUES ('L�pis', 1000, 3, 1)
END -- fecha a chave do while

SELECT COUNT(*) FROM Produtos -- EM OUTRA ABA PARA VISUALIZAR

DELETE FROM Produtos WHERE codigo > 1