//[session.idempresa|Untyped,session.db|Untyped,]
--SELECT 
/*PROTEGIDO*/
DECLARE @IDEMPRESA INT 

SET @IDEMPRESA=<#SESSION.IDEMPRESA/>

SELECT IDPRODUCTO_COMISION as idComision, DESCRIPCION AS comision, indice
 FROM <#SESSION.DB/>.DBO.PRODUCTOS_COMISIONES
 WHERE IDEMPRESA=@IDEMPRESA AND STATUS = 1
 
 