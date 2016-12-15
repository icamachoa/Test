//[session.multimoneda|Untyped,session.idempresa|Untyped,tk|Text,session.db|Untyped,session.default_pais|Untyped,]
-- SELECT 
/*PROTEGIDO*/
DECLARE @IDEMPRESA INT
DECLARE @TK VARCHAR(64)
DECLARE @IDPAIS VARCHAR(12) = ''
DECLARE @MULTIMONEDA INT = ISNULL(<#SESSION.MULTIMONEDA/>,0)

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @TK = ISNULL(:TK, '')

IF(@MULTIMONEDA > 0)
BEGIN
	 SELECT M.*, CTM.MONEDA+'('+CTM.IDMONEDA+')' AS MONEDA FROM <#SESSION.DB/>.DBO.MONEDAS M, MONEDAS CTM WHERE IDEMPRESA = @IDEMPRESA AND STATUS=1 AND M.IDMONEDA = CTM.IDMONEDA
	 AND CTM.MONEDA_SIMBOLO IS NOT NULL
END
ELSE
BEGIN
	 SET @IDPAIS = '<#SESSION.DEFAULT_PAIS/>'
	 SELECT PM.IDMONEDA, M.MONEDA+'('+M.IDMONEDA+')' AS MONEDA FROM PAISES_MONEDAS PM, MONEDAS M WHERE IDPAIS = @IDPAIS AND PM.IDMONEDA = M.IDMONEDA
END
