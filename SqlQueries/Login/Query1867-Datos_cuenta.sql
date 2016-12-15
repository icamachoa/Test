//[session.idusuario|Untyped,idusuariocorreo|Integer,session.db|Untyped,]
-- SELECT
/*PROTEGIDO*/
DECLARE @IDUSUARIO INT = <#SESSION.IDUSUARIO/>
DECLARE @IDUSUARIOCORREO INT = ISNULL(:IDUSUARIOCORREO,0)

SELECT 
EMAIL,FIRMA,CCO,PREDETERMINADO
FROM <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS WITH(NOLOCK)
WHERE IDUSUARIO = @IDUSUARIO AND IDUSUARIOCORREO = @IDUSUARIOCORREO