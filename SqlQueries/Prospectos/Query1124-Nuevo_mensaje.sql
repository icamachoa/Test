//[para|Integer,session.idusuario|Untyped,mensaje|Text,prospectoseleccionado|Text,session.db|Untyped,]
--INSERT

DECLARE @MENSAJE VARCHAR(MAX), @PROSPECTOSELECCIONADO VARCHAR(MAX)
DECLARE @IDUSUARIO INT, @PARAIDUSUARIO INT

SET @PARAIDUSUARIO = CAST(ISNULL(:PARA,0) AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @MENSAJE = ISNULL(:MENSAJE,'')
SET @PROSPECTOSELECCIONADO = ISNULL(:ProspectoSeleccionado,'')


EXEC <#SESSION.DB/>.dbo.SP_ENVIA_MENSAJE @PARAIDUSUARIO, @IDUSUARIO, @PROSPECTOSELECCIONADO, @MENSAJE

