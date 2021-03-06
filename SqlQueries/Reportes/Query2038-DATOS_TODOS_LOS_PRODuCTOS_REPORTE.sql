//[lineafvp|Text,marcaxfvp|Text,filtrorapido|Integer,fecha_desde|Text,fecha_hasta|Text,session.convertcode|Untyped,session.idempresa|Untyped,moneda|Integer,ordena|Integer,lavariante|Text,session.idusuario|Untyped,session.db|Untyped,]
--SELECT
DECLARE @LINEA VARCHAR(MAX), @MARCA VARCHAR(MAX),@FECHADESDE VARCHAR(MAX), @FECHAHASTA VARCHAR(MAX), @IDEMPRESA INT, @PERIODO INT, @CONVERTCODE INT, @IDMONEDA INT, @ORDENARPOR INT
SET @LINEA = ISNULL(:LineaFVP,'')
SET @MARCA = ISNULL(:MarcaxFVP,'')
SET @PERIODO = ISNULL(:FiltroRapido,-1)
SET @FECHADESDE = ISNULL(:fecha_desde,'') 
SET @FECHAHASTA = ISNULL(:fecha_hasta,'')
SET @CONVERTCODE = ISNULL(<#SESSION.CONVERTCODE/>,100)
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDMONEDA = :MONEDA
SET @ORDENARPOR = ISNULL(:ORDENA,1)

DECLARE @TIPO_VARIANTE INT
DECLARE @VARIANTE VARCHAR(MAX)
DECLARE @IDUSUARIO INT
SET @TIPO_VARIANTE = 1
SET @VARIANTE = ISNULL(:LAVARIANTE,'33645AA5-D32D-4D12-A318-13E8843BDCC8')
SET @IDUSUARIO = ISNULL(<#SESSION.IDUSUARIO/>,0)


EXEC <#SESSION.DB/>.DBO.SP_REPORTE_PRODUCTOS_VENTAS 0,0, @LINEA, @MARCA, @FECHADESDE, @FECHAHASTA, @IDEMPRESA,0, @PERIODO, @CONVERTCODE, @IDMONEDA, @ORDENARPOR, @VARIANTE, @TIPO_VARIANTE, @IDUSUARIO