//[idoportunidad|Integer,session.db|Untyped,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @IDOPORTUNIDAD INT
SET @IDOPORTUNIDAD = ISNULL(:IDOPORTUNIDAD,0)
SELECT IDFASE AS IDFASEOPORTUNIDAD FROM <#SESSION.DB/>.DBO.OPORTUNIDADES WHERE IDOPORTUNIDAD=@IDOPORTUNIDAD
