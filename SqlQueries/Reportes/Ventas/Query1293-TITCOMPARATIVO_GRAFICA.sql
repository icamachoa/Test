//[session.db|Untyped,session.idusuario|Untyped,idpantalla|Integer,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
select top 1  (CASE WHEN (TEXTO IS NULL OR TEXTO='0') THEN 'Ejecutivo' ELSE TEXTO END) AS TITGRAFICA FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS 
WHERE IDUSUARIO=<#SESSION.IDUSUARIO/> AND IDPANTALLA=ISNULL(:IDPANTALLA,0) AND TIPO in (1,2,3,4,5,6)