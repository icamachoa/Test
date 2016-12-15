//[session.idempresa|Untyped,]
SELECT DISTINCT YEAR (FECHA) as ANIO 
FROM SALESUP_CT.DBO.EMPRESA_INVITACIONES
WHERE 
  IDEMPRESA = <#SESSION.IDEMPRESA/>
UNION 
SELECT YEAR (GETDATE()) ORDER BY ANIO desc