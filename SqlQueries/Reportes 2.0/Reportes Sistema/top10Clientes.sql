//[session.idempresa|Untyped,session.db|Untyped,session.idusuario|Untyped,tipovariante|Integer,lavariante|Text,inicia|Integer,length|Integer]
--SELECT
DECLARE @IDUSUARIO INT, @IDEMPRESA INT, @VARIANTE VARCHAR(64), @TIPO_VARIANTE INT,@ACCION INT, @TOP VARCHAR(MAX)

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = ISNULL(<#SESSION.IDUSUARIO/>,0)
SET @TOP = ''
SET @VARIANTE = ISNULL(:lavariante,'FAE43FDA-DD34-478D-823C-29812C0FFA9A')
SET @TIPO_VARIANTE = ISNULL(:tipovariante,1)
SET @ACCION = 1

EXEC <#SESSION.DB/>.DBO.SP_REPORTE_TOP10CLIENTES @IDUSUARIO, @IDEMPRESA, @VARIANTE , @TIPO_VARIANTE, @ACCION, @TOP