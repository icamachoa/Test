//[session.idempresa|Untyped,session.idusuario|Untyped,session.convertcode|Untyped,idusuario|Integer,listap|Text,comentario|Text,reasignar_oportunidad|Text,session.db|Untyped,tko|Text,]
--update
/*PROTEGIDO*/
DECLARE @IDOPORTUNIDAD INT
DECLARE @IDPROSPECTO INT
DECLARE @IDUSUARIO INT
DECLARE @IDUSUARIO_ASIGNADO INT
DECLARE @DUENIO INT
DECLARE @SESSIONIDEMPRESA INT
DECLARE @SESSIONIDUSUARIO INT
DECLARE @IDUSUARIOV INT
DECLARE @SESSIONCONVERTCODE INT
DECLARE @LISTAP VARCHAR(MAX)
DECLARE @COMENTARIO VARCHAR(MAX)
DECLARE @REASIGNAR_OPORTUNIDAD VARCHAR(1000)

SET @SESSIONIDEMPRESA = <#SESSION.IDEMPRESA/>
SET @SESSIONIDUSUARIO = <#SESSION.IDUSUARIO/>
SET @SESSIONCONVERTCODE = <#SESSION.CONVERTCODE/>
SET @IDUSUARIOV = ISNULL(:IDUSUARIO,0)
SET @LISTAP = ISNULL(:LISTAP,'')
SET @COMENTARIO =  ISNULL(:COMENTARIO,'')
SET @REASIGNAR_OPORTUNIDAD = ISNULL(:REASIGNAR_OPORTUNIDAD,'')

DECLARE @TABLATEMP TABLE (ID INT IDENTITY, IDOPORTUNIDAD INT, IDPROSPECTO INT, DUENIO INT)
DECLARE @TO INT, @TOTAL INT



DECLARE @TKO VARCHAR(MAX)
SET @TKO = ISNULL(:TKO,'')
IF @TKO != '' 
BEGIN
   SET @LISTAP = ''
   SET @LISTAP = <#SESSION.DB/>.dbo.obtieneListaIdOportunidades(@TKO)
END



SET @TO = 1

INSERT INTO @TABLATEMP (IDOPORTUNIDAD,IDPROSPECTO,DUENIO)
SELECT  IDOPORTUNIDAD, IDPROSPECTO, IDUSUARIO  FROM <#SESSION.DB/>.dbo.OPORTUNIDADES WITH(NOLOCK) WHERE IDOPORTUNIDAD  IN (SELECT SPLITVALUE FROM <#SESSION.DB/>.dbo.SPLIT(@LISTAP,',') ) 
 AND IDPROSPECTO IN (SELECT IDPROSPECTO  FROM <#SESSION.DB/>.dbo.PROSPECTOS WHERE IDEMPRESA = @SESSIONIDEMPRESA)

SELECT @TOTAL = COUNT(*)  FROM @TABLATEMP

WHILE @TO <= @TOTAL
BEGIN
    SELECT @IDOPORTUNIDAD = IDOPORTUNIDAD,@IDPROSPECTO = IDPROSPECTO, @DUENIO = DUENIO FROM @TABLATEMP WHERE ID = @TO
	SELECT @IDUSUARIO_ASIGNADO=IDUSUARIO FROM <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS WITH(NOLOCK) WHERE IDPROSPECTO=@IDPROSPECTO AND IDUSUARIO = @IDUSUARIOV
	 SELECT @IDUSUARIO=IDUSUARIO FROM <#SESSION.DB/>.dbo.PROSPECTOS WHERE IDPROSPECTO=@IDPROSPECTO
	 IF (@REASIGNAR_OPORTUNIDAD!='')
	 BEGIN
	 	  IF (@IDUSUARIO_ASIGNADO IS NULL)
	  	  BEGIN
	   	  	   INSERT INTO <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS WITH(ROWLOCK) (IDUSUARIO,IDPROSPECTO,ARCHIVADO) VALUES (@IDUSUARIOV,@IDPROSPECTO,0)
			   
			   UPDATE <#SESSION.DB/>.DBO.PROSPECTOS SET ULTIMAMODIFICACION = GETDATE() WHERE IDPROSPECTO = @IDPROSPECTO
   			   UPDATE  <#SESSION.DB/>.DBO.prospectos_seguimiento SET ultimamodificacion=GETDATE() WHERE IDSEGUIMIENTO IN (SELECT TOP (10) IDSEGUIMIENTO FROM <#SESSION.DB/>.DBO.prospectos_seguimiento WHERE idprospecto=@IDPROSPECTO ORDER BY 1 DESC)
   	 		   
	 	 	   DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WHERE IDTABLA = 5 AND IDUSUARIO = @IDUSUARIOV
	 		   INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES (IDTABLA,IDUSUARIO,FECHAHORA) VALUES (5,@IDUSUARIOV,GETDATE())

	  	  END
	 END
	 ELSE
	 BEGIN
	 	   UPDATE <#SESSION.DB/>.dbo.PROSPECTOS WITH(ROWLOCK) SET IDUSUARIO=@IDUSUARIOv, ULTIMAMODIFICACION = GETDATE(), CAMBIOLOCAL=(CASE WHEN TKPM IS NOT NULL THEN 2 ELSE NULL END) WHERE IDPROSPECTO=@IDPROSPECTO
		 	  IF (@IDUSUARIO_ASIGNADO IS NULL)
	  	  	  BEGIN
	   	  	  	   INSERT INTO <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS WITH(ROWLOCK) (IDUSUARIO,IDPROSPECTO,ARCHIVADO) VALUES (@IDUSUARIOV,@IDPROSPECTO,0)
				   
				   UPDATE  <#SESSION.DB/>.DBO.prospectos_seguimiento SET ultimamodificacion=GETDATE() WHERE IDSEGUIMIENTO IN (SELECT TOP (10) IDSEGUIMIENTO FROM <#SESSION.DB/>.DBO.prospectos_seguimiento WHERE idprospecto=@IDPROSPECTO ORDER BY 1 DESC)
   	 
	 	 	   	   DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WHERE IDTABLA = 5 AND IDUSUARIO = @IDUSUARIOv
	 		   	   INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES (IDTABLA,IDUSUARIO,FECHAHORA) VALUES (5,@IDUSUARIOv,GETDATE())
	  	  	  END
			  IF ((SELECT COUNT(IDUSUARIO) FROM <#SESSION.DB/>.dbo.OPORTUNIDADES WITH(NOLOCK) WHERE IDPROSPECTO=@IDPROSPECTO AND IDUSUARIO=@IDUSUARIO AND IDOPORTUNIDAD!=@IDOPORTUNIDAD AND GANADA=0 AND PERDIDA=0) = 0)
			  BEGIN 
			  	   DELETE FROM <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS WITH(ROWLOCK) WHERE IDUSUARIO=@DUENIO AND IDPROSPECTO=@IDPROSPECTO
			  END
	 END
   EXEC <#SESSION.DB/>.dbo.SP_REASIGNAR_OPORTUNIDAD @IDOPORTUNIDAD,@IDUSUARIOv,@SESSIONIDUSUARIO, @COMENTARIO
   EXEC <#SESSION.DB/>.dbo.SP_INGRESA_SUCESOS_OPORTUNIDADES @SESSIONIDUSUARIO,14,@IDPROSPECTO,@IDOPORTUNIDAD,@SESSIONCONVERTCODE,'',''
   
   INSERT INTO  <#SESSION.DB/>.dbo.ELIMINACIONES WITH(ROWLOCK)  (IDTABLA,IDNUEVO,IDELIMINADO,TIPO,IDUSUARIO,FECHAHORA) VALUES (15,@IDUSUARIOv,@IDOPORTUNIDAD,1,@DUENIO,GETDATE())
   
   EXEC <#SESSION.DB/>.dbo.SP_ACTUALIZA_METAS 2,@IDUSUARIOv
   EXEC <#SESSION.DB/>.dbo.SP_ACTUALIZA_METAS 2,@SESSIONIDUSUARIO
   
   SET @IDUSUARIO_ASIGNADO = NULL
   SET @TO = @TO + 1
END
 
 DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WHERE IDEMPRESA = @SESSIONIDEMPRESA AND IDTABLA = 4
 INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES (IDEMPRESA, IDTABLA,FECHAHORA) VALUES(@SESSIONIDEMPRESA,4,GETDATE()) 