-- O banco deve se chamar "DesafioDaniel"
CREATE TABLE DEPARTMENTS 
(
	id_dep NUMERIC(6) IDENTITY(1,1) NOT NULL,
	name VARCHAR(50) NOT NULL,
	description VARCHAR(300) NULL,

	CONSTRAINT PK_DEP PRIMARY KEY (id_dep)
);

INSERT INTO DEPARTMENTS (name, description)
	VALUES('Vendas', 'Onde é vendido produtos');
INSERT INTO DEPARTMENTS (name, description)
	VALUES('Compras', 'Onde é comprado o material');
INSERT INTO DEPARTMENTS (name, description)
	VALUES('Estoque', 'Organiza o estoque');
INSERT INTO DEPARTMENTS (name)
	VALUES('Infraestrutura');



CREATE TABLE USERS
(
	id_user  NUMERIC(6) IDENTITY(1,1) NOT NULL,
	firstname VARCHAR(150) NOT NULL,
	lastname VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL,
	birth_date DATE NOT NULL,

	CONSTRAINT PK_EMP PRIMARY KEY (id_user),
	CONSTRAINT CK_BIRTH_MIN CHECK (DATEDIFF(dd, birth_date, getdate()) >= 5482.5),
	CONSTRAINT CK_BIRTH_MAX CHECK (DATEDIFF(dd, birth_date, getdate()) < 38351.25)
	--CONSTRAINT ALTERADA, 6574.5 E 38351.25 S�O RESPECTIVAMENTE 15 E 105 ANOS EM DIAS QUE S�O USADOS PARA VERIFICAR AS DATAS
	--LIMITES PARA INGRESSAR NA EMPRESA, OS ANOS FORAM MULTIPLICADOS POR 365.5.
);

INSERT INTO USERS (name, sex, birth_date, salary)
	VALUES('Joãozinho', 'M', CONVERT(date, '20/09/1999', 103), 1000.50);
INSERT INTO USERS (name, sex, birth_date, salary)
	VALUES('Daniela', 'F', CONVERT(date, '26/09/1999', 103), 1000.50);
INSERT INTO USERS (name, birth_date, salary)
	VALUES('Alex', CONVERT(date, '10/03/1999', 103), 1000.50);
INSERT INTO USERS (name, sex, birth_date, salary)
	VALUES('Caio', 'M', CONVERT(date, '21/01/1999', 103), 1000.50);


CREATE TABLE PROJECTS
(
	n_project NUMERIC(6) IDENTITY(1,1) NOT NULL,
	name VARCHAR(150) NOT NULL,
	id_dep NUMERIC(6) NOT NULL,
	description VARCHAR(300) NOT NULL,
	start_date DATE NOT NULL,
	final_date DATE NOT NULL,

	CONSTRAINT PK_PROJ PRIMARY KEY (n_project),
	CONSTRAINT FK_PROJ_DEP FOREIGN KEY (id_dep)
		REFERENCES DEPARTMENTS (id_dep)
			ON UPDATE CASCADE
			ON DELETE CASCADE
);

INSERT INTO PROJECTS (name, id_dep, description, start_date, final_date)
	VALUES('ProjetoDaniel', 1, 'Elaborar um APP que consulte um banco', CONVERT(date, '25/09/2020', 103), CONVERT(date, '08/10/2020', 103));
INSERT INTO PROJECTS (name, id_dep, description, start_date, final_date)
	VALUES('Floricultura', 2, 'Criar uma floricultura', CONVERT(date, '20/08/2020', 103), CONVERT(date, '25/10/2020', 103));
INSERT INTO PROJECTS (name, id_dep, description, start_date, final_date)
	VALUES('Carnes', 3, 'Organizar as carnes no deposito', CONVERT(date, '02/02/2020', 103), CONVERT(date, '08/11/2020', 103));
INSERT INTO PROJECTS (name, id_dep, description, start_date, final_date)
	VALUES('Lojinha na WEB', 2, 'Fazer um site para a loja', CONVERT(date, '25/09/2020', 103), CONVERT(date, '08/10/2021', 103));
INSERT INTO PROJECTS (name, id_dep, description, start_date, final_date)
	VALUES('Aumentar vendas', 1, 'Montar uma campanha de marketing', CONVERT(date, '20/09/2018', 103), CONVERT(date, '08/10/2022', 103));
INSERT INTO PROJECTS (name, id_dep, description, start_date, final_date)
	VALUES('Cartão fidelidade', 2, 'Fazer cartão para fidelizar os clientes', CONVERT(date, '25/09/2020', 103), CONVERT(date, '08/10/2020', 103));

CREATE TABLE PROJECTS_EMPLOYEES
(
	n_project NUMERIC(6) NOT NULL,
	id_employee NUMERIC(6) NOT NULL,

	CONSTRAINT PK_PROj_EMP PRIMARY KEY (n_project, id_employee),
	CONSTRAINT FK_PE_EMP FOREIGN KEY (id_employee)
		REFERENCES EMPLOYEES (id_employee)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
	CONSTRAINT FK_PE_PROJ FOREIGN KEY (n_project)
		REFERENCES PROJECTS (n_project)
			ON UPDATE CASCADE
			ON DELETE CASCADE
);

INSERT INTO PROJECTS_EMPLOYEES (n_project, id_employee)
	VALUES(1, 2);
INSERT INTO PROJECTS_EMPLOYEES (n_project, id_employee)
	VALUES(2, 2);
INSERT INTO PROJECTS_EMPLOYEES (n_project, id_employee)
	VALUES(3, 2);
INSERT INTO PROJECTS_EMPLOYEES (n_project, id_employee)
	VALUES(1, 1);
INSERT INTO PROJECTS_EMPLOYEES (n_project, id_employee)
	VALUES(1, 3);
INSERT INTO PROJECTS_EMPLOYEES (n_project, id_employee)
	VALUES(1, 4);
INSERT INTO PROJECTS_EMPLOYEES (n_project, id_employee)
	VALUES(6, 3);
INSERT INTO PROJECTS_EMPLOYEES (n_project, id_employee)
	VALUES(3, 4);

