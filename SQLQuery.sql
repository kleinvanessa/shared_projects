/****** Script for SelectTopNRows command from SSMS  ******/


INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Ciências Exatas e da Terra');
INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Lingüística, Letras e Artes');
INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Engenharias');

INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Vanessa', 'Klein','vanessa@email.com','123456', '5199999','assets/img/profile.jpg');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('João', 'Ernesto','joao@email.com','123456', '5199999','assets/img/img5.png');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Maria', 'Silveira','maria@email.com','123456', '5199999','assets/img/img1.png');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Pedro', 'Carvalho Silva','pedro@email.com','123456', '5199999','assets/img/img3.png');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact], [Image]) VALUES ('Joana', 'Oliveira Braga','joana@e.c','123456','21548888','assets/img/img2.png');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password],[Contact], [Image]) VALUES ('Fernando', 'Gomes','fernando@e.com','123456','22222222','assets/img/undefined.png');


INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId],[ProjectType],[Duration],[Value]) VALUES ('Pesquisa sobre as Linguas e suas Referencias','A língua portuguesa, também designada português, é uma língua românica flexiva ocidental originada no galego-português falado no Reino da Galiza e no norte de Portugal. Com a criação do Reino de Portugal em 1139 e a expansão para o sul na sequência da Reconquista deu-se a difusão da língua pelas terras conquistadas e mais tarde, com as descobertas portuguesas, para o Brasil, África e outras partes do mundo.[3] O português foi usado, naquela época, não somente nas cidades conquistadas pelos portugueses, mas também por muitos governantes locais nos seus contatos com outros estrangeiros poderosos. Especialmente nessa altura a língua portuguesa também influenciou várias línguas.[4]

Durante a Era dos Descobrimentos, marinheiros portugueses levaram o seu idioma para lugares distantes. A exploração foi seguida por tentativas de colonizar novas terras para o Império Português e, como resultado, o português dispersou-se pelo mundo. Brasil e Portugal são os dois únicos países cuja língua primária é o português.',2, 1,'Voluntariado',2,0);
INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId],[ProjectType],[Duration],[Value]) VALUES ('Como a Engenharia afeta nas vidas das pessoas em 2021','O Instituto Técnico-Científico de Perícia do Rio Grande do Norte publicou o edital com 255 vagas para os cargos de Perito Médico Legista, Perito Odontolegista, Perito Criminal, Assistente Técnico Forense, Agente de Necropsia, Agente Técnico Forense.

As vagas para profissionais de engenharia constam nos cargo de Perito Criminal – engenharia civil, perito criminal – engenharia elétrica, perito criminal – engenharia mecânica,  perito criminal – engenharia química e perito criminal – meio ambente, que é detinado para profissionais com nível superior em Engenharia Florestal, Engenharia Agronômica, Engenharia Ambiental, Engenharia Sanitária, Engenharia de Aquicultura, Oceanografia, Geologia, Agronomia, Engenharia Agrícola, Engenharia Sanitária, Engenharia Cartográfica, Ciências Agrárias ou Zootecnia.',3,2,'Extensão',0.5, 600);
INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId],[ProjectType],[Duration],[Value]) VALUES ('Usando Python em Processamento de Imagens','Hoje em dia, o Python Programming Language possui inúmeras aplicações e é utilizado por diversas empresas bem sucedidas e instituições consagradas no mercado, como Google, Youtube e até a NASA, isso mesmo a NASA!Nossa! Mas só organizações desse porte usam Python? Não!Essa linguagem foi feita por Guido, com o ideal de programação para todos. E por isso, ela possui alta modularidade. Isso significa que já foram feitas várias bibliotecas que possuem funções específicas. Em Python, chamamos essas bibliotecas de módulos.Os módulos permitem ampliar as capacidades da linguagem de programação, acrescentando os mais diferenciados recursos e ferramentas.',1,3,'Pesquisa',1,400);

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