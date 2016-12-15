//[session.idempresa|Untyped,tk|Text,session.db|Untyped,]
-- SELECT 

DECLARE @IDEMPRESA INT
DECLARE @TK VARCHAR(64)

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @TK = dbo.ValidaToken(:TK)

IF(@TK = '0')
BEGIN
	 SELECT * FROM SALESUP_CT.dbo.V_INDICES WHERE INDICE NOT IN (SELECT INDICE FROM <#SESSION.DB/>.DBO.LISTAS_PRECIO WHERE IDEMPRESA = @IDEMPRESA)
END
ELSE
BEGIN
	 SELECT * FROM SALESUP_CT.DBO.V_INDICES
END