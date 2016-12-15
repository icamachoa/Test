//[session.idusuario|Untyped,idreporte|Integer,idpantalla|Integer,session.db|Untyped,eliminarcriterios|Integer,]
-- DELETE
/*PROTEGIDO*/


DECLARE @IDUSUARIO INT
DECLARE @IDREPORTE INT 
DECLARE @IDPANTALLA INT 
DECLARE @ELIMINACRITERIOS INT

SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDREPORTE = ISNULL(:IDREPORTE, 0)
SET @IDPANTALLA = ISNULL(:IDPANTALLA, 0) 
SET @ELIMINACRITERIOS = ISNULL(:ELIMINARCRITERIOS, 0) 

IF(@ELIMINACRITERIOS = 1)
BEGIN
	 DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = @IDUSUARIO AND IDREPORTE = @IDREPORTE AND IDPANTALLA = @IDPANTALLA AND SQLTXT_EXP = 1
END
ELSE
BEGIN
	 DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = @IDUSUARIO AND IDREPORTE = @IDREPORTE AND IDPANTALLA = @IDPANTALLA
END 