//[todos|Integer,session.db|Untyped,session.idusuario|Untyped,idpantalla|Integer,]
--INSERT
DECLARE @ACCION INT
DECLARE @IDPANTALLA INT
SET @IDPANTALLA= ISNULL(:IDPANTALLA,0)
SET @ACCION=CAST(ISNULL(:TODOS,0) AS INT)
IF @ACCION=2 
   DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=@IDPANTALLA and tipo = 20
ELSE 
 BEGIN
  IF @ACCION=3
	DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=@IDPANTALLA and tipo in (1,2,3,4,5,6,7)
  ELSE
    DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=@IDPANTALLA and tipo = 15  
 END
 
 
