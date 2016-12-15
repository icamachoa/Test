//[idemail|Text,session.db|Untyped,session.convertcode|Untyped,]
--update
DECLARE @IDEMAIL INT, @IDUSUARIO INT, @IDPROSPECTO INT, @IDOPORTUNIDAD INT
DECLARE @ASUNTO VARCHAR(MAX), @COMENTARIO VARCHAR(MAX),@P VARCHAR(MAX)
DECLARE @FECHAHOY DATETIME

SET @IDEMAIL = CAST(:IDEMAIL AS INT )
SET @ASUNTO = ''
SET @COMENTARIO = ''
SET @P = ''
SET @FECHAHOY = GETDATE()

SELECT @IDUSUARIO = IDUSUARIO, @IDPROSPECTO = IDPROSPECTO, @IDOPORTUNIDAD = IDOPORTUNIDAD, @ASUNTO = ASUNTO 
FROM <#SESSION.DB/>.DBO.USUARIOS_EMAILS UE 
WHERE UE.IDEMAIL = @IDEMAIL

SET @COMENTARIO = 'Correo enviado - ' + @ASUNTO
SET @P = CAST(@IDPROSPECTO AS VARCHAR(MAX))
IF (@IDPROSPECTO IS NOT NULL)
BEGIN
  UPDATE <#SESSION.DB/>.DBO.USUARIOS_EMAILS WITH(ROWLOCK) 
  SET ESTADO = 0, FECHAPROGRAMADA = NULL 
  WHERE IDEMAIL = @IDEMAIL

  UPDATE <#SESSION.DB/>.DBO.USUARIOS WITH(ROWLOCK) 
  SET CORREOSENVIADOS = ISNULL(CORREOSENVIADOS,0)+1 
  WHERE IDUSUARIO = @IDUSUARIO

  INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO WITH(ROWLOCK) 
      (IDPROSPECTO, IDOPORTUNIDAD, IDUSUARIO, IDEMAIL, TIPO_SEGUIMIENTO, COMENTARIO, SISTEMA)
  VALUES(@IDPROSPECTO, @IDOPORTUNIDAD, @IDUSUARIO, @IDEMAIL, 1, @COMENTARIO , 1)
	
  EXEC <#SESSION.DB/>.DBO.SP_UPDATE_PROSPECTOS_ASIGNADOS @P,@FECHAHOY,1
  EXEC <#SESSION.DB/>.DBO.SP_INGRESA_SUCESOS_PROSPECTOS @IDUSUARIO, 15, @IDPROSPECTO, <#SESSION.CONVERTCODE/>, '', ''
  EXEC <#SESSION.DB/>.DBO.SP_ACTUALIZA_METAS 1, @IDUSUARIO
END