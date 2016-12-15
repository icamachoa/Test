//[session.db|Untyped,session.idgrupo|Untyped,session.idusuario|Untyped,session.idempresa|Untyped,]
--SELECT
DECLARE @CONT INT
DECLARE @IDGRUPO INT

SELECT @CONT=COUNT(UP.IDPLANTILLA) FROM <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS UP
LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U ON U.IDUSUARIO=UP.IDUSUARIO 
 WHERE TIPOCORREO = 1 AND (UP.COMPARTIRCON=<#SESSION.IDGRUPO/> OR UP.COMPARTIRCON=-1) AND UP.IDUSUARIO != <#SESSION.IDUSUARIO/> and U.IDEMPRESA=<#SESSION.IDEMPRESA/> 

IF @CONT>0 
 BEGIN
 	  SELECT U.IDGRUPO,UP.IDPLANTILLA,UP.IDUSUARIO,UP.ASUNTO,UP.COMPARTIRCON,UP.DESCRIPCION,0 AS ORDEN, 'PROPIAS' AS GRUPO
	  FROM <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS UP
	  LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U ON U.IDUSUARIO=UP.IDUSUARIO AND U.IDEMPRESA=<#SESSION.IDEMPRESA/>
	  WHERE TIPOCORREO = 1 AND UP.IDUSUARIO = <#SESSION.IDUSUARIO/>
	  UNION ALL
	  SELECT U.IDGRUPO,UP.IDPLANTILLA,UP.IDUSUARIO,UP.ASUNTO,UP.COMPARTIRCON,UP.DESCRIPCION,2,'COMPARTIDAS'
	  FROM <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS UP
	  LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U ON U.IDUSUARIO=UP.IDUSUARIO 
	  WHERE TIPOCORREO = 1 AND (UP.COMPARTIRCON=<#SESSION.IDGRUPO/> OR UP.COMPARTIRCON=-1) AND UP.IDUSUARIO != <#SESSION.IDUSUARIO/> and U.IDEMPRESA=<#SESSION.IDEMPRESA/> 
	  GROUP BY U.IDGRUPO,UP.IDPLANTILLA,UP.IDUSUARIO,UP.ASUNTO,UP.COMPARTIRCON,UP.DESCRIPCION
	  ORDER BY ORDEN ASC , DESCRIPCION ASC
 END
ELSE
  	  SELECT U.IDGRUPO,UP.IDPLANTILLA,UP.IDUSUARIO,UP.ASUNTO,UP.COMPARTIRCON,UP.DESCRIPCION,0 AS ORDEN, 'PROPIAS' as GRUPO
  	  FROM <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS UP
	  LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U ON U.IDUSUARIO=UP.IDUSUARIO
	  WHERE UP.IDUSUARIO = <#SESSION.IDUSUARIO/> and U.IDEMPRESA=<#SESSION.IDEMPRESA/>
	  AND TIPOCORREO = 1
	  ORDER BY ORDEN ASC, DESCRIPCION ASC
 

