//[idprospecto|Integer,session.db|Untyped,session.idempresa|Untyped,tkp|Text,]
--select
DECLARE @IDPROSPECTO INT, @IDEMPRESA INT

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDPROSPECTO=ISNULL(:IDPROSPECTO,0)

DECLARE @TKP VARCHAR(MAX)
SET @TKP = ISNULL(:TKP,'')
IF @TKP != '' BEGIN SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) END

SELECT E.IDETIQUETA, REPLACE(REPLACE(E.ETIQUETA, '"', ''),',','') AS ETIQUETA 
FROM  <#SESSION.DB/>.dbo.ETIQUETAS E, <#SESSION.DB/>.dbo.PROSPECTOS_ETIQUETAS PE
WHERE E.IDEMPRESA = @IDEMPRESA AND E.IDETIQUETA= PE.IDETIQUETA 
AND PE.IDPROSPECTO = @IDPROSPECTO