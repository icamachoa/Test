//[idusuariocorreo|Integer,session.idusuario|Untyped,session.db|Untyped,]
-- DELETE 
/*PROTEGIDO*/
DECLARE @IDUSUARIOCORREO INT = :IDUSUARIOCORREO
DECLARE @IDUSUARIOCORREOAUX INT
DECLARE @IDUSUARIO INT = <#SESSION.IDUSUARIO/>
DECLARE @TIPO_CUENTA INT
DECLARE @CUENTA_CONFIG INT
DECLARE @INBOX_HABILITADO INT

DECLARE @USUARIO VARCHAR(256)
DECLARE @SMTP_HOST VARCHAR(256) = NULL
DECLARE @SMTP_PORT VARCHAR(256) = NULL
DECLARE @SMTP_USERNAME VARCHAR(256) = NULL
DECLARE @SMTP_PASSWORD VARCHAR(256) = NULL
DECLARE @TIPO INT
DECLARE @USE_SSL INT
DECLARE @ESTADO INT 

DECLARE @INBOX_USA_SSL INT = 0
DECLARE @INBOX_ESTADO INT
DECLARE @INBOX_TIPO INT
DECLARE @POP3_HOST VARCHAR(256) = NULL
DECLARE @POP3_PORT VARCHAR(256) = NULL
DECLARE @POP3_USERNAME VARCHAR(256) = NULL
DECLARE @POP3_PASSWORD VARCHAR(256) = NULL
DECLARE @GMAILTOKEN VARCHAR(1024) = NULL

SELECT @TIPO_CUENTA = TIPO_CUENTA FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIOCORREO = @IDUSUARIOCORREO

IF(@TIPO_CUENTA = 1 OR @TIPO_CUENTA = 2)
BEGIN
	SELECT @CUENTA_CONFIG = COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIO = @IDUSUARIO AND (TIPO_CUENTA = @TIPO_CUENTA OR TIPO_CUENTA = 3) AND IDUSUARIOCORREO <> @IDUSUARIOCORREO
END
ELSE
BEGIN
	SELECT @CUENTA_CONFIG = COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIO = @IDUSUARIO AND (TIPO_CUENTA = 3 OR TIPO_CUENTA = 1 OR TIPO_CUENTA = 2) AND IDUSUARIOCORREO <> @IDUSUARIOCORREO
END

	 IF(@TIPO_CUENTA = 1)
	 BEGIN
	 	  SELECT @INBOX_HABILITADO = INBOX_HABILITADO FROM <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG WHERE IDUSUARIO = @IDUSUARIO
		  
		  IF(@CUENTA_CONFIG > 0)
		  BEGIN
		  	   SELECT TOP 1 @IDUSUARIOCORREOAUX = IDUSUARIOCORREO, @USUARIO = EMAIL, @SMTP_HOST = SMTP_HOST, @SMTP_PORT = SMTP_PORT, @SMTP_USERNAME = SMTP_USERNAME, @SMTP_PASSWORD = SMTP_PASSWORD, @USE_SSL = USE_SSL, @TIPO = PROVEEDOR, @ESTADO = ESTADO FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO <> @IDUSUARIOCORREO AND (TIPO_CUENTA = 1 OR TIPO_CUENTA = 3) ORDER BY PREDETERMINADO DESC
			   UPDATE <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS SET PREDETERMINADO = 0 WHERE IDUSUARIO = @IDUSUARIO AND (TIPO_CUENTA = 1 OR TIPO_CUENTA = 3)
			   UPDATE <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS SET PREDETERMINADO = 1 WHERE IDUSUARIOCORREO = @IDUSUARIOCORREOAUX 
		  	   UPDATE <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG SET EMAIL = @USUARIO, SMTP_HOST = @SMTP_HOST, SMTP_PORT = @SMTP_PORT, SMTP_USERNAME = @SMTP_USERNAME, SMTP_PASSWORD = @SMTP_PASSWORD, USE_SSL = @USE_SSL, TIPO = @TIPO, ESTADO = @ESTADO WHERE IDUSUARIO = @IDUSUARIO 
		  END
		  ELSE
		  BEGIN
		  	  IF(@INBOX_HABILITADO = 0)
			  BEGIN
			  	   UPDATE <#SESSION.DB/>.DBO.USUARIOS SET MAILCONFIG = 0 WHERE  IDUSUARIO = @IDUSUARIO
			  	   DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG WHERE IDUSUARIO = @IDUSUARIO
			  END
			  ELSE
			  BEGIN
			  	   UPDATE <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG SET SMTP_HOST = NULL, SMTP_PORT=NULL, SMTP_USERNAME=NULL, SMTP_PASSWORD=NULL, USE_SSL=0 WHERE IDUSUARIO = @IDUSUARIO
			  END
		  END
		  
		  UPDATE <#SESSION.DB/>.DBO.USUARIOS_EMAILS SET IDUSUARIOCORREO = NULL WHERE IDUSUARIOCORREO = @IDUSUARIOCORREO
	 END
	 IF(@TIPO_CUENTA = 2)
	 BEGIN
	 	  SELECT @INBOX_HABILITADO = INBOX_HABILITADO FROM <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG WHERE IDUSUARIO = @IDUSUARIO
		  
		  IF(@CUENTA_CONFIG > 0)
		  BEGIN
		  	   SELECT TOP 1 @IDUSUARIOCORREOAUX = IDUSUARIOCORREO, @POP3_HOST = POP3_HOST, @POP3_PORT = POP3_PORT, @POP3_USERNAME = POP3_USERNAME, @POP3_PASSWORD = POP3_PASSWORD, @INBOX_USA_SSL = ISNULL(INBOX_USA_SSL,0), @INBOX_TIPO = PROVEEDOR, @INBOX_ESTADO = INBOX_ESTADO, @GMAILTOKEN = GMAILTOKEN FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO <> @IDUSUARIOCORREO AND (TIPO_CUENTA = 2 OR TIPO_CUENTA = 3) ORDER BY PREDETERMINADO DESC
		  	   UPDATE <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG SET POP3_HOST = @POP3_HOST, POP3_PORT = @POP3_PORT, POP3_USERNAME = @POP3_USERNAME, POP3_PASSWORD = @POP3_PASSWORD, INBOX_USA_SSL = @INBOX_USA_SSL, INBOX_TIPO = @INBOX_TIPO, INBOX_ESTADO = @INBOX_ESTADO, GMAILTOKEN = @GMAILTOKEN WHERE IDUSUARIO = @IDUSUARIO 
		  END
		  ELSE
		  BEGIN
		  	  IF(@INBOX_HABILITADO > 0)
			  BEGIN
			  	   UPDATE <#SESSION.DB/>.DBO.USUARIOS SET MAILCONFIG = 0 WHERE  IDUSUARIO = @IDUSUARIO
			  	   DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG WHERE IDUSUARIO = @IDUSUARIO
			  END
			  ELSE
			  BEGIN
			  	   UPDATE <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG SET POP3_HOST=NULL, POP3_PORT=NULL, POP3_USERNAME=NULL, POP3_PASSWORD=NULL, INBOX_USA_SSL=0, INBOX_HABILITADO = 0, GMAILTOKEN = NULL, INBOX_ULTIMORECIBIDO=NULL WHERE IDUSUARIO = @IDUSUARIO
			  END
			  
			  UPDATE <#SESSION.DB/>.DBO.USUARIOS_INBOX SET ACTIVO = 2 WHERE IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO = @IDUSUARIOCORREO AND ISNULL(IDSEGUIMIENTO, 0) = 0
		  END
	 END
	 IF(@TIPO_CUENTA = 3)
	 BEGIN
	 	  IF(@CUENTA_CONFIG > 0)
		  BEGIN
		  	   IF((SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE TIPO_CUENTA = 3 AND IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO <> @IDUSUARIOCORREO) = 0)
			   BEGIN
			   		SELECT TOP 1 @IDUSUARIOCORREOAUX = IDUSUARIOCORREO, @USUARIO = EMAIL, @SMTP_HOST = SMTP_HOST, @SMTP_PORT = SMTP_PORT, @SMTP_USERNAME = SMTP_USERNAME, @SMTP_PASSWORD = SMTP_PASSWORD, @USE_SSL = USE_SSL, @TIPO = PROVEEDOR, @ESTADO = ESTADO, @GMAILTOKEN = GMAILTOKEN FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO <> @IDUSUARIOCORREO AND TIPO_CUENTA = 1 ORDER BY PREDETERMINADO DESC
			   		UPDATE <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS SET PREDETERMINADO = 0 WHERE IDUSUARIO = @IDUSUARIO AND (TIPO_CUENTA = @TIPO_CUENTA OR TIPO_CUENTA = 1)
					UPDATE <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS SET PREDETERMINADO = 1 WHERE IDUSUARIOCORREO = @IDUSUARIOCORREOAUX
					
					SELECT TOP 1 @IDUSUARIOCORREOAUX = IDUSUARIOCORREO, @USUARIO = EMAIL, @POP3_HOST = POP3_HOST, @POP3_PORT = POP3_PORT, @POP3_USERNAME = POP3_USERNAME, @POP3_PASSWORD = POP3_PASSWORD, @INBOX_USA_SSL = ISNULL(INBOX_USA_SSL,0), @INBOX_TIPO = PROVEEDOR, @INBOX_ESTADO = INBOX_ESTADO, @GMAILTOKEN = GMAILTOKEN FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO <> @IDUSUARIOCORREO AND TIPO_CUENTA = 2 ORDER BY PREDETERMINADO DESC
			   		UPDATE <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS SET PREDETERMINADO = 0 WHERE IDUSUARIO = @IDUSUARIO AND (TIPO_CUENTA = @TIPO_CUENTA OR TIPO_CUENTA = 2)
					UPDATE <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS SET PREDETERMINADO = 1 WHERE IDUSUARIOCORREO = @IDUSUARIOCORREOAUX
			   END
			   ELSE
			   BEGIN
			   		SELECT TOP 1 @IDUSUARIOCORREOAUX = IDUSUARIOCORREO, @USUARIO = EMAIL, @SMTP_HOST = SMTP_HOST, @SMTP_PORT = SMTP_PORT, @SMTP_USERNAME = SMTP_USERNAME, @SMTP_PASSWORD = SMTP_PASSWORD, @USE_SSL = USE_SSL, @TIPO = PROVEEDOR, @ESTADO = ESTADO, @POP3_HOST = POP3_HOST, @POP3_PORT = POP3_PORT, @POP3_USERNAME = POP3_USERNAME, @POP3_PASSWORD = POP3_PASSWORD, @INBOX_USA_SSL = ISNULL(INBOX_USA_SSL,0), @INBOX_TIPO = PROVEEDOR, @INBOX_ESTADO = INBOX_ESTADO, @GMAILTOKEN = GMAILTOKEN FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO <> @IDUSUARIOCORREO AND TIPO_CUENTA = @TIPO_CUENTA ORDER BY PREDETERMINADO DESC
			   		UPDATE <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS SET PREDETERMINADO = 0 WHERE IDUSUARIO = @IDUSUARIO AND TIPO_CUENTA = @TIPO_CUENTA
					UPDATE <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS SET PREDETERMINADO = 1 WHERE IDUSUARIOCORREO = @IDUSUARIOCORREOAUX
			   END
		  	   
			   UPDATE <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG SET EMAIL = @USUARIO, SMTP_HOST = @SMTP_HOST, SMTP_PORT = @SMTP_PORT, SMTP_USERNAME = @SMTP_USERNAME, SMTP_PASSWORD = @SMTP_PASSWORD, USE_SSL = @USE_SSL, TIPO = @TIPO, ESTADO = @ESTADO,POP3_HOST = @POP3_HOST, POP3_PORT = @POP3_PORT, POP3_USERNAME = @POP3_USERNAME, POP3_PASSWORD = @POP3_PASSWORD, INBOX_USA_SSL = @INBOX_USA_SSL, INBOX_TIPO = @INBOX_TIPO, INBOX_ESTADO = @INBOX_ESTADO, GMAILTOKEN = @GMAILTOKEN WHERE IDUSUARIO = @IDUSUARIO 
		  END
		  ELSE
		  BEGIN
		  	   UPDATE <#SESSION.DB/>.DBO.USUARIOS SET MAILCONFIG = 0 WHERE  IDUSUARIO = @IDUSUARIO
			   DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG WHERE IDUSUARIO = @IDUSUARIO
		  END
		  
		  UPDATE <#SESSION.DB/>.DBO.USUARIOS_INBOX SET ACTIVO = 2 WHERE IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO = @IDUSUARIOCORREO  AND ISNULL(IDSEGUIMIENTO, 0) = 0
		  UPDATE <#SESSION.DB/>.DBO.USUARIOS_EMAILS SET IDUSUARIOCORREO = NULL WHERE IDUSUARIOCORREO = @IDUSUARIOCORREO
	 END

DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIOCORREO = @IDUSUARIOCORREO
	   