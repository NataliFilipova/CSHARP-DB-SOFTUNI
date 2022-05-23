CREATE DATABASE [Minions]

USE [Minions]

GO

CREATE  TABLE [Minions] (
	[Id] INT PRIMARY KEY, 
	[Name] NVARCHAR (50) NOT NULL,
	[AGE] INT NOT NULL
)

CREATE TABLE [Towns] (
	[Id] INT PRIMARY KEY,
	[Name] NVARCHAR (50) NOT NULL,
)

ALTER TABLE [Minions]
ADD [TownId] INT FOREIGN KEY REFERENCES [Towns] ([Id]) NOT NULL

GO

INSERT INTO [Towns] ([Id], [Name]) 
	VALUES 
	(1, 'Sofia'),
	(2, 'Plovdiv'),
	(3, 'Varna')

ALTER TABLE  [Minions] 
ALTER COLUMN [AGE] INT

INSERT INTO [Minions] ([Id], [Name], [Age], [TownId])
	VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)
		
TRUNCATE TABLE [Minions]

GO

CREATE TABLE [People] (
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY (MAX)
	CHECK ( DATALENGTH ([Picture]) <= 2000000),
	[Height] DECIMAL(3, 2),
	[Weight] DECIMAL(5, 2),
	[Gender] Char(1) NOT NULL,
	CHECK ([Gender] = 'm' OR [Gender] = 'f'),
	[BirthDate] DATE NOT NULL,
	[Biography] NVARCHAR(MAX) 
)

INSERT INTO [People] ([Name], [Height], [Weight], [Gender], [BirthDate])
	VALUES
('Pesho', 1.77, 75.2, 'm', '1998-05-25'),
('Gosho', NULL, NULL, 'm' , '1977-11-05'),
('Maria', 1.65, 42.2, 'f', '1998-06-27'),
('Vicky', NULL, NULL, 'f', '1983-02-02'),
('Vancho', 1.69, 77.8, 'm', '1993-03-03')

GO

CREATE TABLE [Users] (
	[Id] INT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY (MAX),
	CHECK (DATALENGTH([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT NOT NULL
)

INSERT INTO [Users] ([Username], [Password],[LastLoginTime],[IsDeleted])
	VALUES 
('iva', 'pass1' , '2020-12-23 15:40:45', 0),
('iva11', 'pass1' , '2020-12-23 15:46:45', 0),
('iva13', 'pass1' , '2020-12-23 15:45:45', 1),
('iva3', 'pass1' , '2020-12-23 15:42:45', 1),
('iva2', 'pass1' , '2020-12-23 15:40:45', 1)

ALTER TABLE [Users]
DROP CONSTRAINT [PK__Users__3214EC0798B55EB7]

ALTER TABLE [Users]
ADD CONSTRAINT [PK_UsersCompositeIdUsername] PRIMARY KEY ([Id], [Username])


GO

CREATE TABLE [Directors] (
	[Id] INT PRIMARY KEY NOT NULL,
	[DirectorName] NVARCHAR (50) NOT NULL,
	[Notes] NVARCHAR (MAX)

)

INSERT INTO [Directors] ([Id], [DirectorName], [Notes])
	VALUES
(1, 'Ivan', 'Smth'),
(4, 'Ivan', 'Smth'),
(5, 'Ivan', 'Smth'),
(12, 'Ivan', 'Smth'),
(123, 'Ivan', 'Smth')

GO

CREATE TABLE [Genres] (
	[Id] INT PRIMARY KEY NOT NULL,
	[GenreName] NVARCHAR (50) NOT NULL,
	[Notes] NVARCHAR (MAX)

)

INSERT INTO [Genres] ([Id], [GenreName], [Notes])
	VALUES
(56, 'Ivan', 'Smth'),
(57, 'Ivan', 'Smth'),
(58, 'Ivan', 'Smth'),
(59, 'Ivan', 'Smth'),
(60, 'Ivan', 'Smth')

GO

CREATE TABLE [Categories] (
	[Id] INT PRIMARY KEY NOT NULL,
	[CategoryName] NVARCHAR (50) NOT NULL,
	[Notes] NVARCHAR (MAX)

)

INSERT INTO [Categories] ([Id], [CategoryName], [Notes])
	VALUES
(561, 'Ivan22', 'Smth'),
(572, 'Ivan2', 'Smth'),
(583, 'Ivan3', 'Smth'),
(594, 'Ivan4', 'Smth'),
(605, 'Iva4n', 'Smth')

GO

CREATE TABLE Movies    
(
    Id INT PRIMARY KEY NOT NULL,
    Titles VARCHAR(90) NOT NULL,
    DirectorId INT NOT NULL,
    CopyrightYear DATE,
    [Length] TIME NOT NULL,
    GenreId INT NOT NULL,
    CategoryId INT NOT NULL,
    Rating INT,
    Notes NVARCHAR(MAX)
)

INSERT INTO Movies(Id, Titles,DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes) VALUES
(1, 'The Nun', 1, NULL, '02:29:49', 1, 1, 8, Null),
(2, 'Interstelar', 2, NULL, '02:29:49', 2, 2, 9, Null),
(3, 'Blabla', 3, NULL, '02:19:59', 3, 3, 6, Null),
(4, 'LAla', 3, NULL, '04:29:39', 3, 3, 7, Null),
(5, 'Lala Land', 3, NULL, '01:59:59', 3, 3, 5, Null)
