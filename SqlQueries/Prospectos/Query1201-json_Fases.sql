//[session.idempresa|Untyped,tconsulta|Integer,tf|Integer,session.db|Untyped,]
-- SELECT
DECLARE @IDEMPRESA INT, @TIPOCOSULTA INT, @TIPO INT
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @TIPOCOSULTA = CAST(ISNULL(:tConsulta,0) AS INT)
SET @TIPO = CAST(ISNULL(:TF,0) AS INT)


IF @TIPOCOSULTA = 1
BEGIN
	SELECT IdFase as value, Fase as Opcion, SALESUP_CT.dbo.esCanalizado(TK, TKM) AS esCanalizado
	FROM <#SESSION.DB/>.DBO.PROSPECTOS_FASES 
	WHERE IDEMPRESA = @IDEMPRESA AND FASECLIENTE = @TIPO ORDER BY ORDEN
END
ELSE
BEGIN
	SELECT 1 AS R, IdFase , Fase , SALESUP_CT.dbo.esCanalizado(TK, TKM) AS esCanalizado
	FROM <#SESSION.DB/>.DBO.PROSPECTOS_FASES 
	WHERE IDEMPRESA = @IDEMPRESA AND FASECLIENTE = @TIPO ORDER BY ORDEN
END



