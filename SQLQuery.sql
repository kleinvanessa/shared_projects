/****** Script for SelectTopNRows command from SSMS  ******/


INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Ciências Exatas e da Terra');
INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Lingüística, Letras e Artes');
INSERT INTO [dbo].[AreaKnowledge] ([AreaKnowledgeName]) VALUES ('Engenharias');


INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId]) VALUES ('proj1','desc2',1);
INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId]) VALUES ('proj2','desc2',2);
INSERT INTO [dbo].[Project] ([ProjectName],[Description],[CategoryId]) VALUES ('proj3','desc2',3);

INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password]) VALUES ('nome1', 'sobrenome','email@email.com','senha');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password]) VALUES ('nome2', 'sobrenome','email@e.c','senha');
INSERT INTO [dbo].[User] ([FirstName] ,[LastName] ,[Email] ,[Password]) VALUES ('nome3', 'sobrenome','email@e.com','senha');



SELECT * FROM [SharedProjects].[dbo].[AreaKnowledge];

SELECT * FROM [SharedProjects].[dbo].[User];

SELECT * FROM [SharedProjects].[dbo].[Project];

SELECT * FROM [SharedProjects].[dbo].[UserProject];


SELECT ProjectId FROM [SharedProjects].[dbo].[UserProject] WHERE UserId =1;

SELECT * FROM [SharedProjects].[dbo].[Project] P 
INNER JOIN  [SharedProjects].[dbo].[UserProject] Up ON Up.UserId = 3 
WHERE P.Id = Up.ProjectId;


