//[session.convertcode|Untyped,session.db|Untyped,session.idusuario|Untyped,]
SELECT 
CONVERT(varchar(10),DEFAULT_VENTAS_DESDE,<#SESSION.CONVERTCODE/>) AS DEFAULT_VENTAS_DESDE,
CONVERT(VARCHAR(10),DEFAULT_VENTAS_HASTA,<#SESSION.CONVERTCODE/>) AS DEFAULT_VENTAS_HASTA,
IDUSUARIO
FROM <#SESSION.DB/>.DBO.USUARIOS_DEFAULTS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/>

