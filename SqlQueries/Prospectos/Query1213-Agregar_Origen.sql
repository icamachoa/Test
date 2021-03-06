//[session.idempresa|Untyped,origen|Text,session.db|Untyped,]
--SELECT
DECLARE @IDEMPRESA INT, @EXISTE INT
DECLARE @ORIGEN VARCHAR(MAX)
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @ORIGEN = <#SESSION.DB/>.dbo.PreparaCadena(:ORIGEN)

SELECT @EXISTE = COUNT(*) FROM <#SESSION.DB/>.dbo.PROSPECTOS_ORIGENES WHERE IDEMPRESA = @IDEMPRESA AND ORIGEN = @ORIGEN
	   
IF @EXISTE = 0
BEGIN
  INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES(ORIGEN, IDEMPRESA) VALUES (@ORIGEN ,@IDEMPRESA)
END

SELECT TOP 1 IdOrigen AS Id FROM <#SESSION.DB/>.dbo.PROSPECTOS_ORIGENES WHERE IDEMPRESA = @IDEMPRESA AND ORIGEN = @ORIGEN ORDER BY 1 DESC