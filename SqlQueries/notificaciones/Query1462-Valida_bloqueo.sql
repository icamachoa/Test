//[session.db|Untyped,session.idempresa|Untyped,]
SELECT
  ISNULL(BLOQUEARNOTIFICACIONES, 0) AS BLOQUEADO
FROM
  <#SESSION.DB/>.dbo.EMPRESAS
WHERE 
  IDEMPRESA = <#SESSION.IDEMPRESA/>