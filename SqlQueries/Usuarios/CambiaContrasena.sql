//[session.idempresa|Untyped,session.idusuario|Untyped,Contrasena1|Text]
--SELECT

DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @CONTRASENA VARCHAR(MAX)

SET @IDEMPRESA  = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO  = <#SESSION.IDUSUARIO/>
SET @CONTRASENA = :Contrasena1

EXEC <#SESSION.DB/>.DBO.SP_UPDATEPASSWORD @IDUSUARIO, @CONTRASENA