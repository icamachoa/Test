//[session.idempresa|Untyped,idcarpeta|Integer,iddocumento|Integer,session.db|Untyped,]
--DELETE
DECLARE @ARCHIVO VARCHAR(5000), @TIPOARCHIVO VARCHAR(12)
DECLARE @IDEMPRESA INT, @IDCARPETA INT, @IDDOCUMENTO INT, @CARPETAID INT
DECLARE @ID INT, @TOTAL INT
DECLARE @LISTADOCUMENTOS TABLE(ID INT IDENTITY, IDDOCUMENTO INT, DOCUMENTO VARCHAR(MAX), IDCARPETA INT, TIPO VARCHAR(12))

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDCARPETA = CAST(ISNULL(:IDCARPETA,0) AS INT)
SET @IDDOCUMENTO = CAST(ISNULL(:IDDOCUMENTO,0) AS INT)

IF @IDDOCUMENTO > 0
BEGIN
	SELECT @ARCHIVO = NOMBRE_DOCUMENTO, @CARPETAID = IDCARPETA, @TIPOARCHIVO = CASE TIPOARCHIVO WHEN 1 THEN 'IMG' WHEN 0 THEN 'DO' END 
	FROM <#SESSION.DB/>.DBO.EMPRESAS_DOCUMENTOS 
	WHERE IDDOCUMENTO = @IDDOCUMENTO AND IDEMPRESA = @IDEMPRESA
	 
	DELETE FROM <#SESSION.DB/>.DBO.EMPRESAS_ARCHIVOS_AMAZON WHERE ARCHIVO = @ARCHIVO AND IDEMPRESA = @IDEMPRESA AND TIPO = @TIPOARCHIVO
	DELETE FROM <#SESSION.DB/>.dbo.EMPRESAS_DOCUMENTOS WHERE IDDOCUMENTO = @IDDOCUMENTO AND IDEMPRESA = @IDEMPRESA
	
	IF @CARPETAID > 0
	BEGIN
		 UPDATE EC SET ARCHIVOS = ISNULL(ARCHIVOS,0) - 1
		 FROM <#SESSION.DB/>.dbo.EMPRESAS_CARPETAS EC WHERE IDCARPETA = @CARPETAID AND IDEMPRESA = @IDEMPRESA
	END	
END

IF @IDCARPETA > 0
BEGIN
	/*OBTIENE LOS ARCHIVOS QUE ESTAN DENTRO DE ESTA CARPETA*/
	INSERT INTO @LISTADOCUMENTOS(IDDOCUMENTO, DOCUMENTO, IDCARPETA, TIPO)
	SELECT IDDOCUMENTO, NOMBRE_DOCUMENTO,  IDCARPETA,  CASE TIPOARCHIVO WHEN 1 THEN 'IMG' WHEN 0 THEN 'DO' END 
	FROM <#SESSION.DB/>.DBO.EMPRESAS_DOCUMENTOS 
	WHERE IDEMPRESA = @IDEMPRESA 
	AND IDCARPETA IN ( SELECT IDCARPETA FROM <#SESSION.DB/>.DBO.EMPRESAS_CARPETAS WHERE IDEMPRESA = @IDEMPRESA AND (IDCARPETA = @IDCARPETA OR IDPADRE = @IDCARPETA) )
	
	SET @ID = 1
	SELECT @TOTAL = COUNT(*) FROM @LISTADOCUMENTOS
	WHILE @ID <= @TOTAL
	BEGIN
		SELECT @IDDOCUMENTO = IDDOCUMENTO, @ARCHIVO = DOCUMENTO, @TIPOARCHIVO = TIPO FROM @LISTADOCUMENTOS WHERE ID = @ID
		
		DELETE FROM <#SESSION.DB/>.DBO.EMPRESAS_ARCHIVOS_AMAZON WHERE ARCHIVO = @ARCHIVO AND IDEMPRESA = @IDEMPRESA AND TIPO = @TIPOARCHIVO
		DELETE FROM <#SESSION.DB/>.dbo.EMPRESAS_DOCUMENTOS WHERE IDDOCUMENTO = @IDDOCUMENTO AND IDEMPRESA = @IDEMPRESA
		
		SET @ID = @ID + 1
	END
	/*ELIMINAR EL REGISTRO DE LAS CARPETAS*/
	DELETE FROM <#SESSION.DB/>.DBO.EMPRESAS_CARPETAS WHERE IDEMPRESA = @IDEMPRESA AND (IDCARPETA = @IDCARPETA OR IDPADRE = @IDCARPETA)
END