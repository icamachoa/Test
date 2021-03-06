//[session.idempresa|Untyped,session.idusuario|Untyped,session.convertcode|Untyped,comentario|Text,idrecordatorio|Integer,idfase|Integer,idprospecto|Integer,tkp|Text,tkrec|Text,session.db|Untyped,]

-- INSERT
DECLARE @IDEMPRESA INT, @IDUSUARIO INT, @CONVERTCODE INT
DECLARE @IDRECORDATORIO INT, @IDFASE INT, @IDPROSPECTO INT, @IDOPORTUNIDAD INT
DECLARE @IDUSUARIODUENIO INT, @IDSEGUIMIENTO INT, @REASIGNADO INT, @OLD_FASE INT
DECLARE @ESCLIENTE INT, @HAYFASE INT
DECLARE @COMENTARIO VARCHAR(MAX), @FASETXT VARCHAR(MAX)
DECLARE @P VARCHAR(MAX)
DECLARE @FECHAHOY DATETIME

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @CONVERTCODE = CAST('<#SESSION.CONVERTCODE/>' AS INT)

SET @COMENTARIO = RTRIM(LTRIM(ISNULL(:COMENTARIO,'')))

SET @IDRECORDATORIO = ISNULL(:IDRECORDATORIO,0)
SET @IDFASE = ISNULL(:IDFASE, 0)
SET @IDPROSPECTO = ISNULL(:IDPROSPECTO,0)

SET @FASETXT = ''


DECLARE @TKP VARCHAR(64), @TKREC VARCHAR(64)
SET @TKP = ISNULL(:TKP,'') 
SET @TKREC = ISNULL(:TKREC,'')

IF @TKP != '' BEGIN SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) END
IF @TKREC != '' BEGIN SELECT @IDRECORDATORIO = IDRECORDATORIO FROM <#SESSION.DB/>.DBO.RECORDATORIOS WHERE TKREC = @TKREC END

SELECT @IDOPORTUNIDAD = R.IDOPORTUNIDAD 
FROM <#SESSION.DB/>.DBO.RECORDATORIOS R WITH(NOLOCK), <#SESSION.DB/>.DBO.OPORTUNIDADES O WITH(NOLOCK) 
WHERE R.IDRECORDATORIO = @IDRECORDATORIO AND O.IDOPORTUNIDAD = R.IDOPORTUNIDAD

IF (@IDPROSPECTO > 0) AND LEN(@COMENTARIO) > 0
BEGIN
	INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO WITH(ROWLOCK) (IDPROSPECTO, IDOPORTUNIDAD,IDUSUARIO, COMENTARIO)
	VALUES (@IDPROSPECTO, @IDOPORTUNIDAD, @IDUSUARIO, @COMENTARIO)
END  

EXEC <#SESSION.DB/>.DBO.SP_UPDATE_PROSPECTOS_ASIGNADOS @P,@FECHAHOY,1

SET @FECHAHOY = GETDATE()
SET @P = CAST(@IDPROSPECTO AS VARCHAR(MAX))
SELECT @REASIGNADO = REASIGNADO, @IDUSUARIODUENIO = IDUSUARIO, @OLD_FASE = IDFASE FROM <#SESSION.DB/>.DBO.PROSPECTOS WITH(NOLOCK) WHERE IDPROSPECTO = @IDPROSPECTO
SELECT TOP 1 @IDSEGUIMIENTO = IDSEGUIMIENTO FROM <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO WITH(NOLOCK) WHERE IDPROSPECTO = @IDPROSPECTO ORDER BY IDSEGUIMIENTO DESC
EXEC <#SESSION.DB/>.DBO.SP_INGRESA_SUCESOS_PROSPECTOS @IDUSUARIO, 7, @IDPROSPECTO, @CONVERTCODE, @COMENTARIO, @IDSEGUIMIENTO

IF @IDUSUARIO = @IDUSUARIODUENIO BEGIN SET @REASIGNADO = 0 END 

UPDATE <#SESSION.DB/>.DBO.PROSPECTOS WITH(ROWLOCK) 
SET REASIGNADO = @REASIGNADO  
WHERE IDPROSPECTO = @IDPROSPECTO

/* SE ACTIVAN LAS ACCIONES DE LAS FASES */

IF @IDOPORTUNIDAD = 0
BEGIN
	UPDATE <#SESSION.DB/>.DBO.PROSPECTOS WITH(ROWLOCK) 
	SET IDFASE = @IDFASE, REASIGNADO = @REASIGNADO, @ESCLIENTE = ESCLIENTE 
	WHERE IDPROSPECTO = @IDPROSPECTO
END
ELSE
BEGIN
	SELECT @HAYFASE = COUNT(*) FROM <#SESSION.DB/>.DBO.OPORTUNIDADES_FASES WITH(NOLOCK) WHERE IDFASE = @IDFASE AND IDEMPRESA = @IDEMPRESA
	
	IF @HAYFASE > 0
	BEGIN
		SELECT @OLD_FASE = IDFASE FROM <#SESSION.DB/>.DBO.OPORTUNIDADES WITH(NOLOCK) WHERE IDOPORTUNIDAD = @IDOPORTUNIDAD 
		UPDATE <#SESSION.DB/>.DBO.OPORTUNIDADES WITH(ROWLOCK) SET IDFASE = @IDFASE WHERE IDOPORTUNIDAD = @IDOPORTUNIDAD
	END
	ELSE
		UPDATE <#SESSION.DB/>.DBO.PROSPECTOS WITH(ROWLOCK) SET IDFASE = @IDFASE, REASIGNADO = @REASIGNADO WHERE IDPROSPECTO = @IDPROSPECTO        
END

SELECT @ESCLIENTE = ESCLIENTE FROM <#SESSION.DB/>.DBO.PROSPECTOS WHERE IDPROSPECTO = @IDPROSPECTO

IF @OLD_FASE <> @IDFASE
BEGIN
	EXEC <#SESSION.DB/>.DBO.SP_EJECUTA_ACCION @IDFASE,@IDPROSPECTO,@IDOPORTUNIDAD
	IF @IDOPORTUNIDAD = 0
	BEGIN
		SELECT @FASETXT = ' - '+ISNULL(FASE,'') FROM <#SESSION.DB/>.DBO.PROSPECTOS_FASES WHERE IDFASE = @IDFASE AND IDEMPRESA = @IDEMPRESA
		
		SELECT @ESCLIENTE = ESCLIENTE FROM <#SESSION.DB/>.DBO.PROSPECTOS WHERE IDPROSPECTO = @IDPROSPECTO

		IF @ESCLIENTE = 0 BEGIN
			EXEC <#SESSION.DB/>.DBO.SP_INGRESA_SUCESOS_PROSPECTOS @IDUSUARIO, 23, @IDPROSPECTO, @CONVERTCODE, @FASETXT, ''
		END
		ELSE BEGIN
			EXEC <#SESSION.DB/>.DBO.SP_INGRESA_SUCESOS_PROSPECTOS @IDUSUARIO, 22, @IDPROSPECTO, @CONVERTCODE, @FASETXT, ''
		END
	END
	ELSE	
	BEGIN         
		SELECT @FASETXT = ' - '+ISNULL(FASE,'') FROM <#SESSION.DB/>.DBO.OPORTUNIDADES_FASES WHERE IDFASE = @IDFASE AND IDEMPRESA = @IDEMPRESA
		IF @ESCLIENTE = 0 BEGIN
			EXEC <#SESSION.DB/>.DBO.SP_INGRESA_SUCESOS_PROSPECTOS @IDUSUARIO, 23, @IDPROSPECTO, @CONVERTCODE, @FASETXT, ''
		END
		ELSE BEGIN
			EXEC <#SESSION.DB/>.DBO.SP_INGRESA_SUCESOS_OPORTUNIDADES @IDUSUARIO, 21, @IDPROSPECTO, @IDOPORTUNIDAD, @CONVERTCODE, @FASETXT, ''
		END
	END
END


/* ACTUALIZA EL PROSPECTO Y LA OPORTUNIDAD */
IF @IDOPORTUNIDAD = 0
BEGIN
	UPDATE <#SESSION.DB/>.DBO.PROSPECTOS WITH(ROWLOCK) 
	SET FECHA_ULTIMOSEGUIMIENTO = GETDATE(),
	IDULTIMOSEGUIMIENTO = @IDSEGUIMIENTO
	WHERE IDPROSPECTO = @IDPROSPECTO
END
ELSE
BEGIN
	UPDATE <#SESSION.DB/>.DBO.OPORTUNIDADES WITH(ROWLOCK) 
	SET FECHA_ULTIMOSEGUIMIENTO = GETDATE(),
	IDULTIMOSEGUIMIENTO = @IDSEGUIMIENTO
	WHERE IDOPORTUNIDAD = @IDOPORTUNIDAD
END     


/* MARCA UN RECORDATORIO PREVIO COMO REALIZADO */
IF @IDRECORDATORIO>0
BEGIN
	DECLARE @IDO INT
	SELECT @IDO = IDOPORTUNIDAD FROM <#SESSION.DB/>.DBO.RECORDATORIOS WITH(NOLOCK) WHERE IDRECORDATORIO = @IDRECORDATORIO
	UPDATE <#SESSION.DB/>.DBO.RECORDATORIOS WITH(ROWLOCK) SET COMPLETADO = 1 WHERE IDRECORDATORIO = @IDRECORDATORIO
	EXEC <#SESSION.DB/>.DBO.SP_UPDATE_PROSPECTOS_ASIGNADOS @P,@FECHAHOY,1
	IF @IDO IS NOT NULL 
	BEGIN
		EXEC <#SESSION.DB/>.DBO.SP_PROXIMORECORDATORIO_OPORTUNIDAD @IDO
	END
END


