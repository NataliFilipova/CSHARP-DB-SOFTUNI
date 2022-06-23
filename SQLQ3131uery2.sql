USE [SoftUni] 
-- Problem 1
GO
	CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
	AS
	BEGIN
		SELECT [FirstName], 
				[LastName]
			FROM [Employees]
			WHERE [Salary] > 35000
	END

	GO

EXEC [dbo].[usp_GetEmployeesSalaryAbove35000]

GO
-- Problem 2

CREATE PROC [usp_GetEmployeesSalaryAboveNumber] @minSalary DECIMAL (18,4)
AS
BEGIN 
	SELECT [FirstName],
		[LastName]
	FROM [Employees]
	WHERE [Salary] >= @minSalary
END

EXEC [dbo].[usp_GetEmployeesSalaryAboveNumber] 48100

-- Problem 4

GO

CREATE PROC [usp_GetEmployeesFromTown] @townName VARCHAR(50)

AS
BEGIN
	SELECT [FirstName], [LastName]
		FROM [Employees]
		AS [e]
	LEFT JOIN [Addresses] AS [a]
	ON [e].[AddressID] = [a].[AddressID]
	LEFT JOIN [Towns] AS [t]
	ON [a].[TownID] = [t].[TownID]
	WHERE [t].[Name] = @townName
END

EXEC [dbo].[usp_GetEmployeesFromTown]  'Sofia'

-- Problem 5

CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL (18,4))
RETURNS VARCHAR(8)
AS 
BEGIN
	DECLARE @salaryLevel VARCHAR(8)

	IF @salary < 30000
	BEGIN
		SET @salaryLevel = 'Low'
	END
END