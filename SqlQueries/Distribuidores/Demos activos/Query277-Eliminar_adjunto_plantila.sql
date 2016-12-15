//[idpl|Integer,idpieza|Integer,archivo|Text,session.db|Untyped,]
--UPDATE
DECLARE @ANEXOS VARCHAR(MAX), @ARCHIVO VARCHAR(MAX)
DECLARE @IDPLANTILLA INT , @IDPIEZA INT
SET @IDPLANTILLA = CAST(ISNULL(:idpl,0) AS INT)
SET @IDPIEZA = CAST(ISNULL(:IDPIEZA,0) AS INT)

SET @ARCHIVO = '/'+ISNULL(:ARCHIVO,'')
SET @ANEXOS = ''
IF @IDPLANTILLA > 0
BEGIN
	 
	 SELECT @ANEXOS = REPLACE(CONVERT(VARCHAR(MAX),ANEXOS),@ARCHIVO,'') FROM <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS WHERE IDPLANTILLA = @IDPLANTILLA
	 
	 UPDATE <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS 
	 SET ANEXOS = @ANEXOS
	 WHERE IDPLANTILLA = @IDPLANTILLA
END

IF @IDPIEZA > 0
BEGIN
	 SELECT @ANEXOS = REPLACE(CONVERT(VARCHAR(MAX),ANEXOS),@ARCHIVO,'') FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS WHERE IDPIEZA = @IDPIEZA
	 
	 UPDATE <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS 
	 SET ANEXOS = @ANEXOS
	 WHERE IDPIEZA = @IDPIEZA
END