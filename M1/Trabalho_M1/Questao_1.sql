-- ----------------------------------------------------------------------------------------------------------------------------------------
-- EXERCÍCIO 1
-- ----------------------------------------------------------------------------------------------------------------------------------------
create database trabalho_m1;

use trabalho_m1;

-- drop table if exists Address, Student, Student_Phone; -- (para mais de uma tabela, a sintaxe padrao é drop table <tabela>

create table Address (
    Address_ID varchar(3) PRIMARY KEY, 
    Country varchar(30),
    State varchar (30),
    City varchar (30),
    Street varchar (30)
);

create table Student (
    Roll_No INT PRIMARY KEY auto_increment,
    Nome varchar(20), -- seria o nome, mas nao da pra usar 
    DOB varchar (10),
    Age varchar(3) GENERATED ALWAYS AS (YEAR('2023-05-04') - YEAR(DOB)) STORED, -- por varchar
    Address_ID varchar(3),
    FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID)
);

create table Student_Phone(
    Roll_No INT,
    Phone_Code varchar(3),
    Phone_Number varchar(15),
    PRIMARY KEY (Roll_No),
    FOREIGN KEY (Roll_No) REFERENCES Student(Roll_No)
);

-- Criação de dados -----------------------------------------------------------------------------------------------------------------------
INSERT INTO Address (Address_ID, Country, State, City, Street)
VALUES('3', 'Alemanha', 'Bade-Vurtemberga', 'Ulm', 'A'),
	  ('7', 'Brasil', 'Santa Catarina', 'Florianópolis', 'B'),
      ('9', 'Alemanha', 'Bade-Vurtemberga', 'Mannheim', 'C'),
	  ('14', 'Alemanha', 'Bade-Vurtemberga', 'Ulm', 'D');
INSERT INTO Student (Nome, DOB, Address_ID)
VALUES('Gabriele', '2000-04-20', '7'),
	  ('Fernando', '1990-06-10', '9'),
      ('Rodrigo', '1930-02-05', '3'),
      ('Laura', '2007-09-15', '14');

INSERT INTO Student_Phone (Roll_No, Phone_Code, Phone_Number)
VALUES(1, '+55', '48 967654322'),
	  (2, '+49', '34 864653312'),
      (3, '+49', '34 037455392'),
      (4, '+49', '34 664679342');