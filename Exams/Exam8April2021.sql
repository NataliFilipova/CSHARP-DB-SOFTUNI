CREATE DATABASE [Service]
GO

USE [Service]

GO

--Problem 1

CREATE TABLE [Users] 
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(50) NOT NULL,
	[Name] VARCHAR(50),
	[Birthdate] DATETIME,
	[Age] INT CHECK ([Age] >=14 AND [Age] <=110),
	[Email] VARCHAR(50) NOT NULL
)

CREATE TABLE [Departments] 
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE [Employees] 
(
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] VARCHAR(25),
	[LastName] VARCHAR(25),
	[Birthdate] DATETIME,
	[Age] INT  CHECK ([Age] >=18 AND [Age] <=110),
	[DepartmentId] INT FOREIGN KEY REFERENCES [Departments]([Id])
)
CREATE TABLE [Categories] 
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	[DepartmentId] INT FOREIGN KEY REFERENCES [Departments]([Id]) NOT NULL
)

CREATE TABLE [Status] 
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Label] VARCHAR(30) NOT NULL
)

CREATE TABLE [Reports] 
(
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]) NOT NULL,
	[StatusId] INT FOREIGN KEY REFERENCES [Status]([Id]) NOT NULL,
	[OpenDate] DATETIME NOT NULL,
	[CloseDate] DATETIME,
	[Description] VARCHAR (200) NOT NULL,
	[UserId] INT FOREIGN KEY REFERENCES [Users]([Id]) NOT NULL,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id])

)




--Problem 2

INSERT INTO [Employees] ([FirstName], [LastName], [Birthdate], [DepartmentId])
	VALUES

		('Marlo','O''Malley' , '1958-9-21', 1),
		('Niki','Stanaghan', '1969-11-26', 4),
		('Ayrton','Senna', '1960-03-21', 9),
		('Ronnie','Peterson',	'1944-02-14',9),
		('Giovanna','Amati', '1959-07-20',5)
	
INSERT INTO [Reports] ([CategoryId],[StatusId],[OpenDate],[CloseDate],[Description],[UserId],[EmployeeId])
	VALUES
	(1, 1, '2017-04-13', NULL, 'Stuck Road on Str.133', 6, 2),
	(6, 3, '2015-09-05', '2015-12-06','Charity trail running',	3,	5),
	(14, 2, '2015-09-07', NULL,	'Falling bricks on Str.58',	5,	2),
	(4,	3,	'2017-07-03','2017-07-06',	'Cut off streetlight on Str.11',	1,	1)

--Problem 3

UPDATE [Reports] 
	SET [CloseDate] = GETDATE() 
	WHERE [CloseDate] IS NULL

--Problem 4

DELETE [Reports]
	WHERE [StatusId] = 4

--Problem 5

USE [Service]

SELECT [Description], FORMAT( [OpenDate] , 'dd-MM-yyyy') 
	FROM [Reports]
	WHERE [EmployeeId] IS NULL
ORDER BY [OpenDate], [Description]

--Problem 6

SELECT [r].[Description], [c].[Name] AS [CategoryName]
	FROM [Reports] AS [r]
	INNER JOIN [Categories] AS [c]
	ON [r].[CategoryId] = [c].[Id]
	ORDER BY [r].[Description], [c].[Name]

--Problem 7

SELECT TOP(5) [c].[Name], COUNT([r].[CategoryId]) AS [ReportsNumber]
	FROM [Reports] AS [r]
	INNER JOIN [Categories] AS [c]
	ON [r].[CategoryId] = [c].[Id]
	GROUP BY [c].[Name]
	ORDER BY [ReportsNumber] DESC, [c].[Name]

--Problem 8

SELECT [u].[Username], [c].[Name] AS [CategoryName]
	FROM [Reports] AS [r]
	INNER JOIN [Users] AS [u]
	ON [r].[UserId] = [u].[Id]
	INNER JOIN [Categories] AS [c]
	ON [r].[CategoryId] =  [c].[Id]
	WHERE MONTH([u].[Birthdate]) = MONTH([r].[OpenDate]) AND DAY([u].[Birthdate]) = DAY([r].[OpenDate] )
	ORDER BY [u].[Username] , [c].[Name]


--Problem 9
SELECT CONCAT([e].[FirstName],' ', [e].[LastName]) AS [FullName] , COUNT([r].[UserId]) AS [UsersCount]
	FROM [Employees] AS [e]
	LEFT JOIN [Reports] AS [r]
	ON [e].[Id] = [r].[EmployeeId]
	GROUP BY [e].[FirstName], [e].[LastName]
	ORDER BY [UsersCount] DESC, [FullName]

--Problem 10

SELECT

CASE 
	WHEN [e].[FirstName] IS NULL THEN 'None'
	ELSE 
CONCAT([e].[FirstName], ' ', [e].[LastName])END AS [Employee],

	CASE
			WHEN  [d].[Name] IS NULL THEN 'None'
			ELSE [d].[Name]
			END AS [Department], 
			[c].[Name] AS [Category], [r].[Description], FORMAT([r].[OpenDate],'dd.MM.yyyy') , [s].[Label] AS [Status], [u].[Name] AS [User]
	 
	FROM [Reports] AS [r]
	LEFT JOIN [Employees] AS [e]
	ON [r].[EmployeeId] = [e].[Id]
	LEFT JOIN [Departments] AS [d]
	ON [e].[DepartmentId] = [d].[Id]
	LEFT JOIN [Categories] AS [c]
	ON [r].[CategoryId] = [c].[Id]
	LEFT JOIN [Status] AS [s]
	ON [r].[StatusId] = [s].Id
	LEFT JOIN [Users] AS [u]
	ON [r].[UserId] = [u].[Id]

	ORDER BY [e].[FirstName] DESC, [e].[LastName] DESC, [d].[Name], [c].[Name], [r].[Description], [r].[OpenDate], [s].[Label], [u].[Username]

--Problem 11
GO 
CREATE FUNCTION  udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS BEGIN 
	IF @StartDate IS NULL OR @EndDate IS NULL
	BEGIN
	RETURN 0
	END
	
	RETURN DATEDIFF(hour, @StartDate, @EndDate)
	
END

--Problem 12
GO
CREATE PROC usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT)
AS
BEGIN
	BEGIN TRANSACTION
		DECLARE @EmpDepart INT = (
		SELECT DepartmentId FROM Employees WHERE Id = @EmployeeId)
		DECLARE @CategId INT = (
		SELECT CategoryId FROM Reports WHERE Id = @ReportId)
		DECLARE @ReportDepart INT = (
		SELECT DepartmentId FROM Categories WHERE Id = @CategId)
			IF (@EmpDepart <> @ReportDepart)
			BEGIN
				ROLLBACK;
				THROW 50001, 'Employee doesn''t belong to the appropriate department!', 1
			END

			UPDATE Reports
			SET EmployeeId = @EmployeeId
			WHERE Id = @ReportId
	COMMIT
END			