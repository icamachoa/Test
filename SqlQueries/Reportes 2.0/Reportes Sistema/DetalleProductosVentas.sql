//[session.idempresa|Untyped,session.db|Untyped,session.idusuario|Untyped,tipovariante|Integer,lavariante|Text,inicia|Integer,length|Integer,filtros|Text,agrupacion|Integer,parametros|Text]
--SELECT
DECLARE @IDUSUARIO INT, @IDEMPRESA INT, @VARIANTE VARCHAR(64), @TIPO_VARIANTE INT,@ACCION INT, @TOP VARCHAR(MAX), @FILTROS VARCHAR(MAX), @AGRUPACION INT, @PARAMETROS VARCHAR(MAX)

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = ISNULL(<#SESSION.IDUSUARIO/>,0)
DECLARE @INICIA INT
SET @INICIA = ISNULL(:inicia,0)
IF(@INICIA > 0)
BEGIN

	SET @TOP = 'TOP '+CAST(@INICIA+50-1 AS VARCHAR)+' '
END
ELSE
BEGIN
	SET @TOP = ''
END

SET @VARIANTE = ISNULL(:lavariante,'')
SET @TIPO_VARIANTE = ISNULL(:tipovariante,1)
SET @ACCION = 1
SET @FILTROS = ''
SET @AGRUPACION = ISNULL(:agrupacion,1)
SET @PARAMETROS = ISNULL(:parametros,'')

EXEC <#SESSION.DB/>.DBO.SPREPORTEDETALLE_PV @IDUSUARIO, @IDEMPRESA, @VARIANTE , @TIPO_VARIANTE, @ACCION, @TOP,@FILTROS,@AGRUPACION,@PARAMETROS