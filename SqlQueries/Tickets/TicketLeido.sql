//[tipousuario|Integer,idticket|Text,tkt|Text,idestado|Integer,session.idusuario|Untyped,visto|Integer,SESSION.CONVERTCODE|Untyped]
--SELECT
DECLARE @IDTICKET INT

SELECT @IDTICKET = IDTICKET FROM CONTROL.TICKETS.DBO.TICKETS WHERE TKT = COALESCE(:IDTICKET,:TKT,'')

UPDATE CONTROL.TICKETS.DBO.TICKETS 
SET VISTO_CLIENTE = 1
WHERE IDTICKET = @IDTICKET 

SELECT 1 AS RESPUESTA