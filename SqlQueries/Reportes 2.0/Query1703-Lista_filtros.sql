//[idreporte|Integer,idscriterios|Text,session.db|Untyped,]
--SELECT

DECLARE @IDREPORTE INT
DECLARE @IDS VARCHAR(MAX)

SET @IDREPORTE = CAST(ISNULL(:IDREPORTE,0) AS INT)
SET @IDS = CAST(ISNULL(:IDSCRITERIOS,'') AS VARCHAR(MAX))

IF(@IDS = '')
BEGIN
	 SELECT RF.IDFILTRO,NOMBRE,F.TIPO FROM SALESUP_CT.DBO.REPORTES_FILTROS RF, SALESUP_CT.DBO.FILTROS F WHERE RF.IDFILTRO = F.IDFILTRO AND RF.IDREPORTE = @IDREPORTE
END
ELSE
BEGIN
	 SELECT RF.IDFILTRO,NOMBRE,F.TIPO FROM SALESUP_CT.DBO.REPORTES_FILTROS RF, SALESUP_CT.DBO.FILTROS F WHERE RF.IDFILTRO = F.IDFILTRO AND RF.IDREPORTE = @IDREPORTE AND RF.IDFILTRO IN(SELECT SPLITVALUE FROM <#SESSION.DB/>.DBO.SPLIT(@IDS,','))
END