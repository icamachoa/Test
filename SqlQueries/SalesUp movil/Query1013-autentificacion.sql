//[sp_host|Text,dispositivo|Text,devicetoken|Text,version|Text,usuario|Text,contrasenia|Text,]
--SELECT
DECLARE @EXECSQL VARCHAR(8000)
DECLARE @IDUSUARIO VARCHAR(12) 
DECLARE @BD VARCHAR(512)
DECLARE @DISPOSITIVO VARCHAR(512)
DECLARE @DEVICETOKEN VARCHAR(512)
DECLARE @VERSION VARCHAR(5)
DECLARE @SERVIDOR VARCHAR(100)
DECLARE @URL VARCHAR(100)
DECLARE @TIPO INT
SET @TIPO=1


 DECLARE @HOST VARCHAR(215)
 SET @HOST= ISNULL( :SP_HOST , '')
 SET @HOST=REPLACE(@HOST,'acceso','socrates')
 SET @HOST=SUBSTRING(@HOST,0,CHARINDEX('.salesup.com.mx',@HOST))
 
SET @DISPOSITIVO = ISNULL( :DISPOSITIVO  , '')
SET @DEVICETOKEN =ISNULL( :DEVICETOKEN , '')
SET @VERSION =ISNULL( :VERSION , '')
DECLARE @LINK VARCHAR(18)
SET @LINK  = ''

 SELECT @TIPO=COUNT(*) FROM CONTROL.CONTROL.DBO.BASES_CONTEO WHERE SERVIDOR=@HOST
 
 IF (@TIPO>0)
 BEGIN
 SELECT @IDUSUARIO = U.IDUSUARIO,@BD = Bd_ACTUAL,  
  @LINK  = CASE WHEN ((IPSERVER = REPLACE(@@SERVERNAME,'-','.') AND (SELECT COUNT(*) FROM (SELECT BC1.SERVIDOR FROM CONTROL.CONTROL.DBO.BASES_CONTEO BC1 WHERE BC1.IDSERVIDORDB=S.IDSERVIDORDB AND CHARINDEX(BC1.SERVIDOR,@HOST)>0 GROUP BY BC1.SERVIDOR)AS A)>0 ))  THEN '' ELSE LINK+'.'  END  
  FROM  CONTROL.CONTROL.DBO.SERVIDORESDB S, CONTROL.CONTROL.DBO.BASES_CONTEO B, 
 CONTROL.CONTROL.DBO.USUARIOS U, CONTROL.CONTROL.DBO.EMPRESAS E 
 WHERE EMAIL COLLATE DATABASE_DEFAULT = :USUARIO  AND 
 CONTRASENA = hashbytes('sha1', :CONTRASENIA) AND 
 U.IDEMPRESA=E.IDEMPRESA AND 
 E.BD_ACTUAL COLLATE DATABASE_DEFAULT = B.DATA_BASE COLLATE DATABASE_DEFAULT and 
 S.IDSERVIDORDB= B.IDSERVIDORDB 							
 END
 ELSE
 BEGIN
	SELECT @IDUSUARIO=IDUSUARIO, @BD=BD_ACTUAL  FROM SALESUP_CT.DBO.USUARIOS U, SALESUP_CT.DBO.EMPRESAS E WHERE EMAIL = :USUARIO AND CONTRASENA = hashbytes('sha1', :CONTRASENIA) AND U.IDEMPRESA=E.IDEMPRESA
 END


SELECT @SERVIDOR = CASE WHEN SERVIDOR = 'platon' then 'socrates' else servidor end  FROM CONTROL.CONTROL.DBO.BASES_CONTEO WITH(ROWLOCK) WHERE DATA_BASE = @BD
--SET @URL =  LOWER('https://'+@SERVIDOR+'.salesup.com.mx/webservices/appsync/')
SET @URL =  LOWER('http://dev.salesup.com.mx/webservices/appsync/')

IF (@IDUSUARIO IS NOT NULL)
BEGIN
	SET @EXECSQL = 'DECLARE @IDEMPRESA INT DECLARE @BORRAR_BASELOCAL INT SELECT @IDEMPRESA = U.IDEMPRESA FROM '+@LINK +@BD+'.dbo.USUARIOS U, '+@LINK +@BD+'.dbo.EMPRESAS E WITH(NOLOCK) WHERE U.IDUSUARIO = '+@IDUSUARIO+' AND U.IDEMPRESA = E.IDEMPRESA AND E.ACTIVA = 1 AND E.EXPIRACION > GETDATE() '
	SET @EXECSQL = @EXECSQL + ' IF (@IDEMPRESA IS NOT NULL) '
	SET @EXECSQL = @EXECSQL + ' BEGIN '
		SET @EXECSQL = @EXECSQL + ' DECLARE @TOKEN VARCHAR(512) SELECT TOP 1 @TOKEN = TOKEN FROM '+@LINK +@BD+'.dbo.USUARIOS_TOKENS WITH(NOLOCK) WHERE IDUSUARIO = '+@IDUSUARIO+' AND TOKEN_DEVICE = '''+@DEVICETOKEN+''' '
		SET @EXECSQL = @EXECSQL + ' IF(@TOKEN IS NULL) '
		SET @EXECSQL = @EXECSQL + ' BEGIN '
			SET @EXECSQL = @EXECSQL + 'INSERT INTO '+@LINK +@BD+'.dbo.USUARIOS_TOKENS WITH (ROWLOCK) (IDUSUARIO,TOKEN,FECHA_INICIO,FECHA_FIN,DURACION,DISPOSITIVO,TOKEN_DEVICE,VERSION) VALUES ('+@IDUSUARIO+',NEWID(),GETDATE(),GETDATE()+6,6,'''+@DISPOSITIVO+''','''+@DEVICETOKEN+''','+@VERSION+')'
		SET @EXECSQL = @EXECSQL + ' END '
		SET @EXECSQL = @EXECSQL + ' ELSE '
		SET @EXECSQL = @EXECSQL + ' BEGIN '
			SET @EXECSQL = @EXECSQL + 'UPDATE '+@LINK +@BD+'.dbo.USUARIOS_TOKENS WITH (ROWLOCK) SET FECHA_INICIO = GETDATE(), CONECTADO = 1, FECHA_FIN = GETDATE()+6,DISPOSITIVO='''+@DISPOSITIVO+''',VERSION = '+@VERSION+' WHERE IDUSUARIO = '+@IDUSUARIO+'  AND TOKEN = @TOKEN '
		SET @EXECSQL = @EXECSQL + ' END '
		SET @EXECSQL = @EXECSQL + ' SELECT TOP 1 @TOKEN = TOKEN, @BORRAR_BASELOCAL = BORRAR_BASELOCAL FROM '+@LINK + @BD+'.dbo.USUARIOS_TOKENS WITH (NOLOCK) WHERE IDUSUARIO = '+@IDUSUARIO+'  AND TOKEN_DEVICE = '''+@DEVICETOKEN+''' ORDER BY 1 DESC'
		SET @EXECSQL = @EXECSQL + ' SELECT UPPER(SUBSTRING(master.dbo.fn_varbintohexstr(CONTRASENA), 0, 64) ) AS CONTRASENIA, U.IDUSUARIO,U.IDEMPRESA,U.EMAIL,U.NOMBRE,U.APELLIDOS,U.INICIALES,U.NIVEL,U.ACTIVO,U.IDGRUPO,E.*, '''+@URL+''' AS URL, CONVERT(VARCHAR,E.EXPIRACION,20) AS EXPIRA, @BORRAR_BASELOCAL AS BORRARBASE, CONVERT(VARCHAR,E.FECHA_ALTA,20) AS ALTA,@TOKEN AS TOKEN, 1 AS RESPUESTA, '''+@BD+''' AS BASEDATOS, '''+@SERVIDOR+''' AS SERVIDOR FROM '+@LINK +@BD+'.dbo.USUARIOS U WITH (NOLOCK), '+@LINK +@BD+'.dbo.EMPRESAS E WITH (NOLOCK) WHERE U.IDEMPRESA = E.IDEMPRESA AND IDUSUARIO = '+@IDUSUARIO+' '
	SET @EXECSQL = @EXECSQL + 'END '
	SET @EXECSQL = @EXECSQL + 'ELSE '
	SET @EXECSQL = @EXECSQL + 'BEGIN '
		SET @EXECSQL = @EXECSQL + 'SELECT 0 AS RESPUESTA '
	SET @EXECSQL = @EXECSQL + 'END '
	EXEC(@EXECSQL)
END
ELSE
BEGIN
	 SELECT 0 AS RESPUESTA
END