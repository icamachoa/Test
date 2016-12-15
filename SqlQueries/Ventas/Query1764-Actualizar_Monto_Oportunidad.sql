//[monto|Numeric,session.idempresa|Untyped,idoportunidad|Integer,session.db|Untyped,]
--UPDATE



DECLARE @MONTO AS MONEY
DECLARE @IDEMPRESA AS INT 
DECLARE @IDOPORTUNIDAD AS INT

SET @MONTO=CAST(ISNULL(:MONTO,0.0) AS MONEY)
SET @IDEMPRESA=CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDOPORTUNIDAD=CAST(ISNULL(:IDOPORTUNIDAD,0) AS INT)

IF(@MONTO IS NOT NULL AND @MONTO!='')
BEGIN 
UPDATE <#SESSION.DB/>.DBO.OPORTUNIDADES
SET MONTO=@MONTO
WHERE IDOPORTUNIDAD=@IDOPORTUNIDAD

END
