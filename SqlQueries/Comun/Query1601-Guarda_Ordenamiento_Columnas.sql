//[session.idusuario|Untyped,session.idempresa|Untyped,idusuariocolumna|Integer,idventana|Integer,ordenapor|Integer,session.db|Untyped,vistaActual|Integer,]
-- UPDATE

DECLARE @IDUSUARIO INT, @IDUSUARIOCOLUMNA INT, @IDPANTALLA INT, @ORDENAMIENTO INT, @IDEMPRESA INT
DECLARE @TIPO INT, @ID INT, @INDICE INT, @ORDENAPOR INT, @ORDENAR INT
DECLARE @CAMPODB VARCHAR(MAX), @ORDERBY VARCHAR(MAX), @ORDENA VARCHAR(MAX)
DECLARE @TIPOCAMPO INT, @VERPROSPECTOS INT,  @VEREMPRESA INT, @VERVENTAS INT, @vistaActual INT

SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SET @IDUSUARIOCOLUMNA = ISNULL(:idusuariocolumna,0)
SET @IDPANTALLA = ISNULL(:IdVentana,0) 
SET @ORDENAMIENTO = ISNULL(:OrdenaPor,0)
SET @vistaActual = CAST(:vistaActual AS INT)
SET @ORDENAR = 1

SET @CAMPODB = '1'
SET @ORDERBY = ''
UPDATE <#SESSION.DB/>.DBO.USUARIOS_COLUMNAS SET ORDENAPOR = NULL, ORDERSQL = NULL WHERE IDUSUARIO = @IDUSUARIO AND IDPANTALLA = @IDPANTALLA
UPDATE <#SESSION.DB/>.DBO.USUARIOS_COLUMNAS SET ORDENAPOR = @ORDENAMIENTO  WHERE IDUSUARIOCOLUMNA = @IDUSUARIOCOLUMNA AND IDUSUARIO = @IDUSUARIO AND IDPANTALLA = @IDPANTALLA

SELECT @ORDERBY = <#SESSION.DB/>.dbo.ObtieneOrderBy( @IDUSUARIOCOLUMNA , @IDUSUARIO , @IDPANTALLA , @IDEMPRESA , @ORDENAR  )

UPDATE <#SESSION.DB/>.DBO.USUARIOS_COLUMNAS SET ORDERSQL = @ORDERBY  WHERE IDUSUARIOCOLUMNA = @IDUSUARIOCOLUMNA AND IDUSUARIO = @IDUSUARIO AND IDPANTALLA = @IDPANTALLA

IF @IDPANTALLA = 2 BEGIN EXEC <#SESSION.DB/>.dbo.SP_COMPILA_CONSULTA @IDUSUARIO, @IDPANTALLA, @vistaActual, '' END