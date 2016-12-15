//[session.db|Untyped,session.idusuario|Untyped,idetiqueta|Integer,]
--INSERT
DECLARE @IDETIQUETA INT
SET @IDETIQUETA=ISNULL(:IDETIQUETA,0)
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO> AND IDPANTALLA=5

DECLARE @TEXTO VARCHAR (1024)
SET @TEXTO=''
SELECT @TEXTO=ETIQUETA FROM <#SESSION.DB/>.DBO.ETIQUETAS WHERE IDETIQUETA = @IDETIQUETA

INSERT INTO <#SESSION.DB/>.DBO.USUARIOS_FILTROS (IDUSUARIO, IDPANTALLA, TIPO, TEXTO, SQLTXT)
VALUES (<#SESSION.IDUSUARIO/>,5,20,@TEXTO,'P.IDPROSPECTO IN (SELECT IDPROSPECTO FROM <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS WHERE IDETIQUETA='+CAST(@IDETIQUETA AS VARCHAR(1000))+')')
