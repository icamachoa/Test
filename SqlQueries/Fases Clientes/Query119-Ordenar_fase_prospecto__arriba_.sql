//[session.db|Untyped,session.idempresa|Untyped,tk|Text,]
--update
DECLARE @ACTUAL INT
DECLARE @FASECLIENTE INT
DECLARE @TK VARCHAR(MAX) 
DECLARE @IDEMPRESA INT 

SET @TK=ISNULL(:TK, '') 
SET @IDEMPRESA=<#SESSION.IDEMPRESA/>


/* SELECCIONAR EL ORDEN ACTUAL */
SELECT @ACTUAL=ORDEN,@FASECLIENTE=FASECLIENTE FROM <#SESSION.DB/>.DBO.PROSPECTOS_FASES WHERE TK= @TK 

/* ACTUALIZAR ORDEN */
IF @ACTUAL < (SELECT MAX(ORDEN) FROM <#SESSION.DB/>.DBO.PROSPECTOS_FASES WHERE IDEMPRESA =  @IDEMPRESA  AND FASECLIENTE=@FASECLIENTE)
BEGIN
  UPDATE <#SESSION.DB/>.DBO.PROSPECTOS_FASES SET ORDEN=@ACTUAL WHERE IDEMPRESA =  @IDEMPRESA AND ORDEN = @ACTUAL+1 AND FASECLIENTE=@FASECLIENTE
  UPDATE <#SESSION.DB/>.DBO.PROSPECTOS_FASES SET ORDEN=@ACTUAL+1 WHERE TK = @TK
END