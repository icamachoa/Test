//[tkfi|Text,session.db|Untyped,]
--DELETE
/*PROTEGIDO*/
/*SEP2015*/

DECLARE @TKFI VARCHAR(64)
DECLARE @P VARCHAR(MAX)
DECLARE @FECHAHOY DATETIME

SET @FECHAHOY = GETDATE()
SET @TKFI = ISNULL(:TKFI,'')

SELECT @P = CAST(FI.IDPROSPECTO AS VARCHAR(MAX)) FROM (SELECT IDPROSPECTO FROM <#SESSION.DB/>.dbo.FECHAS_IMPORTANTES WHERE  TKFI = @TKFI) AS FI

DELETE FROM <#SESSION.DB/>.dbo.FECHAS_IMPORTANTES WHERE  TKFI = @TKFI

EXEC <#SESSION.DB/>.DBO.SP_UPDATE_PROSPECTOS_ASIGNADOS @P,@FECHAHOY,1