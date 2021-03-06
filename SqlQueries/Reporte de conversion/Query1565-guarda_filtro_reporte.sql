//[reporteconfig|Text,idreporte|Text,fechainicio|Text,fechafin|Text,anio|Text,session.db|Untyped,session.idusuario|Untyped,]
-- insert
DECLARE @SQL VARCHAR(MAX)

SET @SQL = '

DECLARE @IDREPORTE INT
DECLARE @JSONCONFIG VARCHAR(MAX)
DECLARE @REPORTECONFIG VARCHAR(512)

SET @REPORTECONFIG = ' + :REPORTECONFIG + '

IF(@REPORTECONFIG = ''null'')
BEGIN
SET @IDREPORTE = CAST(''' + :IDREPORTE + ''' AS INT)

DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDREPORTE = @IDREPORTE

INSERT INTO <#SESSION.DB/>.DBO.USUARIOS_FILTROS (IDUSUARIO,IDPANTALLA,TIPO,TEXTO,SQLTXT,IDREPORTE) VALUES(<#SESSION.IDUSUARIO/>,0,0,'''',@JSONCONFIG,@IDREPORTE)
END
ELSE
BEGIN
	 DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDREPORTE = @IDREPORTE
END	
' 

SELECT @SQL