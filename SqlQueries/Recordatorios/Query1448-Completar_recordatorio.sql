//[idr|Integer,ltr|Text,com|Text,session.idusuario|Untyped,session.idempresa|Untyped,tkrec|Text,session.db|Untyped,]
--update
DECLARE @IDRECORDATORIO INT, @IDOPORTUNIDAD INT, @IDPROSPECTO INT, @IDUSUARIO INT, @IDSEGUIMIENTO INT, @IDEMPRESA INT
DECLARE @LISTARECORDATORIOS VARCHAR(MAX), @COMENTARIO VARCHAR(MAX), @P VARCHAR(MAX)
DECLARE @FECHAHOY DATETIME

SET @IDRECORDATORIO = ISNULL(:IDR,0)
SET @LISTARECORDATORIOS = ISNULL(:LTR,'')
SET @COMENTARIO = ISNULL(:COM,'')

SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SET @P = ''
SET @FECHAHOY = GETDATE()

DECLARE @TKREC VARCHAR(64)
SET @TKREC = ISNULL(:TKREC,'')
IF @TKREC != '' BEGIN SELECT @IDRECORDATORIO = IDRECORDATORIO FROM <#SESSION.DB/>.DBO.RECORDATORIOS WHERE TKREC = @TKREC END

IF @IDRECORDATORIO > 0
BEGIN
	 UPDATE <#SESSION.DB/>.DBO.RECORDATORIOS WITH(ROWLOCK) SET COMPLETADO = 1 WHERE IDRECORDATORIO = @IDRECORDATORIO
	 IF LEN(@COMENTARIO) > 1
	 BEGIN
	 	  SELECT @IDPROSPECTO = R.IDPROSPECTO, @IDOPORTUNIDAD = R.IDOPORTUNIDAD FROM <#SESSION.DB/>.DBO.RECORDATORIOS R WITH(NOLOCK) WHERE R.IDRECORDATORIO = @IDRECORDATORIO
		  INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO WITH(ROWLOCK) (IDPROSPECTO, IDOPORTUNIDAD, IDUSUARIO, COMENTARIO)
		  VALUES (@IDPROSPECTO, @IDOPORTUNIDAD, @IDUSUARIO, @COMENTARIO)
		  
		  SELECT TOP 1 @IDSEGUIMIENTO = IDSEGUIMIENTO FROM <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO WITH(NOLOCK)
		  WHERE IDPROSPECTO = @IDPROSPECTO AND IDOPORTUNIDAD = @IDOPORTUNIDAD AND IDUSUARIO = @IDUSUARIO ORDER BY IDSEGUIMIENTO DESC
		  
		  IF @IDOPORTUNIDAD IS NOT NULL
		  BEGIN
			   EXEC <#SESSION.DB/>.DBO.SP_PROXIMORECORDATORIO_OPORTUNIDAD @IDOPORTUNIDAD
		  END
		  
		  DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WHERE IDEMPRESA = @IDEMPRESA AND IDTABLA = 4
		  INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES WITH(ROWLOCK) (IDEMPRESA, IDTABLA,FECHAHORA) VALUES(@IDEMPRESA, 4, GETDATE() )

	 END
END

IF LEN(@LISTARECORDATORIOS) > 0
BEGIN
	 SELECT @P = CAST(PR.IDPROSPECTO AS VARCHAR(MAX)) FROM (
	 		SELECT IDPROSPECTO FROM <#SESSION.DB/>.DBO.RECORDATORIOS 
	 		WHERE IDRECORDATORIO IN (SELECT SplitValue AS IDRECORDATORIO FROM <#SESSION.DB/>.dbo.Split(@LISTARECORDATORIOS,',')) AND COMPLETADO = 0 
	 )AS PR
	 UPDATE <#SESSION.DB/>.DBO.RECORDATORIOS WITH(ROWLOCK) SET COMPLETADO = 1 WHERE IDRECORDATORIO IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@LISTARECORDATORIOS,','))
	 EXEC <#SESSION.DB/>.DBO.SP_UPDATE_PROSPECTOS_ASIGNADOS @P,@FECHAHOY,1
END