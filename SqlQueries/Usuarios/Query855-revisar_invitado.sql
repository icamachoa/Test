//[correoinvitado|Text,session.idempresa|Untyped,]
DECLARE @CORREO VARCHAR(256)
DECLARE @REVISA INT
DECLARE @IDEMPRESA INT
SET @CORREO = ISNULL(:CORREOINVITADO,'')
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>

SELECT COUNT(*) AS HAY, @CORREO AS CORREOINVITADO  FROM SALESUP_CT.dbo.EMPRESA_INVITACIONES WHERE CORREO = @CORREO AND STATUS = 1 AND IDEMPRESA = @IDEMPRESA