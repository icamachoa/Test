//[name|Text,group|Integer,periodicidad|Integer,total|Integer,criterio|Text,filtroadicional|Text,compartirinput|Integer,compartidocon|Text,tkreportevariante|Text,session.idempresa|Untyped,session.idusuario|Untyped,session.db|Untyped,TKRS|Text,]
--select
DECLARE @NOMBRE VARCHAR(MAX)
DECLARE @AGRUPAR INT
DECLARE @PERIODO INT
DECLARE @TOTALIZAR INT
DECLARE @CRITERIOS VARCHAR(MAX)
DECLARE @FILTROADICIONALES VARCHAR(MAX)
DECLARE @COMPARTIRSELECT INT
DECLARE @COMPARTIDOCON VARCHAR(MAX)
DECLARE @tkReporte VARCHAR(MAX)
DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @REPORTEID INT
DECLARE @VARIANTEID INT
DECLARE @TKREPORTEVARIANTE VARCHAR(MAX)

SET @NOMBRE = <#SESSION.DB/>.DBO.PreparaCadena(ISNULL(:name, ''))
SET @AGRUPAR = ISNULL(:group, '')
SET @PERIODO = ISNULL(:periodicidad, '')
SET @TOTALIZAR = ISNULL(:total, '')
SET @CRITERIOS = ISNULL(:criterio, '')
SET @FILTROADICIONALES =  <#SESSION.DB/>.DBO.PreparaCadena(ISNULL(:filtroadicional, ''))
SET @COMPARTIRSELECT =  ISNULL(:compartirInput, '')
SET @COMPARTIDOCON =  ISNULL(:compartidocon, '')
SET @tkReporte =  ISNULL(:TKRS, '')
SET @TKREPORTEVARIANTE = ISNULL(:tkreportevariante,NULL)
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>

EXEC <#SESSION.DB/>.DBO.SP_GUARDA_VARIANTES_REPORTES @NOMBRE, @AGRUPAR, @PERIODO, @TOTALIZAR, @CRITERIOS, @FILTROADICIONALES, @COMPARTIRSELECT, @COMPARTIDOCON, @tkReporte, @IDEMPRESA, @IDUSUARIO, @TKREPORTEVARIANTE

