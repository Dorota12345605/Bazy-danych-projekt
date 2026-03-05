USE [Gabinet dentystyczny];
GO

SELECT * 
FROM Rezerwacja 
WHERE IdGabinetu = 1;
GO

UPDATE Rezerwacja
SET IdGabinetu = 5
WHERE IdGabinetu = 1;
GO

SELECT * 
FROM Rezerwacja 
WHERE IdGabinetu = 5;
GO
