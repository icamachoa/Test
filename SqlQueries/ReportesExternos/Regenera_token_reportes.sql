//[session.idempresa|Untyped,]
--select

DECLARE @IDEMPRESA INT
DECLARE @CLAVE VARCHAR(MAX)

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SET @CLAVE = 'PASS123'

exec <#session.db/>.[dbo].uspRandChars @len=10, @output=@CLAVE out

BEGIN TRY
	UPDATE bi.REPORTES_EXTERNOS.DBO.REPORTES_EXTERNOS SET clave=SALESUP_CT.DBO.VARCHARTOBASE64(@CLAVE) WHERE IDEMPRESA = @IDEMPRESA
	EXEC bi.REPORTES_EXTERNOS.DBO.SP_CAMBIA_CLAVE_REPORTES @IDEMPRESA,@CLAVE
    SELECT CAST(@CLAVE AS VARCHAR(MAX)) as CLAVE
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE()
END CATCH


