//[session.idempresa|Untyped,]
--DELETE

DECLARE @IDEMPRESA INT
DECLARE @TOKEN VARCHAR(256)

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SELECT @TOKEN = TOKEN FROM bi.REPORTES_EXTERNOS.DBO.REPORTES_EXTERNOS WHERE IDEMPRESA=@IDEMPRESA

UPDATE bi.REPORTES_EXTERNOS.DBO.REPORTES_EXTERNOS SET BORRARBASE=1 WHERE IDEMPRESA=@IDEMPRESA

/*	IF EXISTS(SELECT * FROM ESTADISTICAS.REPORTES_EXTERNOS.DBO.REPORTES_EXTERNOS WHERE IDEMPRESA=@IDEMPRESA AND PROCESADO  = 1)
	BEGIN 
		DELETE FROM ESTADISTICAS.REPORTES_EXTERNOS.DBO.REPORTES_EXTERNOS WHERE IDEMPRESA=@IDEMPRESA
		EXEC ESTADISTICAS.REPORTES_EXTERNOS.DBO.SP_ELIMINA_BASE_DATOS_REPORTES_EXTERNOS @TOKEN
	END
	ELSE IF EXISTS(SELECT * FROM ESTADISTICAS.REPORTES_EXTERNOS.DBO.REPORTES_EXTERNOS WHERE IDEMPRESA=@IDEMPRESA AND PROCESADO  = 0)
	BEGIN 
		DELETE FROM ESTADISTICAS.REPORTES_EXTERNOS.DBO.REPORTES_EXTERNOS WHERE IDEMPRESA=@IDEMPRESA
	END

*/