
-- Problem 1

CREATE TABLE [Persons] 
(
[PersonID] INT NOT NULL,
[FirstName] NVARCHAR(20) NOT NULL,
[Salary] DECIMAL
)
CREATE TABLE [Passports]
(
[PassportID] INT PRIMARY KEY,
[PassportNumber] NVARCHAR(40) NOT NULL
)
ALTER TABLE [Persons]
ADD CONSTRAINT PK_PersonID
PRIMARY KEY (PersonID)

ALTER TABLE [Persons]
ADD [PassportID] INT FOREIGN KEY REFERENCES [Passports](PassportID)


-- Problem 2

CREATE TABLE [Manufacturers] (
	[ManufacturerID] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) NOT NULL,
	[EstablishedOn] DATE NOT NULL
)

CREATE TABLE [Models]
(
 [ModelID] INT PRIMARY KEY IDENTITY (101,1),
 [Name]  VARCHAR (35) NOT NULL,
 [ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers](ManufacturerID) 

)

--Problem 3

CREATE TABLE [Students]  (
	[StudentID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR (40) NOT NULL
)

CREATE TABLE [Exams] (
	[ExamID] INT PRIMARY KEY IDENTITY (101,1),
	[Name] NVARCHAR (70) NOT NULL
)

CREATE TABLE [StudentsExams] (
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[ExamID] INT FOREIGN KEY REFERENCES [Exams]([ExamID]),
	PRIMARY KEY ([StudentId], [ExamID])
)

-- Problem 4

CREATE TABLE [Teachers] (
  [TeacherID] INT PRIMARY KEY IDENTITY (101,1),
  [Name] NVARCHAR(50) NOT NULL,
  [ManagerID] INT FOREIGN KEY REFERENCES [Teachers] ([TeacherID])

)

-- Problem 5

CREATE TABLE [ItemTypes]
(
[ItemTypeID] INT PRIMARY KEY,
[Name] VARCHAR(50)
)
CREATE TABLE [Items]
(
[ItemID] INT PRIMARY KEY,
[Name] VARCHAR(50),
[ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes] ([ItemTypeID]) NOT NULL
)
CREATE TABLE [Cities]
(
[CityID] INT PRIMARY KEY,
[Name] VARCHAR(50)
)
CREATE TABLE [Customers]
(
[CustomerID] INT PRIMARY KEY,
[Name] VARCHAR(50),
[Birtday] DATE,
[CityID] INT FOREIGN KEY REFERENCES [Cities] (CityID)
)

CREATE TABLE [Orders]
(
[OrderID] INT PRIMARY KEY,
[CustomerID] INT FOREIGN KEY REFERENCES [Customers] (CustomerID)
)
CREATE TABLE [OrderItems]
(
[OrderID] INT FOREIGN KEY REFERENCES [Orders]([OrderID]),
[ItemID] INT FOREIGN KEY REFERENCES [Items] (ItemID),
PRIMARY KEY (OrderID,ItemID)
)

-- Problem 6

CREATE TABLE [Subjects]
(
[SubjectID] INT PRIMARY KEY,
[SubjectName] VARCHAR(50)
)
CREATE TABLE [Majors]
(
[MajorID] INT PRIMARY KEY,
[Name] VARCHAR(50)
)
CREATE TABLE [Students]
(
[StudentID] INT PRIMARY KEY,
[StudentNumber] INT,
[StudentName] VARCHAR(50),
[MajorID] INT FOREIGN KEY REFERENCES [Majors] (MajorID)
)
CREATE TABLE [Payments]
(
[PaymentID] INT PRIMARY KEY,
[PaymentDate] DATE,
[PaymentAmount] DECIMAL,
[StudentID] INT FOREIGN KEY REFERENCES [Students] ([StudentID])
)
CREATE TABLE [Agenda]
(
[StudentID] INT FOREIGN KEY REFERENCES [Students] (StudentID),
[SubjectID] INT FOREIGN KEY REFERENCES [Subjects] (SubjectID),
PRIMARY KEY (StudentID,SubjectID)
)

-- Problem 9
SELECT  [m].[MountainRange], [p].[PeakName], [p].[Elevation]
	FROM [Mountains] AS [m]
LEFT JOIN [Peaks] AS [p]
		ON [p].[MountainId] = [m].[Id]
WHERE [MountainRange] = 'Rila'
ORDER BY [p].[Elevation] DESC
