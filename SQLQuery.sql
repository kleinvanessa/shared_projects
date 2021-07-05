/****** Script for SelectTopNRows command from SSMS  ******/


INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Ciências Exatas e da Terra');
INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Lingüística, Letras e Artes');
INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Engenharias');

INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact]) VALUES ('nome1', 'sobrenome','email@email.com','senha123', '5199999');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password], [Contact]) VALUES ('nome2', 'sobrenome','email@e.c','senha123','21548888');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password],[Contact]) VALUES ('nome3', 'sobrenome','email@e.com','senha123','22222222');


INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId]) VALUES ('proj1','desc2',1, 1);
INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId]) VALUES ('proj2','desc2',2,2);
INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId],[userAdminId]) VALUES ('proj3','desc2',3,3);

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