//[session.db|Untyped,session.idusuario|Untyped,idpantalla|Integer,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
SELECT *,  <#SESSION.DB/>.DBO.UDF_NOMBRE_FILTRO(TIPO) AS TIPOTXT  
FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS 
WHERE IDUSUARIO=<#SESSION.IDUSUARIO> AND IDPANTALLA=ISNULL(:IDPANTALLA,0) and tipo=20
ORDER BY TIPO