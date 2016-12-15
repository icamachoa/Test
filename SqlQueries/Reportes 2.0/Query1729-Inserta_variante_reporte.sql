//[session.idusuario|Untyped,idreporte|Integer,compartir|Integer,configuracion|Text,nombre|Text,compartircon|Text,idusuarioreporte|Integer,session.db|Untyped,]
-- INSERT

DECLARE @IDUSUARIO INT, @IDREPORTE INT, @COMPARTIRCON INT, @IDUSUARIOREPORTE INT
DECLARE @FILTRO VARCHAR(MAX),@NOMBRE VARCHAR(128), @COMPARTIDOS VARCHAR(256)

SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDREPORTE = ISNULL(:IDREPORTE,0)
SET @COMPARTIRCON = ISNULL(:COMPARTIR,0)
SET @FILTRO = ISNULL(:CONFIGURACION,'')
SET @NOMBRE = ISNULL(:NOMBRE,'')
SET @COMPARTIDOS = ISNULL(:COMPARTIRCON,'')
SET @IDUSUARIOREPORTE = ISNULL(:IDUSUARIOREPORTE,0)

IF(@IDUSUARIOREPORTE = 0)
BEGIN
	 INSERT INTO <#SESSION.DB/>.DBO.USUARIOS_REPORTES (IDUSUARIO,IDREPORTE,FILTRO,NOMBRE,COMPARTIRCON,COMPARTIDOS) VALUES(@IDUSUARIO,@IDREPORTE,@FILTRO,@NOMBRE,@COMPARTIRCON,@COMPARTIDOS)
END
ELSE
BEGIN
	 UPDATE <#SESSION.DB/>.DBO.USUARIOS_REPORTES SET FILTRO = @FILTRO, NOMBRE = @NOMBRE, COMPARTIRCON = @COMPARTIRCON, COMPARTIDOS = @COMPARTIDOS WHERE IDUSUARIOREPORTE = @IDUSUARIOREPORTE AND IDREPORTE = @IDREPORTE
END