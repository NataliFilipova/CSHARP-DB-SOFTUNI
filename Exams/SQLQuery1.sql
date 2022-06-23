CREATE DATABASE [CigarShop]
GO

USE [CigarShop]

GO

CREATE TABLE [Sizes] 
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Length] INT NOT NULL CHECK ([Length] >= 10 AND [Length] <= 25),
	[RingRange] DECIMAL (18,2) NOT NULL CHECK ([RingRange] >= 10 AND [RingRange] <= 7.5)
)

CREATE TABLE [Tastes]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[TasteType] VARCHAR (20) NOT NULL,
	[TasteStrength] VARCHAR (15) NOT NULL,
	[ImageURL] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Brands]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[BrandName] VARCHAR (30) NOT NULL UNIQUE,
	[BrandDescription]

)