//[idmeta|Integer,db|Text,]
--select
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @IDMETA INT
DECLARE @DB VARCHAR(1000)
DECLARE @SQL VARCHAR(MAX)
SET @IDMETA = ISNULL(:IDMETA,0)
SET @DB = ISNULL(:DB,'')

SET @SQL = 'SELECT AVANCE FROM '+@DB+'.DBO.USUARIOS_METAS WHERE IDMETA = '+CAST(@IDMETA AS VARCHAR(1000)) 
EXEC (@SQL)