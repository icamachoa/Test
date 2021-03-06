//[session.db|Untyped,session.idempresa|Untyped,]
SELECT DISTINCT YEAR (V.FECHAHORA) as ANIO 
FROM <#SESSION.DB/>.DBO.VENTAS V, <#SESSION.DB/>.DBO.OPORTUNIDADES O, <#SESSION.DB/>.DBO.PROSPECTOS P
WHERE 
  V.IDOPORTUNIDAD = O.IDOPORTUNIDAD AND O.IDPROSPECTO = P.IDPROSPECTO AND P.IDEMPRESA = <#SESSION.IDEMPRESA/>
UNION  
SELECT YEAR (GETDATE()) ORDER BY ANIO desc
