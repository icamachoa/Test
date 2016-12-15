//[session.db|Untyped,nombre|Text,idusuario|Integer,etiquetas|Integer,esoportunidad|Integer,escliente|Integer,esprospecto|Integer,idautoresponder|Integer,tkauto|Text,session.idempresa|Untyped,]
--UPDATE

DECLARE @TKAUTO VARCHAR(128)
DECLARE @IDAUTORESPONDER INT

SET @IDAUTORESPONDER = ISNULL(:IDAUTORESPONDER, 0 )


SET @TKAUTO = ISNULL(:TKAUTO,'')
IF @TKAUTO != '' BEGIN SELECT @IDAUTORESPONDER=IDAUTORESPONDER FROM <#SESSION.DB/>.DBO.AUTORESPONDERS WHERE CAST(TKAUTO AS VARCHAR(128))  = @TKAUTO AND IDEMPRESA = <#SESSION.IDEMPRESA/> END


UPDATE <#SESSION.DB/>.DBO.AUTORESPONDERS 
SET 
TITULO = ISNULL(:NOMBRE,''),
IDUSUARIO = :IDUSUARIO,
IDETIQUETA = :ETIQUETAS,
ESOPORTUNIDAD = :ESOPORTUNIDAD,
ESCLIENTE = :ESCLIENTE,
ESPROSPECTO = :ESPROSPECTO
WHERE IDAUTORESPONDER = @IDAUTORESPONDER