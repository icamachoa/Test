//[idprospecto|Integer,idetiqueta|Integer,session.db|Untyped,tk|Text,session.idempresa|Untyped,tkp|Text,]
--DELETE
/*PROTEGIDO*/

DECLARE @IDPROSPECTO INT
DECLARE @IDETIQUETA INT
DECLARE @TK VARCHAR(128)
DECLARE @TKP VARCHAR(128)

SET @IDPROSPECTO= ISNULL(:IDPROSPECTO,0)
SET @IDETIQUETA=ISNULL(:IDETIQUETA,0)

SET @TK = ISNULL(:TK,'')
IF @TK != '' BEGIN SELECT @IDETIQUETA=IDETIQUETA FROM <#SESSION.DB/>.DBO.ETIQUETAS WHERE TK = @TK AND IDEMPRESA = <#SESSION.IDEMPRESA/> END

SET @TKP = ISNULL(:TKP,'')
IF @TKP != '' BEGIN SELECT @IDPROSPECTO=IDPROSPECTO FROM <#SESSION.DB/>.DBO.PROSPECTOS WHERE CAST(TKP AS VARCHAR(128))  = @TKP AND IDEMPRESA = <#SESSION.IDEMPRESA/> END


DELETE FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_CONTROL WHERE IDPROSPECTO = @IDPROSPECTO AND IDETIQUETA = @IDETIQUETA
UPDATE <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS SET FECHAETIQUETADO = GETDATE() WHERE IDPROSPECTO = @IDPROSPECTO AND IDETIQUETA = @IDETIQUETA
