//[idpieza|Integer,carpeta|Text,archivo|Text,session.db|Untyped,archivoreal|Text,]
--insert
DECLARE @ANEXOS VARCHAR(800)
DECLARE @ANEXOSNUEVO VARCHAR(800)
DECLARE @ARCHIVONUEVO VARCHAR(800)
DECLARE @NOMBRE_REALNUEVO VARCHAR(800)
DECLARE @ARCHIVO VARCHAR(800)
DECLARE @NOMBRE_REAL VARCHAR(800)
DECLARE @IDPIEZA INT
DECLARE @RUTA VARCHAR(8000)
DECLARE @CARPETA VARCHAR(1000)
DECLARE @ARCHIVO VARCHAR(8000)
DECLARE @ARCHIVOREAL VARCHAR(8000)
SET @ARCHIVOREAL=ISNULL(:ARCHIVOREAL,'')
SET @ARCHIVO=ISNULL(:ARCHIVO,'')
SET @CARPETA=ISNULL(:CARPETA,'')
SET @IDPIEZA = ISNULL(:IDPIEZA,0)
SET @RUTA = 'Z:\archivos_externos\'+@CARPETA+'\'+@ARCHIVO--+CHAR(13)+CHAR(10)

SELECT @ANEXOS=ANEXOS , @ARCHIVO=NOMBRE_ARCHIVO , @NOMBRE_REAL = NOMBRE_ARCHIVO_REAL FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS WHERE IDPIEZA = @IDPIEZA

SET @ANEXOSNUEVO = ''
SET @ARCHIVONUEVO = ''
SET @NOMBRE_REALNUEVO = ''
SET @ANEXOS = REPLACE (@ANEXOS, @RUTA ,@ANEXOSNUEVO)
SET @ARCHIVO = REPLACE (@ARCHIVO, ltrim(rtrim(@ARCHIVO+',')),@ARCHIVONUEVO)
SET @NOMBRE_REAL = REPLACE (@NOMBRE_REAL, ltrim(rtrim(@ARCHIVOREAL+',')),@NOMBRE_REALNUEVO)


UPDATE 
<#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS 
SET 
ANEXOS = @ANEXOS, 
NOMBRE_ARCHIVO = @ARCHIVO, 
NOMBRE_ARCHIVO_REAL = @NOMBRE_REAL 
WHERE 
IDPIEZA = @IDPIEZA