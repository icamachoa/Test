//[session.idempresa|Untyped,q|Integer,tkcom|Text,session.db|Untyped,]
DECLARE @IDEMPRESA INT, @IDCOMPANIA INT
DECLARE @TKCOM VARCHAR(64)

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDCOMPANIA = ISNULL(:Q,0)
SET @TKCOM = ISNULL(:TKCOM,'') 

IF @TKCOM != '' BEGIN SELECT @IDCOMPANIA = IDCOMPANIA FROM <#SESSION.DB/>.dbo.COMPANIAS WHERE IDEMPRESA = @IDEMPRESA AND TKCOM = @TKCOM END 

SELECT IdCompania, Empresa 
FROM <#SESSION.DB/>.dbo.COMPANIAS 
WHERE IDEMPRESA = @IDEMPRESA AND IDCOMPANIA = @IDCOMPANIA