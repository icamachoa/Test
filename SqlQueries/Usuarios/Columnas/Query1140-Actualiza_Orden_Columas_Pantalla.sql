//[session.idusuario|Untyped,idventana|Text,oc|Text,idcol|Text,session.db|Untyped,vistaActual|Integer,]
--UPDATE 
DECLARE @IDUSUARIO INT, @IDVENTANA INT, @vistaActual INT
DECLARE @OrdenColumnas VARCHAR(MAX), @IdsColumnas VARCHAR(MAX)

SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @IDVENTANA = CAST(:IDVENTANA AS INT)
SET @vistaActual = CAST(:vistaActual AS INT)

SET @OrdenColumnas = :OC
SET @IdsColumnas = :IDCOL

UPDATE <#SESSION.DB/>.dbo.USUARIOS_COLUMNAS SET ORDEN = NULL 
WHERE IDPANTALLA = @IDVENTANA AND IDUSUARIO = @IDUSUARIO AND VISIBLE = 0

UPDATE UC SET ORDEN = OC.SplitValue 
/* SELECT UC.IDUSUARIOCOLUMNA, IC.SplitValue AS IDS , OC.SplitValue AS ORDEN */
FROM <#SESSION.DB/>.dbo.USUARIOS_COLUMNAS UC, SALESUP_CT.dbo.Split(@OrdenColumnas,'|') OC, SALESUP_CT.dbo.Split(@IdsColumnas,'|') IC
WHERE UC.IDUSUARIOCOLUMNA = IC.SplitValue 
AND UC.IDUSUARIO = @IDUSUARIO AND UC.IDPANTALLA = @IDVENTANA
AND IC.OccurenceId = OC.OccurenceId

IF @IDVENTANA = 2 BEGIN EXEC <#SESSION.DB/>.dbo.SP_COMPILA_CONSULTA @IDUSUARIO, @IDVENTANA, @vistaActual, '' END