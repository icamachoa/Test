//[sp_ipaddress|Untyped,]
--SELECT
DECLARE @HOST VARCHAR(215)
DECLARE @SERVER VARCHAR(100)
SET @SERVER=REPLACE(@@SERVERNAME,'-','.')
SET @HOST='<#sp_ipaddress/>'
--SELECT @SERVER,@HOST
IF (@SERVER=@HOST OR 1=1)
  EXEC DBO.SP_INBOX_OBTIENE_LISTA_CORREOS
ELSE
 SELECT 'PARAMETROS INCORRECTOS' AS Error