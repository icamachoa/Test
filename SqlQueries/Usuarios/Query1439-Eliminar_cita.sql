//[idu|Integer,idc|Integer,session.db|Untyped,]
--UPDATE
DECLARE @IDUSUARIO INT, @IDCITA INT, @AUNQUEDAN INT, @P VARCHAR(MAX),@FECHAHOY DATETIME

SET @FECHAHOY = GETDATE()
SET @IDUSUARIO = CAST(ISNULL(:IDU,0) AS INT)
SET @IDCITA = CAST(ISNULL(:IDC,0) AS INT)
SELECT @P = CAST(CI.IDPERSONA AS VARCHAR(MAX))
FROM <#SESSION.DB/>.dbo.CITAS_INVITADOS CI WHERE CI.IDCITA = @IDCITA AND CI.TIPOPERSONA = 1

SELECT @AUNQUEDAN = COUNT(*) FROM <#SESSION.DB/>.dbo.CITAS_INVITADOS CI WHERE CI.IDCITA = @IDCITA AND CI.TIPOPERSONA = 2

IF @AUNQUEDAN = 1
BEGIN
	 UPDATE <#SESSION.DB/>.dbo.CITAS SET ACTIVO = 0 WHERE IDCITA = @IDCITA
	 EXEC <#SESSION.DB/>.DBO.SP_UPDATE_PROSPECTOS_ASIGNADOS @P,@FECHAHOY,1
END
ELSE
BEGIN
	DELETE FROM <#SESSION.DB/>.dbo.CITAS_INVITADOS WHERE IDCITA = @IDCITA AND TIPOPERSONA = 2 AND IDPERSONA = @IDUSUARIO
	UPDATE <#SESSION.DB/>.dbo.CITAS SET ULTIMAMODIFICACION = GETDATE() WHERE IDCITA = @IDCITA
END