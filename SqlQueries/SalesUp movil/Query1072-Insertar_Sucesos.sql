//[bd|Text,fechahora|Text,idusuario|Text,tipo|Text,idprospecto|Text,idoportunidad|Text,idventa|Text,idseguimiento|Text,idcita|Text,idtarea|Text,usuarios_relacionados|Text,prospectos_relacionados|Text,texto|Text,]
--SELECT 

DECLARE @SQL VARCHAR(MAX)
DECLARE @BD VARCHAR(512)
SET @BD = ISNULL(:BD,'')

SET @SQL='
DECLARE @EXECSQL VARCHAR(MAX)
DECLARE @TEXTO VARCHAR(MAX)
DECLARE @FECHA DATETIME
DECLARE @IDPROSPECTO INT
DECLARE @IDOPORTUNIDAD INT 
DECLARE @IDVENTA INT
DECLARE @IDUSUARIO INT
DECLARE @TIPO INT
DECLARE @IDSEGUIMIENTO INT
DECLARE @IDCITA INT 
DECLARE @IDTAREA INT
DECLARE @USUARIOS_RELACIONADOS VARCHAR(MAX)
DECLARE @PROSPECTOS_RELACIONADOS VARCHAR(MAX)


SET @FECHA = CONVERT(DATETIME,'''+ISNULL(:FECHAHORA,'')+''',20)

SET @IDUSUARIO = CAST('''+ISNULL(:IDUSUARIO,'')+''' AS INT) 
SET @TIPO = CAST('''+ISNULL(:TIPO,'')+''' AS INT)

IF(('''+ISNULL(:IDPROSPECTO,'')+'''!=''null'')AND('''+ISNULL(:IDPROSPECTO,'')+'''!=''''))
BEGIN
	 SET @IDPROSPECTO = CAST('''+ISNULL(:IDPROSPECTO,'')+''' AS INT)
END
ELSE
BEGIN
	 SET @IDPROSPECTO = 0
END

IF(('''+ISNULL(:IDOPORTUNIDAD,'')+'''!=''null'')AND('''+ISNULL(:IDOPORTUNIDAD,'')+'''!=''''))
BEGIN
	 SET @IDOPORTUNIDAD = CAST('''+ISNULL(:IDOPORTUNIDAD,'')+''' AS INT)
END
ELSE
BEGIN
	 SET @IDOPORTUNIDAD = 0
END

IF('''+ISNULL(:IDVENTA,'')+'''!='''')
BEGIN
	SET @IDVENTA = CAST('''+ISNULL(:IDVENTA,'')+''' AS INT)
END
ELSE
BEGIN
	SET @IDVENTA = 0
END

IF('''+ISNULL(:IDSEGUIMIENTO,'')+'''!='''')
BEGIN
	SET @IDSEGUIMIENTO = CAST('''+ISNULL(:IDSEGUIMIENTO,'')+''' AS INT)
END
ELSE
BEGIN
	SET @IDSEGUIMIENTO = 0
END

IF(('''+ISNULL(:IDCITA,'')+'''!=''null'')AND('''+ISNULL(:IDCITA,'')+'''!=''''))
BEGIN
	 SET @IDCITA = CAST('''+ISNULL(:IDCITA,'')+''' AS INT)
END
ELSE
BEGIN
	 SET @IDCITA = 0
END

IF(('''+ISNULL(:IDTAREA,'')+'''!=''null'')AND('''+ISNULL(:IDTAREA,'')+'''!=''''))
BEGIN
	 SET @IDTAREA = CAST('''+ISNULL(:IDTAREA,'')+''' AS INT)
END
ELSE
BEGIN
	 SET @IDTAREA = 0
END

SET @TEXTO = '''+ISNULL(:TEXTO,'')+'''
SET @USUARIOS_RELACIONADOS = '''+ISNULL(:USUARIOS_RELACIONADOS,'')+'''
SET @PROSPECTOS_RELACIONADOS = '''+ISNULL(:PROSPECTOS_RELACIONADOS,'')+'''

EXEC '+@BD+'.DBO.SP_INSERTA_SUCESO_MV @TEXTO,@FECHA,@IDPROSPECTO,@IDOPORTUNIDAD,@IDUSUARIO,@TIPO,@IDVENTA,@IDSEGUIMIENTO,@IDCITA,@IDTAREA,@USUARIOS_RELACIONADOS,@PROSPECTOS_RELACIONADOS
'
EXEC (@SQL)