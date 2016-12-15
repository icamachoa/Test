//[session.idusuario|Untyped,idusuariofiltro|Integer,enviacorreo|Integer,nombre|Text,correo|Text,diassemana|Text,hora|Text,session.db|Untyped,]
-- INSERT

DECLARE @IDUSUARIO INT, @IDUSUARIOFILTRO INT
DECLARE @IDREPORTE INT
DECLARE @ENVIARCORREO INT
DECLARE @FILTRO VARCHAR(MAX),@SQLTXT
DECLARE @NOMBRE VARCHAR(512)
DECLARE @CORREO VARCHAR(128)
DECLARE @DIA VARCHAR(10)
DECLARE @HORA VARCHAR(5)

SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDUSUARIOFILTRO = CAST(ISNULL(:idusuariofiltro,0) AS INT)
SET @ENVIARCORREO = CAST(ISNULL(:ENVIACORREO,0) AS INT)
SET @NOMBRE = ISNULL(:NOMBRE,'')
SET @CORREO = ISNULL(:CORREO,'')
SET @DIA = ISNULL(:DIASSEMANA,'')
SET @HORA = ISNULL(:HORA,'')

SELECT @SQLTXT = SQLTXT FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIOFILTRO = @IDUSUARIOFILTRO

IF(@SQLTXT != '' OR @SQLTXT IS NOT NULL)
BEGIN
	 SELECT @FILTRO = '['+SQLTXT+',{"tiporeporte":"'+SQLTXT_EXP+'"}]', @IDREPORTE = IDREPORTE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIOFILTRO = @IDUSUARIOFILTRO
END
ELSE
BEGIN
	 SELECT @FILTRO = '', @IDREPORTE = IDREPORTE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIOFILTRO = @IDUSUARIOFILTRO
END

INSERT INTO <#SESSION.DB/>.DBO.USUARIOS_REPORTES (IDUSUARIO,IDREPORTE,ENVIARCORREO,FILTRO,NOMBRE,CORREO,DIA,HORA) VALUES(@IDUSUARIO,@IDREPORTE,@ENVIARCORREO,@FILTRO,@NOMBRE,@CORREO,@DIA,@HORA)