//[idmoneda|Integer,session.idempresa|Untyped,session.idusuario|Untyped,periodo|Integer,anio|Integer,elagrupar|Integer,filtusuario|Integer,filtgrupo|Integer,session.db|Untyped,tkgrupo|Text,tku|Text,]
--SELECT

DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @TIPOREPORTE INT
DECLARE @TIPOAGRUPAMIENTO INT
DECLARE @IDUSUARIOLISTA INT
DECLARE @IDGRUPOLISTA INT
DECLARE @ANIO INT
DECLARE @IDMONEDA INT =ISNULL(:IDMONEDA,0)


SET @IDEMPRESA=CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO=CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @TIPOREPORTE=ISNULL(:PERIODO,0)
SET @ANIO=ISNULL(:ANIO,YEAR(GETDATE()))
SET @TIPOAGRUPAMIENTO=ISNULL(:ELAGRUPAR,0)
SET @IDUSUARIOLISTA=ISNULL(:FILTUSUARIO,0)
SET @IDGRUPOLISTA=ISNULL(:FILTGRUPO,0)





EXEC <#SESSION.DB/>.DBO.SP_REPORTE_CLIENTES_CONTINUIDAD_TOTAL @IDEMPRESA, @IDUSUARIO, @TIPOREPORTE, @ANIO, @TIPOAGRUPAMIENTO, @IDUSUARIOLISTA, @IDGRUPOLISTA,@IDMONEDA 