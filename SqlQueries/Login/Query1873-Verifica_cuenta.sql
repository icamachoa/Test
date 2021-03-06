//[session.idusuario|Untyped,tipocuenta|Integer,session.db|Untyped,]
-- SELECT
/*PROTEGIDO*/

DECLARE @IDUSUARIO INT = <#SESSION.IDUSUARIO/>
DECLARE @TIPOCUENTA INT = ISNULL(:TIPOCUENTA,0)
DECLARE @TOTAL INT = 0

SELECT @TOTAL = COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WHERE IDUSUARIO = @IDUSUARIO AND (TIPO_CUENTA = @TIPOCUENTA OR (@TIPOCUENTA = 3 AND (TIPO_CUENTA = 1 OR TIPO_CUENTA = 2)))

SELECT @TOTAL AS TOTAL