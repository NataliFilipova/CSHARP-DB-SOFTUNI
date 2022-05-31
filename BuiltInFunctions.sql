USE [SoftUni]

GO

--Problem 1
SELECT [FirstName], [LastName]
	FROM [Employees]
--	WHERE [FirstName] LIKE 'Sa%'

WHERE LEFT([FirstName], 2) = 'Sa'

--Problem 2

SELECT [FirstName], [LastName]
FROM [Employees]
WHERE [LastName] LIKE '%ei%'  


--Problem 3
SELECT [FirstName]
	FROM [Employees]
	WHERE [DepartmentID] IN (3,10) AND YEAR([HireDate]) BETWEEN 1995 AND 2005 --/DATEPART(YEAR, [HireDate]) 

--Problem 4

SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE [JobTitle] NOT LIKE '%engineer%'


--Problem 5

SELECT [Name]
	FROM [Towns]
	WHERE LEN([Name]) IN (5,6)
ORDER BY [Name]

--Problem 6

SELECT *
	FROM [Towns]
	WHERE LEFT([Name], 1) IN ('M', 'K' ,'B', 'E')
ORDER BY [Name]

--Problem 7
SELECT *
	FROM [Towns]
	WHERE LEFT([Name], 1)NOT IN ('R', 'B' ,'D')
ORDER BY [Name]

--Problem 8
GO


CREATE VIEW V_EmployeesHiredAfter2000 AS
	SELECT [FirstName], [LastName]
	FROM  [Employees]
WHERE YEAR(HireDate) > 2000

GO

--Problem 9

SELECT [FirstName], [LastName]
	FROM [Employees]
	WHERE LEN(LastName) = 5


--Problem 10

SELECT [EmployeeID], [FirstName], [LastName], [Salary],
		DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
		AS [RANK]
	FROM [Employees]
	WHERE [Salary] BETWEEN 10000 AND 50000
	ORDER BY [SALARY] DESC

--Problem 11
SELECT *
FROM (
	SELECT [EmployeeID], [FirstName], [LastName], [Salary],
			DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
			AS [RANK]
		FROM [Employees]
		WHERE [Salary] BETWEEN 10000 AND 50000 
		
	) 
	AS [RankingSubquery]
	WHERE [RANK] = 2
	ORDER BY [Salary] DESC

GO 

USE [Geography]

GO

--Problem 12

SELECT [CountryName], [IsoCode]
	FROM [Countries]
	WHERE LOWER ([CountryName]) LIKE '%a%a%a%'
ORDER BY [IsoCode] 

--Problem 13

SELECT  [p].[PeakName], [r].[RiverName],
		LOWER(CONCAT(LEFT([p].[PeakName], LEN([p].[PeakName]) -1), [r].[RiverName]))
		AS [MIX]
	FROM [Rivers]  AS [r], 
			[Peaks] AS [p]

	WHERE RIGHT([p].[PeakName], 1) = LEFT ([r].[RiverName], 1)
ORDER BY [MIX]


GO

USE [Diablo]

GO

--Problem 14

SELECT TOP (50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start]
	FROM [Games]
	WHERE YEAR([Start]) BETWEEN 2011 AND 2012
	ORDER BY [Start], [Name]

--Problem 15

SELECT [UserName],	

	SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([EMAIL]))
	AS [Email Provider]
	FROM [USERS]
	ORDER BY [Email Provider],  [UserName]

--Problem 16
SELECT [UserName], [IpAddress]
	FROM [USERS]
	WHERE [IpAddress] LIKE '___.1%.%.___'
	ORDER BY [UserName]




--Problem 17

SELECT [Name],
		CASE	

			WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
			WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS [Part of the Day],

		CASE
			WHEN [Duration] <= 3 THEN 'Extra Short'
			WHEN [Duration] BETWEEn 4 AND 6 THEN 'Short'
			WHEN [Duration] > 6 THEN 'Long'
			ELSE 'Extra Long'

		END AS [Duration]
	FROM [GAMES] AS [g]
ORDER BY [g].[Name], [Duration]

--Problem 18

USE [Orders]

SELECT 
	[ProductName],
	[OrderDate],
	DATEADD(DAY,3, [OrderDate]) AS [Pay Due],
	DATEADD(MONTH, 1, [OrderDate]) AS [Deliver Due]
	FROM Orders


--Problem 19


CREATE TABLE People
	(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[Birthdate] DATETIME2 NOT NULL
	)

	INSERT INTO People
	VALUES
	('Victor', '2000-12-07'),
	('Steven','1992-09-10'),
	('Stephen','1910-09-19'),
	('John','2010-01-06')

	SELECT
	[Name],
		  DATEDIFF(year, [Birthdate], GETDATE()) AS [Age in Years],
		  DATEDIFF(month, [Birthdate], GETDATE()) AS [Age in Months],
		  DATEDIFF(day, [Birthdate], GETDATE()) AS [Age in Days],
		  DATEDIFF(minute, [Birthdate], GETDATE()) AS [Age in Minutes]
	FROM People