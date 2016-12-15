//[session.idempresa|Untyped,session.db|Untyped,]
--SELECT 
/*PROTEGIDO*/
DECLARE @SESSIONIDEMPRESA INT
SET @SESSIONIDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

USE master
/*OPEN MASTER KEY DECRYPTION BY PASSWORD = 'BFX.Cancun2013'*/
OPEN SYMMETRIC KEY KeyGrupoBFX DECRYPTION BY CERTIFICATE CertBFX;

IF (SELECT COUNT(*) FROM CONTROL.VENTAS.DBO.EMPRESA_DATOS_FACTURACION WHERE IDEMPRESA = @SESSIONIDEMPRESA  and idproducto=1) =0
SELECT 'MX' AS F_PAIS, 0 AS FORMA_PAGO, 0 AS FACTURA FROM <#SESSION.DB/>.dbo.EMPRESAS WHERE IDEMPRESA = @SESSIONIDEMPRESA 
ELSE
SELECT IDESTADO AS F_ESTADO, IDPAIS AS F_PAIS,
CONVERT(VARCHAR(128),DECRYPTBYKEY(TARJETA_NUMERO)) AS TARJETA_NUMERO,
  CONVERT(VARCHAR(128),DECRYPTBYKEY(TARJETA_CODIGO)) AS TARJETA_CODIGO,
  CONVERT(VARCHAR(128),DECRYPTBYKEY(TARJETA_ANNIO)) AS TARJETA_ANNIO,
  CONVERT(VARCHAR(128),DECRYPTBYKEY(TARJETA_MES)) AS TARJETA_MES,* from CONTROL.VENTAS.DBO.EMPRESA_DATOS_FACTURACION WHERE IDEMPRESA = @SESSIONIDEMPRESA  and idproducto=1

CLOSE SYMMETRIC KEY KeyGrupoBFX
use SALESUP_CT