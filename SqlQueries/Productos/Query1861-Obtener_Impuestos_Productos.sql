//[session.idempresa|Untyped,session.db|Untyped,]
--SELECT 
/*PROTEGIDO*/

DECLARE @IDEMPRESA INT 
SET @IDEMPRESA='<#SESSION.IDEMPRESA/>'

SELECT IDIMPUESTO,IMPUESTO, STATUS, TASA,INDICE, TK FROM <#SESSION.DB/>.DBO.EMPRESAS_IMPUESTOS 
WHERE IDEMPRESA=@IDEMPRESA