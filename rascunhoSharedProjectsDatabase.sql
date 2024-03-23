-- 


CREATE TABLE USERS
(
	id_user  NUMERIC(6) IDENTITY(1,1) NOT NULL,
	firstname VARCHAR(150) NOT NULL,
	lastname VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL,
	--birth_date DATE NOT NULL,

	CONSTRAINT PK_EMP PRIMARY KEY (id_user),
	--CONSTRAINT CK_BIRTH_MIN CHECK (DATEDIFF(dd, birth_date, getdate()) >= 5482.5),
	--CONSTRAINT CK_BIRTH_MAX CHECK (DATEDIFF(dd, birth_date, getdate()) < 38351.25)
	--CONSTRAINT ALTERADA, 6574.5 E 38351.25 S�O RESPECTIVAMENTE 15 E 105 ANOS EM DIAS QUE S�O USADOS PARA VERIFICAR AS DATAS
	--LIMITES PARA INGRESSAR NA EMPRESA, OS ANOS FORAM MULTIPLICADOS POR 365.5.
);

INSERT INTO USERS (firstname, lastname,email)
	VALUES('Vanessa', 'Klein', 'vanessa@gmail.com');
INSERT INTO USERS (firstname, lastname,email)
	VALUES('teste1', 'teste1.1', 'tst1@gmail.com');
INSERT INTO USERS (firstname, lastname,email)
	VALUES('teste2', 'teste2.2', 'tst2@gmail.com');
INSERT INTO USERS (firstname, lastname,email)
	VALUES('teste3', 'teste3.3', 'tst3@gmail.com');
INSERT INTO USERS (firstname, lastname,email)
	VALUES('teste4', 'teste4.4', 'tst4@gmail.com');

Select * from USERS;
