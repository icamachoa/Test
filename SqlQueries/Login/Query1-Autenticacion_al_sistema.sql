//[email|Text,contrasenia|Text,sp_host|Untyped,]
--SELECT
/*al modiciar este qry MODIFICAR TAMBIEN  RELOGIN - 1823, BACK - 1020*/
DECLARE @CONTRASENIA VARCHAR(128)
DECLARE @EMAIL VARCHAR(128)
DECLARE @HOST VARCHAR(215)
SET @EMAIL = CAST(:EMAIL AS VARCHAR(128)) 
SET @CONTRASENIA = CAST(:CONTRASENIA AS VARCHAR(128)) 
SET @HOST='<#SP_HOST/>'

EXEC SP_LOGIN @EMAIL,@CONTRASENIA,@HOST