USE [SoftUni]

GO


--Problem 1
SELECT TOP (5) [EmployeeID], [JobTitle], [e].[AddressID], [a].[AddressText]
	FROM [Employees] AS [e]

	LEFT JOIN [Addresses] AS [a]
	ON [e].AddressID = [a].[AddressID]
ORDER BY [a].[AddressID]

--Problem 2

SELECT TOP(50) [e].[FirstName], [e].[LastName], [tw].[Name], [a].[AddressText] 
	FROM [Employees] AS [e]
	LEFT JOIN [Addresses] as [a]
	ON [e].[AddressID] = a.[AddressID]
	LEFT JOIN [Towns] AS [tw]
	ON [a].[TownID] = [tw].[TownID]

	ORDER BY [FirstName], [LastName]

--Problem 3


	SELECT [e].[EmployeeID], [e].[FirstName], [e].[LastName], [d].[Name]
		FROM [Employees] AS [e]
		LEFT JOIN [Departments] AS [d]
		ON [e].[DepartmentID] = [d].[DepartmentID]
		WHERE [d].[Name] = 'Sales'
		ORDER BY [e].[EmployeeID]


--PROBLEM 4
	SELECT TOP (5) [e].[EmployeeID], [e].[FirstName], [e].[Salary], [d].[Name] AS [DepartmentName]
		FROM [Employees] AS [e]
		LEFT JOIN [Departments] AS [d]
		ON [e].[DepartmentID] = [d].[DepartmentID]
		WHERE [e].[Salary] > 15000
		ORDER BY [e].[DepartmentID]

	

--Problem 5

	SELECT TOP (3)[e].[EmployeeID], [e].[FirstName]
	FROM [Employees] AS [e]
LEFT JOIN [EmployeesProjects] AS [ep]
	ON [e].[EmployeeID] = [ep].[EmployeeID]
	WHERE [ep].[ProjectID] IS NULL
	ORDER BY [e].[EmployeeID]

--Problem 6

	SELECT [e].[FirstName], [e].[LastName], [e].[HireDate], [d].[Name] AS [DeptName]
		FROM [Employees] AS [e]
		LEFT JOIN [Departments] AS [d]
		ON [e].[DepartmentID] = [d].[DepartmentID]
		WHERE [e].[HireDate] > '01.01.1999' AND [d].[Name] IN ('Sales', 'Finance')
		ORDER BY [e].[HireDate]



--Problem 7
	SELECT TOP (5)  [e].[EmployeeID], [e].[FirstName],

	[p].[Name] AS [ProjectName]
		FROM [Employees] AS [e]
	INNER JOIN [EmployeesProjects] AS [ep]
		ON e.[EmployeeID] = [ep].[EmployeeID]
	INNER JOIN [Projects] AS [p]
		ON [ep].[ProjectID] = [p].[ProjectID]
	WHERE [p].[StartDate] > ' 08/13/2002 ' AND [p].[EndDate] is NULL
ORDER BY [e].[EmployeeID] 

--Problem 8
GO 

USE [SoftUni]


	   select  [e].[EmployeeID], [FirstName],
	    case
		  when [pr].[StartDate] > '01.01.2005' then null
		  else [pr].[Name]
		end as [Projects]
	      from [Employees] as [e]
     left join [EmployeesProjects] as [p]
		    on [e].[EmployeeID] = [p].[EmployeeID]
     left join [Projects] as [pr]
		    on [p].ProjectID = [pr].[ProjectID]	
		 where [e].[EmployeeID] = 24
	  order by [e].[EmployeeID]



--Problem 9

SELECT [e].[EmployeeID], 
		[e].[FirstName],
	[m].[EmployeeID] AS [ManagerID],
	[m].[FirstName] AS  [ManagerName]
	FROM [Employees] AS [e]
	INNER JOIN [Employees] AS [m]
	ON [e].[ManagerID] = [m].[EmployeeID]
WHERE [m].[EmployeeID] IN (3,7)
ORDER BY [e].[EmployeeID]

--Problem 10
   USE [SoftUni]

   SELECT TOP (50) [e].[EmployeeID],
		[e].[FirstName] + ' ' + [e].[LastName]  AS [EmployeeName],
		[m].[FirstName] + ' ' + [m].[LastName] AS [ManagerName],
		[d].[Name] AS [DepartmentName]
		FROM [Employees] AS [e]
	INNER JOIN [Employees] AS [m]
		ON [e].[ManagerID] = [m].[EmployeeID]
	LEFT JOIN [Departments] AS [d]
		ON [e].[DepartmentID] = [d].[DepartmentID]
	ORDER BY [e].[EmployeeID]


--Prolem 11

	SELECT 
		MIN(avg)  AS [MinAverageSalary]
		FROM (
			SELECT avg(Salary) AS [avg]
				FROM [Employees]
			GROUP BY [DepartmentID]
		    )
				AS [AverageSalary]


GO
USE [Geography]

--Problem 12
	SELECT [mc].[CountryCode],
			[m].[MountainRange],
			[p].[PeakName],
			[p].[Elevation]
	 FROM [Peaks] AS [p]
INNER JOIN [Mountains]  AS [m]
	ON [p].[MountainId] = [m].[Id]
INNER JOIN [MountainsCountries] AS [mc]
	on [m].[Id] = [mc].[MountainId]
	WHERE [mc].[CountryCode] = 'BG' AND [p].[Elevation] > 2835
	ORDER BY [p].[Elevation] DESC


--Problem 13
SELECT [c].[CountryCode],
	COUNT([mc].[MountainId]) AS [MountainRanges]
	FROM [Countries] AS [c]
LEFT JOIN [MountainsCountries] AS [mc]
	ON [c].[CountryCode] = [mc].[CountryCode]
	WHERE [c].[CountryName] IN ('Bulgaria', 'Russia', 'United States')
	GROUP BY [c].[CountryCode]

--Problem 14
USE [Geography]

	SELECT TOP (5) [c].[CountryName], [r].[RiverName]
		FROM [Countries] AS [c]
		LEFT JOIN [CountriesRivers] AS [cr]
		ON [c].[CountryCode] = [cr].[CountryCode]
		LEFT JOIN [Rivers] AS [r]
		ON [cr].[RiverId] = [r].[Id]
		WHERE [c].[ContinentCode] = 'AF'
	ORDER BY [c].[CountryName]

	



--Problem 15
 SELECT [ContinentCode], [CurrencyCode], [Total] AS [CurrencyUsage] FROM (
  SELECT [ContinentCode], [CurrencyCode], COUNT([CurrencyCode]) AS [Total],
         DENSE_RANK() OVER(PARTITION BY [ContinentCode] ORDER BY COUNT([CurrencyCode]) DESC) AS [Ranked]
    FROM [Countries]
GROUP BY [ContinentCode], [CurrencyCode]) AS K
   WHERE [Ranked] = 1 AND [Total] > 1
ORDER BY [ContinentCode]

--Problem 16

SELECT	
	COUNT([c].[CountryCode])
		FROM [Countries] AS [c]
	LEFT JOIN [MountainsCountries] AS [mc]
		ON [c].[CountryCode] = [mc].[CountryCode]
		WHERE [mc].[MountainId] IS NULL



--Problem 17
SELECT TOP (5) [c].[CountryName], 
				 MAX([p].[Elevation]) AS [HighestPeakElevation],
			     MAX([r].[Length]) AS [LongestRiverLength]
		FROM [Countries] AS [c]
		LEFT JOIN [CountriesRivers] AS [cr]
	ON [c].[CountryCode] = [cr].[CountryCode]
	LEFT JOIN [Rivers] AS [r]
		ON [cr].[RiverId] = [r].[Id]
	LEFT JOIN [MountainsCountries] AS [mc]
		 ON [c].[CountryCode] = [mc].[CountryCode]
	 LEFT JOIN [Mountains] AS [m]
		 ON [mc].[MountainId] = [m].[Id]
	 LEFT JOIN [Peaks] AS [p]
		ON [p].[MountainId] = [m].[Id]
	GROUP BY [c].[CountryName]
	ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, [CountryName]

--Problem 18
SELECT TOP (5) [Country],
               CASE
                    WHEN [PeakName] IS NULL THEN '(no highest peak)'
                    ELSE [PeakName]
               END AS [Highest Peak Name],
               CASE
                    WHEN [Elevation] IS NULL THEN 0
                    ELSE [Elevation]
               END AS [Highest Peak Elevation],
               CASE
                    WHEN [MountainRange] IS NULL THEN '(no mountain)'
                    ELSE [MountainRange]
               END AS [Mountain]          
               FROM (
                       SELECT [c].[CountryName] AS [Country],
                              [m].[MountainRange],
                              [p].[PeakName],
                              [p].[Elevation],
                              DENSE_RANK() OVER(PARTITION BY [c].[CountryName] ORDER BY [p].[Elevation] DESC) 
                           AS [PeakRank]
                         FROM [Countries] AS [c]
                    LEFT JOIN [MountainsCountries] AS [mc]
                           ON [mc].[CountryCode] = [c].[CountryCode]
                    LEFT JOIN [Mountains] AS [m]
                           ON [mc].[MountainId] = [m].[Id]
                    LEFT JOIN [Peaks] AS [p]
                           ON [p].[MountainId] = [m].[Id]
                   ) AS [PeakRankingQuery]
        WHERE [PeakRank] = 1
     ORDER BY [Country], [Highest Peak Name]