//[session.idempresa|Untyped,idempresamoneda|Integer,session.db|Untyped,]
--SELECT
/*PROTEGIDO*/

DECLARE @IDEMPRESA INT = <#SESSION.IDEMPRESA/>
DECLARE @IDEMPRESAMONEDA INT = ISNULL(:IDEMPRESAMONEDA,0)

SELECT M.IDEMPRESAMONEDA, CTM.MONEDA+'('+M.IDMONEDA+')' AS MONEDA FROM <#SESSION.DB/>.DBO.MONEDAS M, MONEDAS CTM WHERE M.IDEMPRESA = @IDEMPRESA AND M.IDMONEDA = CTM.IDMONEDA AND M.IDEMPRESAMONEDA <> @IDEMPRESAMONEDA AND M.STATUS = 1