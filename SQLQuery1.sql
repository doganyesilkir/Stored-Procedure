USE master;
Go

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Tablo2')
BEGIN
    SELECT *
    INTO Tablo2
    FROM sys.database_principals
    WHERE 1 = 0; 
END

INSERT INTO Tablo2
SELECT *
FROM sys.database_principals;

SELECT * INTO fark FROM sys.database_principals WHERE 1 = 0;

INSERT INTO fark SELECT * FROM sys.database_principals EXCEPT SELECT * FROM Tablo2;

DECLARE @SatirSayisi INT;
SELECT @SatirSayisi = COUNT(*) FROM fark;

IF @SatirSayisi != 0
begin
	EXEC sp_configure 'show advanced options', 1;
	RECONFIGURE;
	EXEC sp_configure 'xp_cmdshell', 1;
	RECONFIGURE;

	DECLARE @cmd NVARCHAR(1000);
	SET @cmd = 'C:\Users\Pc\OneDrive\Masaüstü\Uyarı.exe'; 
	EXEC xp_cmdshell @cmd;

	EXEC sp_configure 'xp_cmdshell', 0;
	RECONFIGURE;
	EXEC sp_configure 'show advanced options', 0;
	RECONFIGURE;
	end