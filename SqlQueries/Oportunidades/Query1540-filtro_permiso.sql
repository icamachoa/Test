//[idpantalla|Integer,session.idusuario|Untyped,session.db|Untyped,]
--select
DECLARE @IDPANTALLA INT, @IDUSUARIO INT
SET @IDPANTALLA = CAST(ISNULL(:IDPANTALLA,0) AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

SELECT COUNT(*) AS TOTALPERMISO , @IDPANTALLA AS IDPANTALLA
FROM <#SESSION.DB/>.DBO.ObtieneUsuariosAutorizadosModulos(@IDUSUARIO, @IDPANTALLA,0) 
WHERE ID != @IDUSUARIO