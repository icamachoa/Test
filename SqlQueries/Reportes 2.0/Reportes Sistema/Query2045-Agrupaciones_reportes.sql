//[tkrs|Text,]
DECLARE @TKRS VARCHAR(MAX), @AGRUPACIONES varchar(max) 

SET @TKRS = ISNULL(:TKRS, '')

SELECT @AGRUPACIONES = AGRUPACIONES 
FROM SALESUP_CT.DBO.REPORTES_SISTEMA 
WHERE TKRS = @TKRS

SELECT CAST(tkRsa AS VARCHAR(MAX)) AS tkRsa, Agrupacion, idAgrupacion
FROM SALESUP_CT.DBO.REPORTES_SISTEMA_AGRUPACIONES
WHERE IDAGRUPACION IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@AGRUPACIONES,','))