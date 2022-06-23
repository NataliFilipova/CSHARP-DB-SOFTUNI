USE [Gringotts]

--Problem 1
SELECT COUNT([Id]) AS [Count]
	FROM [WizzardDeposits]

--Problem 2

SELECT MAX([MagicWandSize]) AS [LongestMagicWand]
	FROM [WizzardDeposits]

--Problem 3

SELECT [DepositGroup], 
	MAX([MagicWandSize]) AS [LongestMagicWand]
	FROM [WizzardDeposits]

GROUP BY [DepositGroup]

--Problem 4

SELECT TOP (2) [DepositGroup] 
	
	FROM [WizzardDeposits]
GROUP BY [DepositGroup]
ORDER BY AVG([MagicWandSize])

--Problem 5

SELECT  [DepositGroup],
		SUM([DepositAmount]) 
		AS [TotalSum]
	
	FROM [WizzardDeposits]
GROUP BY [DepositGroup]

--Problem 6
SELECT [DepositGroup], 
    SUM([DepositAmount]) AS [TotalSum]
	FROM [WizzardDeposits]
	WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]


--Problem 7

SELECT [DepositGroup], 
    SUM([DepositAmount]) AS [TotalSum]
	FROM [WizzardDeposits]
	WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]
	HAVING SUM([DepositAmount]) <150000
	ORDER BY [TotalSum] DESC

USE [Gringotts]

-- Problem 8 

SELECT [DepositGroup], [MagicWandCreator],
	MIN([DepositCharge]) AS [MinDepositCharge]
	FROM [WizzardDeposits]
	GROUP BY [DepositGroup], [MagicWandCreator]
	ORDER BY [MagicWandCreator] ,[DepositGroup]



--Problem 9

SELECT [AgeGroup],  COUNT(*) AS [WizardCount]
	FROM(
	SELECT [Age],
			CASE
				WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
				WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
				WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
				WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
				WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
				WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
				WHEN [Age] >= 61 THEN '[61+]'

			END
			AS  [AgeGroup]
		FROM [WizzardDeposits]
 ) AS [AgeGroupingSubQuery]
	GROUP BY [AgeGroup]

	GO
-- Problem 10

SELECT DISTINCT LEFT ([FirstName],1) AS [FirstLetter]
	FROM [WizzardDeposits]
	WHERE [DepositGroup] = 'Troll Chest'
	GROUP BY[FirstName]
	ORDER BY[FirstLetter]


--Problem 11
	GO

SELECT [DepositGroup],
		[IsDepositExpired],
		AVG([DepositInterest])
	FROM [WizzardDeposits]
	WHERE DepositStartDate > '01/01/1985'
	GROUP BY [DepositGroup], [IsDepositExpired]

ORDER BY [DepositGroup] DESC, [IsDepositExpired]


-- Problem 12
--JOIN Solution

SELECT SUM(wz1.DepositAmount - wz2.DepositAmount) AS SumDifference
FROM WizzardDeposits AS wz1
JOIN WizzardDeposits AS wz2 ON wz1.Id + 1 = wz2.Id

GO

USE [SoftUni]

GO


-- Problem 13

SELECT [DepartmentID], SUM([Salary]) AS [TotalSalary]
	FROM [Employees]
	GROUP BY [DepartmentID]
	ORDER BY [DepartmentID]



-- Problem 14
      select [DepartmentID], min([Salary]) as [MinimumSalary]
        from [Employees] 
	   where [DepartmentID] in (2,5,7) and [HireDate] > '01.01.2000'
    group by [DepartmentID]

	

-- Problem 15

SELECT * 
	INTO [EmployeesNew] 
	FROM [Employees]
WHERE [Salary] > 30000

DELETE 
	FROM [EmployeesNew]
	WHERE [ManagerID] = 42

UPDATE [EmployeesNew]
	SET [Salary] += 5000
	WHERE [DepartmentID] = 1;

SELECT [DepartmentID] , AVG([Salary]) AS [AverageSalary]
	FROM [EmployeesNew] 
	GROUP BY [DepartmentID] 


-- Problem 16

SELECT DepartmentID, MAX(Salary) AS MaxSalary
    FROM Employees
GROUP BY DepartmentID
  HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

-- Problem 17

SELECT COUNT([Salary]) 
	FROM [Employees]

	WHERE [ManagerID] IS NULL


-- Problem 18
SELECT DISTINCT [DepartmentID], [Salary]
FROM (
	SELECT [DepartmentID], [Salary],
	DENSE_RANK() OVER (PARTITION BY[DepartmentId] ORDER BY [Salary] DESC)
	AS [SalaryRank]
		FROM [Employees]
	) AS [SalaryRankingQuery]
	WHERE [SalaryRank] = 3

-- Problem 19


	SELECT TOP (10) [FirstName], 
					[LastName],
					[DepartmentID]

			FROM [Employees] AS [e]
			WHERE [e].[Salary] > (SELECT 	AVG([Salary]) AS [AverageSalary]
								FROM [Employees]
								AS [esub]
								WHERE [esub].[DepartmentID] = [e].[DepartmentID]
								GROUP BY [DepartmentID])
			ORDER BY [e].[DepartmentID]