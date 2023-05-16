-- create database trabalho_m2;
use trabalho_m2;
-- drop table if exists Unidade, Produto, Vendedor, Venda;
create table Unidade(
    Uni_ID int primary key auto_increment,
    Cidade varchar(40)
);

create table Produto(
    Prod_ID int primary key auto_increment,
    Descricao varchar(50),
    Preco float
);

create table Vendedor(
    Matricula int primary key auto_increment,
    Nome varchar(60)
);

create table Venda(
	Venda_ID int primary key auto_increment,
    Uni_ID int,
    Prod_ID int,
    Quantidade float,
    Vendedor_ID int,
    DataV date, -- YYYY-MM-DD
    foreign key (Uni_ID) references Unidade(Uni_ID),
    foreign key (Prod_ID) references Produto(Prod_ID),
    foreign key (Vendedor_ID) references Vendedor(Matricula)
);

-- Criação de dados -----------------------------------------------------------------------------------------------------------------------
use trabalho_m2;

INSERT INTO Unidade (Cidade)
VALUES('Florianópolis'),
	  ('São Paulo'),
      ('Rio de Janeiro'),
	  ('Brasília');
      
INSERT INTO Produto (Descricao, Preco)
VALUES('Smartphone', 4300),
	  ('Tênis', 700),
      ('Headphone', 2400),
      ('Chocolate', 7.50);

INSERT INTO Vendedor (Nome)
VALUES('Anaísa'),
	  ('Gabriel'),
      ('Isadora'),
      ('Matheus');
      
INSERT INTO Venda (Uni_ID, Prod_ID, Quantidade, Vendedor_ID, DataV)
VALUES(4, 4, 100, 4, '2022-07-20'),
	  (4, 4, 7, 4, '2023-04-27'),
	  (2, 2, 36, 2, '2023-04-16'),
	  (1, 1, 56, 1, '2023-04-14'),
	  (1, 1, 12, 1, '2020-05-01'),
	  (1, 1, 12, 1, '2022-05-01'),
	  (2, 2, 36, 2, '2023-07-02'),
      (3, 3, 4, 3, '2021-12-18'),
      (4, 4, 7, 4, '2023-06-15'),
	  (1, 3, 8, 2, '2022-06-03'),
      (2, 2, 40, 3, '2022-08-25'),
      (3, 1, 9, 4, '2022-09-01'),
	  (4, 4, 4, 1, '2023-02-10'),
      (1, 2, 13, 3, '2022-05-19'),
      (2, 3, 97, 2, '2022-07-15'),
	  (3, 4, 1, 1, '2022-08-16'),
      (4, 3, 27, 4, '2023-09-30');


-- Junções-------------------------------------------------------------------------------------------------------------------------------
use trabalho_m2;

-- A

SELECT Produto.Descricao, Unidade.Cidade
FROM trabalho_m2.Venda
INNER JOIN trabalho_m2.Produto ON Produto.Prod_ID = Venda.Prod_ID
INNER JOIN trabalho_m2.Unidade ON Unidade.Uni_ID = Venda.Uni_ID
WHERE Produto.Prod_ID = 4;

-- B

SELECT Vendedor.Nome, Venda.Quantidade, Unidade.Cidade, Produto.Descricao, Produto.Preco, Venda.DataV
FROM trabalho_m2.Venda
INNER JOIN trabalho_m2.Unidade ON Unidade.Uni_ID = Venda.Uni_ID
INNER JOIN trabalho_m2.Vendedor ON Vendedor.Matricula = Venda.Vendedor_ID
INNER JOIN trabalho_m2.Produto ON Produto.Prod_ID = Venda.Prod_ID
WHERE Venda.Vendedor_ID = 4; 

-- C 

SELECT Unidade.Cidade, Vendedor.Nome, Produto.Descricao, Produto.Preco
FROM trabalho_m2.Venda
INNER JOIN trabalho_m2.Unidade ON Unidade.Uni_ID = Venda.Uni_ID
INNER JOIN trabalho_m2.Produto ON Produto.Prod_ID = Venda.Prod_ID
INNER JOIN trabalho_m2.Vendedor ON Vendedor.Matricula = Venda.Vendedor_ID
WHERE Venda.DataV > NOW() - INTERVAL 2 YEAR AND DATAV < NOW() AND Unidade.Uni_ID = 2; 

-- D

SELECT DISTINCT Produto.Prod_ID, Produto.Descricao  
FROM trabalho_m2.Produto
LEFT JOIN trabalho_m2.Venda ON Venda.Prod_ID = Produto.Prod_ID
WHERE Produto.Prod_ID NOT IN (
  SELECT Prod_ID
  FROM trabalho_m2.Venda
  WHERE DataV > NOW() - INTERVAL 1 MONTH AND DataV < NOW()
);

-- E

SELECT DISTINCT Vendedor.Matricula, Vendedor.Nome 
FROM trabalho_m2.Venda
LEFT JOIN trabalho_m2.Vendedor on Vendedor.Matricula = Venda.Vendedor_ID
WHERE Vendedor.Matricula NOT IN (
  SELECT Vendedor_ID
  FROM trabalho_m2.Venda
  WHERE DataV > NOW() - INTERVAL 20 DAY AND DataV < NOW() 
); 

-- Agregações-------------------------------------------------------------------------------------------------------------------------------

-- F 

SELECT SUM(Venda.Quantidade) as Quantidade_total_vendas, SUM(Produto.Preco * Venda.Quantidade) AS Valor_total_vendas
FROM trabalho_m2.Venda
INNER JOIN trabalho_m2.Produto ON Produto.Prod_ID = Venda.Prod_ID
WHERE Produto.Prod_ID = 2;

-- G 
SELECT Vendedor.Matricula, SUM(Venda.Quantidade) AS Quantidade_total_vendas, SUM(Produto.Preco * Venda.Quantidade) AS Valor_total_vendas, AVG(Produto.Preco * Venda.Quantidade) AS Vendas_Medias 
FROM trabalho_m2.Venda
INNER JOIN trabalho_m2.Produto ON Produto.Prod_ID = Venda.Prod_ID
INNER JOIN trabalho_m2.Vendedor ON Vendedor.Matricula = Venda.Vendedor_ID
WHERE Venda.Vendedor_ID = 2;

-- H 
SELECT Unidade.Cidade, SUM(Produto.Preco * Venda.Quantidade) as Valor_Total
FROM trabalho_m2.Venda
INNER JOIN trabalho_m2.Produto ON Produto.Prod_ID = Venda.Prod_ID
INNER JOIN trabalho_m2.Unidade ON Unidade.Uni_ID = Venda.Uni_ID
WHERE  Venda.DataV > NOW() - interval 1 year and Venda.DataV < NOW()
GROUP BY Unidade.Uni_ID, Produto.Preco
HAVING SUM(Produto.Preco * Venda.Quantidade) > 100000;

-- I 

SELECT Produto.Prod_ID, Produto.Descricao, SUM(Venda.Quantidade) AS total_quantidade-- olhar
FROM trabalho_m2.Produto
LEFT JOIN trabalho_m2.Venda ON Venda.Prod_ID = Produto.Prod_ID
WHERE DataV > NOW() - interval 3 month and DataV < NOW() 
GROUP BY Produto.Prod_ID
having total_quantidade < 20 UNION 
	 select p.Prod_ID, p.Descricao, 0 AS total_quantidade
        from Produto p
        left join Venda v on v.Prod_ID = p.Prod_ID
        where v.Venda_ID is null;

-- J

SELECT Vendedor.Nome
FROM trabalho_m2.Vendedor
LEFT JOIN trabalho_m2.Venda ON Venda.Vendedor_ID = Vendedor.Matricula 
LEFT JOIN trabalho_m2.Produto ON Produto.Prod_ID = Venda.Prod_ID 
WHERE Venda.DataV > NOW() - INTERVAL 1 YEAR AND Venda.DataV < NOW()
GROUP BY Vendedor.Matricula
HAVING SUM(Produto.Preco * Venda.Quantidade) > (
  SELECT AVG(Total_Vendas) 
  FROM (
    SELECT SUM(Produto.Preco * Venda.Quantidade) AS Total_Vendas
    FROM trabalho_m2.Venda
    LEFT JOIN trabalho_m2.Produto ON Produto.Prod_ID = Venda.Prod_ID
    WHERE Venda.DataV > NOW() - INTERVAL 1 YEAR AND Venda.DataV < NOW()
    GROUP BY Venda.Vendedor_ID
  ) AS subquery
);

