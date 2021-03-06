//[tipo|Text,servidor|Text,puerto|Text,ssl|Text,usuario|Text,clave|Text,session.tku|Untyped,session.db|Untyped,]
--select
DECLARE @TIPO VARCHAR(128)
DECLARE @SERVIDOR VARCHAR(128)
DECLARE @PUERTO VARCHAR(128)
DECLARE @SSL VARCHAR(128)
DECLARE @USUARIO VARCHAR(128)
DECLARE @CLAVE VARCHAR(128)

SELECT @TIPO = LTRIM(RTRIM(ISNULL(:TIPO,'1'))), @SERVIDOR = LTRIM(RTRIM(ISNULL(:SERVIDOR,'1'))), @PUERTO = LTRIM(RTRIM(ISNULL(:PUERTO,'1'))),
@SSL = LTRIM(RTRIM(ISNULL(:SSL,'1'))), @USUARIO = LTRIM(RTRIM(ISNULL(:USUARIO,'1'))), @CLAVE = LTRIM(RTRIM(ISNULL(:CLAVE,'1')))


--SELECT    '<#SESSION.TKU/>'+@TIPO+'_'+ @SERVIDOR+'_'+@PUERTO+ '_'+@SSL+'_'+ @USUARIO+'_'+ @CLAVE AS RESULTADO
EXEC <#SESSION.DB/>.dbo.SP_PRUEBA_INBOX '<#SESSION.TKU/>',@TIPO, @SERVIDOR,@PUERTO, @SSL, @USUARIO, @CLAVE
--SELECT '<#SESSION.TKU/>'+'_'+@TIPO+'_'+ @SERVIDOR+'_'+@PUERTO+'_'+@SSL+'_'+ @USUARIO+'_'+ @CLAVE AS RESULTADO
--SELECT 1 AS RESULTADO, @TIPO, @SERVIDOR,@PUERTO, @SSL, @USUARIO, @CLAVE