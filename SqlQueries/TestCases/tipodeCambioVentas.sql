//[session.idempresa|Untyped|,session.db|Untyped|]

--SELECT

SELECT COUNT(*) AS CANTIDADENCERO FROM <#SESSION.DB/>.dbo.VENTAS 
WHERE 
(TIPODECAMBIO = 0 OR TIPODECAMBIO IS NULL) AND
IDUSUARIO IN (
	SELECT IDUSUARIO 
	FROM <#SESSION.DB/>.dbo.USUARIOS
	WHERE IDEMPRESA = <#SESSION.IDEMPRESA/>
)