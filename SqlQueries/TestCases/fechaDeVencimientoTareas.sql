//[session.idempresa|Untyped|,session.db|Untyped|]

--SELECT

SELECT COUNT(*) AS NUMTAREAS FROM <#SESSION.DB/>.dbo.TAREAS 
WHERE MASTIEMPO > 0 AND  
	FECHA_CREACION > FECHA_VENCIMIENTO AND 
	DBO.GETONLYDATE(FECHA_VENCIMIENTO) = CONVERT(DATETIME,'12/04/2016',103) AND
	IDINICIADOR IN (SELECT IDUSUARIO FROM <#SESSION.DB/>.dbo.USUARIOS WHERE IDEMPRESA = <#SESSION.IDEMPRESA/>)