//[session.idempresa|Untyped,]
--SELECT

DECLARE @IDEMPRESA INT
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)


	IF EXISTS(SELECT * FROM bi.REPORTES_EXTERNOS.DBO.REPORTES_EXTERNOS WHERE IDEMPRESA=@IDEMPRESA AND BORRARBASE=0)
	   	SELECT 1 AS ACTIVA
	ELSE
		SELECT 0 AS ACTIVA
