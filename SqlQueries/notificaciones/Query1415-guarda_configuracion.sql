//[suceso|Integer,session.idusuario|Untyped,session.idempresa|Untyped,session.db|Untyped,not_email|Integer,not_sms|Integer,not_alerta|Integer,not_push|Integer,]
DECLARE @IDSUCESO INT
DECLARE @IDUSUARIO INT
DECLARE @IDEMPRESA INT
DECLARE @NOT_EMAIL INT
DECLARE @NOT_SMS INT
DECLARE @NOT_ALERTA INT
DECLARE @NOT_PUSH INT

SET @NOT_EMAIL=ISNULL(:NOT_EMAIL,0)
SET @NOT_SMS=ISNULL(:NOT_SMS,0)
SET @NOT_ALERTA=ISNULL(:NOT_ALERTA,0)
SET @NOT_PUSH=ISNULL(:NOT_PUSH,0)

SET  @IDSUCESO = ISNULL(:SUCESO,0)
SET  @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET  @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

IF (SELECT COUNT(*) FROM <#SESSION.DB/>.dbo.EMPRESAS_NOTIFICACION_CONFIG EC WHERE IDEMPRESA = @IDEMPRESA AND IDSUCESO = @IDSUCESO)=0
BEGIN
 INSERT INTO  <#SESSION.DB/>.dbo.EMPRESAS_NOTIFICACION_CONFIG (IDEMPRESA, idsuceso, IDNOTIFICACION, idtipodestinatario, ASUNTO, CUERPO, SMS,   NOTIFICA_EMAIL, NOTIFICA_SMS, NOTIFICA_ALERTA, notifica_push)
 SELECT  @IDEMPRESA, IDSUCESO,idnotificacion, idtipodestinatario, ASUNTO, CUERPO, SMS,   NOTIFICA_EMAIL, NOTIFICA_SMS, NOTIFICA_ALERTA, notifica_push FROM SALESUP_CT.DBO.NOTIFICACIONES WHERE IDSUCESO = @IDSUCESO
END

DECLARE @IDEMPRESANOTIFICACION INT
SET @IDEMPRESANOTIFICACION=0
SELECT @IDEMPRESANOTIFICACION = IDEMPRESANOTIFICACION FROM <#SESSION.DB/>.dbo.EMPRESAS_NOTIFICACION_CONFIG WHERE IDEMPRESA = @IDEMPRESA AND IDSUCESO = @IDSUCESO

IF (@IDEMPRESANOTIFICACION>0)
   BEGIN
     DELETE FROM <#SESSION.DB/>.dbo.USUARIOS_NOTIFICACION_CONFIG WHERE IDUSUARIO = @IDUSUARIO AND IDEMPRESANOTIFICACION = @IDEMPRESANOTIFICACION
     INSERT INTO <#SESSION.DB/>.dbo.USUARIOS_NOTIFICACION_CONFIG (IDUSUARIO, IDEMPRESANOTIFICACION, NOTIFICA_EMAIL, NOTIFICA_SMS, NOTIFICA_ALERTA, NOTIFICA_PUSH)
       VALUES (@IDUSUARIO, @IDEMPRESANOTIFICACION, @NOT_EMAIL, @NOT_SMS, @NOT_ALERTA, @NOT_PUSH) 
   END
 SELECT @IDEMPRESANOTIFICACION, @NOT_EMAIL AS NOT_EMAIL,@NOT_SMS AS NOT_SMS,@NOT_ALERTA AS NOT_ALERTA,@NOT_PUSH AS NOT_PUSH


