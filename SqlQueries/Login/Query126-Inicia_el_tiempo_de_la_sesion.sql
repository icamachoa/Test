//[session.db|Untyped,session.sessionid|Untyped,session.idusuario|Untyped,sp_ipaddress|Untyped,sp_browser|Untyped,]
--update
DECLARE @CONT INT
SET @CONT=1
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_ACCESOS WITH(ROWLOCK) WHERE  SESSIONID like '<#SESSION.SESSIONID/>'
SELECT @CONT=COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_ACCESOS  WITH(NOLOCK)  WHERE  SESSIONID like '<#SESSION.SESSIONID/>'
IF @CONT=0
  BEGIN
  	   UPDATE <#SESSION.DB/>.DBO.USUARIOS_ACCESOS  WITH(ROWLOCK) SET ACTIVO=0 WHERE IDUSUARIO=<#SESSION.IDUSUARIO/> AND ACTIVO=1 
	   INSERT INTO <#SESSION.DB/>.DBO.USUARIOS_ACCESOS WITH(ROWLOCK) (SESSIONID, IDUSUARIO, DIRECCIONIP, BROWSER,ACTIVO) VALUES ('<#SESSION.SESSIONID/>',<#SESSION.IDUSUARIO/>,'<#SP_IPADDRESS/>', '<#SP_BROWSER/>',1)
  END	   

