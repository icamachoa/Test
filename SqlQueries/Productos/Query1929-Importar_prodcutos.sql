//[session.idempresa|Untyped,infoimportacion|Text,session.db|Untyped,]
--INSERT
DECLARE @JSON VARCHAR(MAX)
DECLARE @IDEMPRESA INT
	
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @JSON = :infoImportacion

EXEC <#SESSION.DB/>.DBO.SP_INSERTA_IMPORTACION_PRODUCTOS @IDEMPRESA, @JSON 