//[session.idempresa|Untyped|,session.db|Untyped|]

--SELECT

SELECT COUNT(*) AS CANTIDADENCERO FROM <#SESSION.DB/>.DBO.VENTAS
WHERE 
	(IDMONEDA = '*' OR IDMONEDA IS NULL OR IDMONEDA = '' ) AND 
	IDUSUARIO IN (
		SELECT IDUSUARIO 
		FROM <#SESSION.DB/>.DBO.USUARIOS 
		WHERE IDEMPRESA = <#SESSION.IDEMPRESA/>
	)