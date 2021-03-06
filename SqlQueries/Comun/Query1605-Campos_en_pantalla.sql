//[session.idusuario|Untyped,session.idempresa|Untyped,idventana|Integer,session.db|Untyped,]
--select 

DECLARE @IDUSUARIO INT, @IDPANTALLA INT, @IDEMPRESA INT, @VERPROSPECTOS INT, @VERVENTAS INT, @VEREMPRESA INT, @ORDENAR INT
DECLARE @VIZUALIZAREN VARCHAR(MAX)
DECLARE @TB TABLE (Id INT, Tipo INT, Columna VARCHAR(MAX), Campo VARCHAR(MAX), tCorreo VARCHAR(1))

SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDPANTALLA = ISNULL(:IDVENTANA,0)

SET @VIZUALIZAREN = ''
SET @ORDENAR = 0
SET @VEREMPRESA = 1
SET @VERPROSPECTOS = 0
SET @VERVENTAS = 0

IF @IDPANTALLA = 1 OR @IDPANTALLA = 4 BEGIN SET @VERPROSPECTOS = 1 END
IF @IDPANTALLA = 2 OR @IDPANTALLA = 3 BEGIN SET @VERVENTAS = 1 SET @VERPROSPECTOS = 1 END

IF @IDPANTALLA = 1 BEGIN SET @VIZUALIZAREN = '1' END
IF @IDPANTALLA = 4 BEGIN SET @VIZUALIZAREN = '1,3' END

IF @IDPANTALLA = 2 BEGIN SET @VIZUALIZAREN = '1,2' END
IF @IDPANTALLA = 3 BEGIN SET @VIZUALIZAREN = '1,4' END


INSERT @TB (ID, TIPO, COLUMNA, Campo, tCorreo)
SELECT UC.IdUsuarioColumna, 1, C.Columna, 
<#SESSION.DB/>.dbo.ObtieneOrderBy( UC.IDUSUARIOCOLUMNA , UC.IDUSUARIO , @IDPANTALLA , @IDEMPRESA , @ORDENAR  ),
CASE WHEN C.IDCOLUMNA IN(3,17,65) THEN '1' ELSE '' END
FROM SALESUP_CT.DBO.COLUMNAS C 
JOIN <#SESSION.DB/>.DBO.USUARIOS_COLUMNAS UC ON UC.IDCOLUMNA = C.IDCOLUMNA AND UC.IDUSUARIO = @IDUSUARIO AND C.IDPANTALLA = UC.IDPANTALLA
WHERE C.ORDENAR = 1 AND C.IDPANTALLA = @IDPANTALLA
ORDER BY C.COLUMNA


INSERT @TB (ID, TIPO, COLUMNA, Campo)
SELECT UC.IDUSUARIOCOLUMNA , 2, NOMBRE_CAMPO,
<#SESSION.DB/>.dbo.ObtieneOrderBy( UC.IDUSUARIOCOLUMNA , UC.IDUSUARIO , @IDPANTALLA , @IDEMPRESA , @ORDENAR  )  
FROM <#SESSION.DB/>.DBO.USUARIOS_COLUMNAS UC 
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS EC ON UC.IDCAMPO = EC.IDCAMPO AND EC.IDEMPRESA = @IDEMPRESA AND (EC.TIPO IN (SELECT SPLITVALUE FROM DBO.SPLIT(@VIZUALIZAREN,',')) OR EC.COMPARTIR IN (SELECT SPLITVALUE FROM DBO.SPLIT(@VIZUALIZAREN,',')))
WHERE UC.IDUSUARIO = @IDUSUARIO  AND UC.IDPANTALLA = @IDPANTALLA AND EC.IDCAMPO IS NOT NULL
ORDER BY NOMBRE_CAMPO


INSERT @TB (ID, TIPO, COLUMNA, Campo)
SELECT 
UC.IDUSUARIOCOLUMNA, 3, (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(CAT.CATALOGO,'/') WHERE OCCURENCEID = 1) , 
<#SESSION.DB/>.dbo.ObtieneOrderBy( UC.IDUSUARIOCOLUMNA , UC.IDUSUARIO , @IDPANTALLA , @IDEMPRESA , @ORDENAR  )
FROM <#SESSION.DB/>.dbo.USUARIOS_COLUMNAS UC 
LEFT JOIN <#SESSION.DB/>.dbo.CATALOGOS CAT ON CAT.IDEMPRESA = @IDEMPRESA AND CAT.IDCATALOGO = UC.IDCATALOGO AND (CAT.VERPROSPECTOS = @VERPROSPECTOS OR CAT.VEREMPRESA = 1) AND (CAT.VERVENTAS = @VERVENTAS OR CAT.VEREMPRESA = 1 OR CAT.VERPROSPECTOS = @VERPROSPECTOS) AND CAT.STATUS = 1
WHERE UC.IDUSUARIO = @IDUSUARIO AND UC.VISIBLE = 1 AND UC.IDPANTALLA = @IDPANTALLA AND CAT.IDCATALOGO IS NOT NULL
ORDER BY cat.catalogo

SELECT * FROM @TB


