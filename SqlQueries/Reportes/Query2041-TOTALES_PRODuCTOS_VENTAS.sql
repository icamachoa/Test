//[lineafvp|Text,marcaxfvp|Text,filtrorapido|Integer,session.idempresa|Untyped,fecha_desde|Text,fecha_hasta|Text,session.convertcode|Untyped,moneda|Integer,ordena|Integer,tipovariante|Integer,lavariante|Text,session.idusuario|Untyped,session.db|Untyped,]
--SELECT	
DECLARE @LINEA VARCHAR(MAX), @MARCA VARCHAR(MAX),@FECHADESDE VARCHAR(MAX), @FECHAHASTA VARCHAR(MAX), @IDEMPRESA INT, @PERIODO INT, @CONVERTCODE INT, @IDMONEDA INT, @ORDENARPOR INT
SET @LINEA = ISNULL(:LineaFVP,'')
SET @MARCA = ISNULL(:MarcaxFVP,'')
SET @PERIODO = ISNULL(:FiltroRapido,-1)
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @FECHADESDE = ISNULL(:fecha_desde,'') 
SET @FECHAHASTA = ISNULL(:fecha_hasta,'')
SET @CONVERTCODE = ISNULL(<#SESSION.CONVERTCODE/>,100)
SET @IDMONEDA = :MONEDA
SET @ORDENARPOR = ISNULL(:ORDENA,1)

DECLARE @TIPO_VARIANTE INT
DECLARE @VARIANTE VARCHAR(MAX)
DECLARE @IDUSUARIO INT
SET @TIPO_VARIANTE = ISNULL(:tipoVariante,1)
SET @VARIANTE = ISNULL(:LAVARIANTE,NULL)
SET @IDUSUARIO = ISNULL(<#SESSION.IDUSUARIO/>,0)

--SELECT @FECHADESDE
EXEC <#SESSION.DB/>.DBO.SP_REPORTE_PRODUCTOS_VENTAS 0,1, @LINEA, @MARCA, @FECHADESDE, @FECHAHASTA, @IDEMPRESA,1, @PERIODO, @CONVERTCODE, @IDMONEDA, @ORDENARPOR, @VARIANTE, @TIPO_VARIANTE, @IDUSUARIO