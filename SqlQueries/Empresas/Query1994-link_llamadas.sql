//[session.db|Untyped,session.idempresa|Untyped,]
--select
DECLARE @IDEMPRESA INT 
SET @IDEMPRESA=<#SESSION.IDEMPRESA/>
SELECT LINKMOVIL
      ,LINKDESKTOP_FIJO
      ,LINKDESKTOP_MOVIL
FROM <#SESSION.DB/>.DBO.EMPRESAS
WHERE IDEMPRESA=@IDEMPRESA