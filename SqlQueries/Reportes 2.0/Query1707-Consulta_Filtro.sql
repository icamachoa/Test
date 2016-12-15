//[idreporte|Integer,tiporeporte|Integer,]
-- SELECT
DECLARE @IDREPORTE INT, @TIPOREPORTE INT
DECLARE @CONSULTA VARCHAR(MAX)

SET @IDREPORTE = CAST(ISNULL(:IDREPORTE,0) AS INT)
SET @TIPOREPORTE = CAST(ISNULL(:TIPOREPORTE,0) AS INT)
SELECT @CONSULTA = CAMPO FROM SALESUP_CT.DBO.REPORTES_VISTAS WHERE IDREPORTE = @IDREPORTE AND IDREPORTEVISTAS = @TIPOREPORTE
SELECT @CONSULTA AS CONSULTA