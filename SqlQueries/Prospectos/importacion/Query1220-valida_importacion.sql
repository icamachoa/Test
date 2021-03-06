//[borrar|Integer,session.idempresa|Untyped,session.idusuario|Untyped,validacionjson|Text,session.db|Untyped,]
--SELECT
DECLARE @BORRAR INT
DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @JSON VARCHAR(MAX)

SET @BORRAR = CAST(ISNULL(:BORRAR,0) AS INT)
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @JSON = DBO.PREPARACADENAAPP(:validacionjson)


IF(@JSON != '')
BEGIN
	 EXEC <#SESSION.DB/>.DBO.SP_REVISA_ERRORES_IMPORTACION @BORRAR,@IDUSUARIO,@IDEMPRESA,@JSON
END
ELSE
BEGIN
	 SELECT '' AS CAMPONOMBRE, '' AS NUMERRORES, '' AS TIPOVALIDACION
END 