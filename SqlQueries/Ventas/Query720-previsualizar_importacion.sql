//[session.db|Untyped,session.idusuario|Untyped,]
SELECT TOP 10 CASE WHEN P.IDPROSPECTO IS NOT NULL THEN 1 ELSE 0 END AS ESPROSPECTO, * FROM <#SESSION.DB/>.DBO.VENTAS_IMPORTACION V 
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS P ON P.IDPROSPECTO = V.IDPROSPECTO WHERE V.IDUSUARIO = <#SESSION.IDUSUARIO/>