//[fecha_desde|Text,fecha_hasta|Text,session.db|Untyped,session.idusuario|Untyped,idpantalla|Integer,session.convertcode|Untyped,]
--INSERT
DECLARE @FECHA_DESDE VARCHAR(1000)
DECLARE @FECHA_HASTA VARCHAR(1000)
DECLARE @TEXTO VARCHAR(2024)
DECLARE @TEXTOSQL VARCHAR(2024)
DECLARE @IDPANTALLA INT
SET @FECHA_DESDE = ISNULL(:FECHA_DESDE,'')
SET @FECHA_HASTA = ISNULL(:FECHA_HASTA,'')
SET @IDPANTALLA = ISNULL(:IDPANTALLA,0)

  SELECT  @TEXTO = @FECHA_DESDE+' - '+@FECHA_HASTA
  SET @TEXTOSQL = @FECHA_DESDE+' - '+@FECHA_HASTA

INSERT INTO <#SESSION.DB/>.DBO.USUARIOS_FILTROS (IDUSUARIO, IDPANTALLA, TIPO, TEXTO, SQLTXT)
VALUES (<#SESSION.IDUSUARIO/>, @IDPANTALLA,0, @TEXTO,@TEXTOSQL)

update <#SESSION.DB/>.DBO.USUARIOS_DEFAULTS set DEFAULT_VENTAS_DESDE =CONVERT(DATETIME,@FECHA_DESDE,<#SESSION.CONVERTCODE/>), DEFAULT_VENTAS_HASTA =CONVERT(DATETIME,@FECHA_HASTA,<#SESSION.CONVERTCODE/>) WHERE  IDUSUARIO=<#SESSION.IDUSUARIO/>
