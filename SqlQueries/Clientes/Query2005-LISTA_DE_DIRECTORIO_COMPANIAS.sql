//[inicia|Integer,howmany|Integer,directorio|Text,buscar|Text,orden1|Integer,orden2|Integer,ordenextra|Integer,pais|Text,estado|Text,session.idempresa|Untyped,session.idusuario|Untyped,session.db|Untyped,session.idgrupo|Untyped,session.nivel|Untyped,bcp|Integer,]
--SELECT
DECLARE @DIRECTORIO VARCHAR(MAX)
DECLARE @BUSQUEDA VARCHAR(MAX)
DECLARE @ORDEN1 INT
DECLARE @ORDEN2 INT
DECLARE @TOTALES INT
DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @BASE VARCHAR(MAX)
DECLARE @IDGRUPO INT
DECLARE @NIVEL INT
DECLARE @BCP INT
DECLARE @BCP_NOMBRE VARCHAR(MAX)
DECLARE @PAIS VARCHAR(5)
DECLARE @ESTADO VARCHAR(5)
DECLARE @ORDENEXTRA INT

DECLARE @TOP VARCHAR(50)
DECLARE @START INT SET @START = ISNULL(:INICIA,1)
DECLARE @HOWMANY INT SET @HOWMANY = ISNULL(:HOWMANY,50)
SET @TOP= 'TOP '+CAST(ISNULL(@START+@HOWMANY-1,50) AS VARCHAR(MAX))
SET @TOP = ''
SET @DIRECTORIO =  ISNULL(:DIRECTORIO,'')
SET @BUSQUEDA = ISNULL(:BUSCAR,'')
SET @ORDEN1 = ISNULL(:ORDEN1,0)
SET @ORDEN2 = ISNULL(:ORDEN2,0)
SET @ORDENEXTRA = ISNULL(:ORDENEXTRA,0)
SET @TOTALES = 0
SET @PAIS = ISNULL(:PAIS,'')
SET @ESTADO = ISNULL(:ESTADO, '')
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @BASE = '<#SESSION.DB/>'
SET @IDGRUPO = <#SESSION.IDGRUPO/>
SET @NIVEL = <#SESSION.NIVEL/>
SET @BCP = ISNULL(:BCP,0)
SET @BCP_NOMBRE = 'directorio_empresas-'+CAST(<#SESSION.IDUSUARIO/> AS varchar(100))

EXEC <#SESSION.DB/>.DBO.SP_LISTA_DIRECTORIO_COMPANIAS @ORDEN1 ,@ORDEN2 ,@TOTALES ,@IDEMPRESA ,@DIRECTORIO ,@BUSQUEDA ,@IDUSUARIO ,@BASE ,@IDGRUPO ,@NIVEL, @BCP, @BCP_NOMBRE,@PAIS, @ESTADO, @ORDENEXTRA, @TOP   