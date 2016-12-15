//[session.idempresa|Untyped,tiempo|Numeric,session.db|Untyped,]
--SELECT 
DECLARE @FECHA FLOAT
DECLARE @IDEMPRESA INT
DECLARE @IDS VARCHAR(MAX)
SET @IDEMPRESA = '<#SESSION.IDEMPRESA/>'
SET @FECHA = ISNULL(:TIEMPO,0)
SET @IDS = ''

SELECT @IDS = @IDS + CAST(IDTABLA AS VARCHAR(MAX))+',' FROM <#SESSION.DB/>.DBO.ELIMINACIONES WITH(NOLOCK)
WHERE IDEMPRESA = @IDEMPRESA AND CAST(FECHAHORA AS FLOAT) > @FECHA AND IDTABLA IN (3, 8, 9, 10, 22, 23, 24, 25,  26, 27, 34, 35, 39) 

SELECT @IDS = @IDS + CAST(IDTABLA AS VARCHAR(MAX))+',' FROM <#SESSION.DB/>.DBO.MODIFICACIONES  WITH(NOLOCK)
WHERE IDEMPRESA = @IDEMPRESA AND CAST(FECHAHORA AS FLOAT) > @FECHA AND IDTABLA IN (3, 8, 9, 10, 22, 23, 24, 25,  26, 27, 34, 35, 39) 

SELECT @IDS AS IdTabla, CAST(GETDATE() AS FLOAT) AS Tiempo