//[session.idempresa|Untyped,bandera|Integer,idimpuesto|Integer,session.db|Untyped,]
--SELECT
DECLARE  @IDEMPRESA  INT 
DECLARE  @BANDERA    INT 
DECLARE  @IDIMPUESTO INT

SET @IDEMPRESA=CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @BANDERA=CAST(ISNULL(:BANDERA,0) AS INT) 
SET @IDIMPUESTO=CAST(ISNULL(:IDIMPUESTO,0) AS INT)




IF(@BANDERA=0) 
SELECT IDIMPUESTO, IDEMPRESA, TASA AS TASA, TK, TKM, STATUS, IMPUESTO, INDICE
FROM <#SESSION.DB/>.DBO.EMPRESAS_IMPUESTOS 
WHERE IDEMPRESA=@IDEMPRESA 
ELSE 
SELECT SALESUP_CT.dbo.esCanalizado(TK, TKM) AS esCanalizado ,*
FROM <#SESSION.DB/>.DBO.EMPRESAS_IMPUESTOS 
WHERE IDEMPRESA=@IDEMPRESA AND IDIMPUESTO!=@IDIMPUESTO