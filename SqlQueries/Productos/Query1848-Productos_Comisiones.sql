//[session.db|Untyped,session.idempresa|Untyped,]
--SELECT
/*PROTEGIDO*/


SELECT  IDPRODUCTO_COMISION, DESCRIPCION, MONTO as MONTO, CAST(TKCOMISION AS VARCHAR(256)) AS TKCOMISION, 
CASE WHEN STATUS=1 THEN 'Activo' ELSE 'Inactivo' END AS STATUS, STATUS AS STS

 FROM <#SESSION.DB/>.DBO.PRODUCTOS_COMISIONES 
WHERE IDEMPRESA=<#SESSION.IDEMPRESA/>
