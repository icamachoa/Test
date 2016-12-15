//[directorio|Text,mostrar|Integer,buscar|Text,orden1|Integer,orden2|Integer,ordenextra|Integer,pais|Text,estado|Text,bcp|Integer,session.idusuario|Untyped,session.idempresa|Untyped,session.db|Untyped,session.idgrupo|Untyped,session.nivel|Untyped,]
--SELECT
DECLARE @DIRECTORIO VARCHAR(MAX)
DECLARE @MOSTRAR INT
DECLARE @BUSCAR VARCHAR(MAX)
DECLARE @ORDEN1 INT
DECLARE @ORDEN2 INT
DECLARE @TOTALES INT
DECLARE @EMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @BASE VARCHAR(MAX)
DECLARE @IDGRUPO INT
DECLARE @NIVEL INT
DECLARE @PAIS VARCHAR(3)
DECLARE @ESTADO VARCHAR(3)
DECLARE @BCP INT
DECLARE @BCP_NOMBRE VARCHAR(MAX)
DECLARE @ORDENEXTRA INT

DECLARE @TOP VARCHAR(50)

SET @TOP= ''

SET @DIRECTORIO =  ISNULL(:DIRECTORIO,'')
SET @MOSTRAR = ISNULL(:MOSTRAR,0)
SET @BUSCAR = ISNULL(:BUSCAR,'')
SET @ORDEN1 = ISNULL(:ORDEN1,0)
SET @ORDEN2 = ISNULL(:ORDEN2,0)
SET @ORDENEXTRA = ISNULL(:ORDENEXTRA,0)
SET @PAIS = ISNULL(:PAIS,'')
SET @ESTADO = ISNULL(:ESTADO, '')
SET @BCP = ISNULL(:BCP,0)
SET @BCP_NOMBRE = 'directorio-'+CAST(<#SESSION.IDUSUARIO/> AS varchar(100))
SET @TOTALES = 1
SET @EMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @BASE = '<#SESSION.DB/>'
SET @IDGRUPO = <#SESSION.IDGRUPO/>
SET @NIVEL = <#SESSION.NIVEL/>


EXEC <#SESSION.DB/>.dbo.SP_LISTA_DIRECTORIO @DIRECTORIO, @MOSTRAR, @BUSCAR, @ORDEN1, @ORDEN2, @TOTALES, @EMPRESA, @IDUSUARIO, @BASE, @IDGRUPO, @NIVEL, @PAIS, @ESTADO, @BCP, @BCP_NOMBRE, @ORDENEXTRA, @TOP