//[session.idempresa|Untyped,session.idusuario|Untyped,idarchivo|Integer,nombrefile|Text,paso|Integer,peso|Numeric,session.db|Untyped,]
--SELECT
DECLARE @IDUSUARIO INT, @IDEMPRESA INT, @IDARCHIVO INT, @PASO INT
DECLARE @NOMBREFILE VARCHAR(MAX)
DECLARE @PESO FLOAT

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @IDARCHIVO = CAST(ISNULL(:IDARCHIVO,0) AS INT) /*IDPROSPECTOARCHIVO ES EL QUE ESTA EN PROSPECTOS ARCHIVOS*/
SET @NOMBREFILE = ISNULL(:NOMBREFILE,'')
SET @PASO = CAST(ISNULL(:PASO,0) AS INT)
SET @PESO = CAST(ISNULL(:PESO,0) AS FLOAT)

	 /* REEMPLAZANDO ETIQUETAS DE LA PLANTILLA */
IF (@PASO=1) BEGIN EXEC <#SESSION.DB/>.dbo.SP_GENERA_ARCHIVO_XML_A_PDF_PASO1 @IDUSUARIO, @IDEMPRESA, @IDARCHIVO END
ELSE /* GENERANDO DOCUMENTO*/
IF (@PASO=2) BEGIN EXEC <#SESSION.DB/>.dbo.SP_GENERA_ARCHIVO_XML_A_PDF_PASO2 @IDUSUARIO, @IDEMPRESA, @NOMBREFILE END
ELSE /*GENERANDO PDF*/
IF (@PASO=3) BEGIN EXEC <#SESSION.DB/>.dbo.SP_GENERA_ARCHIVO_XML_A_PDF_PASO3 @IDUSUARIO, @IDEMPRESA, @NOMBREFILE END
ELSE /* PREPARANDO DISPONIBLE EL PDF*/
IF (@PASO=4) BEGIN EXEC <#SESSION.DB/>.dbo.SP_GENERA_ARCHIVO_XML_A_PDF_PASO4 @IDUSUARIO, @IDEMPRESA, @NOMBREFILE END
ELSE /* LISTO */
IF (@PASO=5) BEGIN EXEC <#SESSION.DB/>.dbo.SP_GENERA_ARCHIVO_XML_A_PDF_PASO5 @IDARCHIVO, @NOMBREFILE, @PESO END
ELSE
  SELECT '' AS NombreFile, 0 AS Result	
  