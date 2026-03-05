USE [Gabinet dentystyczny];
GO

SELECT * FROM Rezerwacja WHERE PeselKlienta = '90010111111';
SELECT COUNT(*) FROM Rezerwacja WHERE PeselKlienta = '90010111111';
GO

DELETE FROM Klient WHERE Pesel = '90010111111';
GO

SELECT * FROM Rezerwacja WHERE PeselKlienta = '90010111111';
SELECT COUNT(*) FROM Rezerwacja WHERE PeselKlienta = '90010111111';

GO
