/****** Script for SelectTopNRows command from SSMS  ******/


INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Ci�ncias Exatas e da Terra');
INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Ling��stica, Letras e Artes');
INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Engenharias');

INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Vanessa', 'Klein','vanessa@email.com','123456', '5199999','assets/img/profile.jpg');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Jo�o', 'Ernesto','joao@email.com','123456', '5199999','assets/img/img5.png');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Maria', 'Silveira','maria@email.com','123456', '5199999','assets/img/img1.png');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Pedro', 'Carvalho Silva','pedro@email.com','123456', '5199999','assets/img/img3.png');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Joana', 'Oliveira Braga','joana@e.c','123456','21548888','assets/img/img2.png');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password],[Contact], [Image]) VALUES ('Fernando', 'Gomes','fernando@e.com','123456','22222222','assets/img/undefined.png');


INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId],[ProjectType],[Duration],[Value]) VALUES ('Pesquisa sobre as Linguas e suas Referencias','A l�ngua portuguesa, tamb�m designada portugu�s, � uma l�ngua rom�nica flexiva ocidental originada no galego-portugu�s falado no Reino da Galiza e no norte de Portugal. Com a cria��o do Reino de Portugal em 1139 e a expans�o para o sul na sequ�ncia da Reconquista deu-se a difus�o da l�ngua pelas terras conquistadas e mais tarde, com as descobertas portuguesas, para o Brasil, �frica e outras partes do mundo.[3] O portugu�s foi usado, naquela �poca, n�o somente nas cidades conquistadas pelos portugueses, mas tamb�m por muitos governantes locais nos seus contatos com outros estrangeiros poderosos. Especialmente nessa altura a l�ngua portuguesa tamb�m influenciou v�rias l�nguas.[4]

Durante a Era dos Descobrimentos, marinheiros portugueses levaram o seu idioma para lugares distantes. A explora��o foi seguida por tentativas de colonizar novas terras para o Imp�rio Portugu�s e, como resultado, o portugu�s dispersou-se pelo mundo. Brasil e Portugal s�o os dois �nicos pa�ses cuja l�ngua prim�ria � o portugu�s.',2, 1,'Voluntariado',2,0);
INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId],[ProjectType],[Duration],[Value]) VALUES ('Como a Engenharia afeta nas vidas das pessoas em 2021','O Instituto T�cnico-Cient�fico de Per�cia do Rio Grande do Norte publicou o edital com 255 vagas para os cargos de Perito M�dico Legista, Perito Odontolegista, Perito Criminal, Assistente T�cnico Forense, Agente de Necropsia, Agente T�cnico Forense.

As vagas para profissionais de engenharia constam nos cargo de Perito Criminal � engenharia civil, perito criminal � engenharia el�trica, perito criminal � engenharia mec�nica,  perito criminal � engenharia qu�mica e perito criminal � meio ambente, que � detinado para profissionais com n�vel superior em Engenharia Florestal, Engenharia Agron�mica, Engenharia Ambiental, Engenharia Sanit�ria, Engenharia de Aquicultura, Oceanografia, Geologia, Agronomia, Engenharia Agr�cola, Engenharia Sanit�ria, Engenharia Cartogr�fica, Ci�ncias Agr�rias ou Zootecnia.',3,2,'Extens�o',0.5, 600);
INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId],[ProjectType],[Duration],[Value]) VALUES ('Usando Python em Processamento de Imagens','Hoje em dia, o Python Programming Language possui in�meras aplica��es e � utilizado por diversas empresas bem sucedidas e institui��es consagradas no mercado, como Google, Youtube e at� a NASA, isso mesmo a NASA!Nossa! Mas s� organiza��es desse porte usam Python? N�o!Essa linguagem foi feita por Guido, com o ideal de programa��o para todos. E por isso, ela possui alta modularidade. Isso significa que j� foram feitas v�rias bibliotecas que possuem fun��es espec�ficas. Em Python, chamamos essas bibliotecas de m�dulos.Os m�dulos permitem ampliar as capacidades da linguagem de programa��o, acrescentando os mais diferenciados recursos e ferramentas.',1,3,'Pesquisa',1,400);

INSERT INTO [dbo].[UserProject] ([UserId],[ProjectId]) VALUES (1,1);
INSERT INTO [dbo].[UserProject] ([UserId],[ProjectId]) VALUES (2,2);
INSERT INTO [dbo].[UserProject] ([UserId],[ProjectId]) VALUES (3,3);

INSERT INTO [dbo].[EnrolledProjects] ([UserId],[ProjectId]) VALUES (1,2);
INSERT INTO [dbo].[EnrolledProjects] ([UserId],[ProjectId]) VALUES (2,3);
INSERT INTO [dbo].[EnrolledProjects] ([UserId],[ProjectId]) VALUES (3,1);




SELECT * FROM [SharedProjects].[dbo].[AreaKnowledge];

SELECT * FROM [SharedProjects].[dbo].[Curriculum];

SELECT * FROM [SharedProjects].[dbo].[Payment];

SELECT * FROM [SharedProjects].[dbo].[Favorite];

SELECT * FROM [SharedProjects].[dbo].[User];

SELECT * FROM [SharedProjects].[dbo].[Project];

SELECT * FROM [SharedProjects].[dbo].[UserProject] where ProjectId = 1;

SELECT * FROM [SharedProjects].[dbo].[EnrolledProjects] where ProjectId = 1;

--delete from [SharedProjects].[dbo].[EnrolledProjects] 

SELECT ProjectId FROM [SharedProjects].[dbo].[UserProject] WHERE UserId =1;

SELECT * FROM [SharedProjects].[dbo].[Project] P 
INNER JOIN  [SharedProjects].[dbo].[UserProject] Up ON Up.UserId = 3 
WHERE P.Id = Up.ProjectId;


SELECT * FROM [SharedProjects].[dbo].[Project] P 
INNER JOIN  [SharedProjects].[dbo].[EnrolledProjects] E ON E.UserId = 2 
WHERE P.Id = E.ProjectId;


SELECT * FROM [SharedProjects].[dbo].[User] U 
INNER JOIN  [SharedProjects].[dbo].[EnrolledProjects] E ON E.ProjectId = 7  
WHERE U.Id = E.UserId;

--DELETE FROM [SharedProjects].[dbo].[Curriculum] WHERE	Id =3;

--delete from [SharedProjects].[dbo].[Favorite] where id = 18