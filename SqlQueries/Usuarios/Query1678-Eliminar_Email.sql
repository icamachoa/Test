//[idemail|Integer,session.db|Untyped,]
--DELETE
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @IDEMAIL INT
DECLARE @P VARCHAR(MAX)
DECLARE @FECHAHOY DATETIME

SET @FECHAHOY = GETDATE()

SET @IDEMAIL = ISNULL(:IDEMAIL,0)

SELECT @P = CAST(IDPROSPECTO AS VARCHAR) FROM <#SESSION.DB/>.DBO.USUARIOS_EMAILS WHERE IDEMAIL = @IDEMAIL
SELECT @P

DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_EMAILS
WHERE IDEMAIL = @IDEMAIL

EXEC <#SESSION.DB/>.DBO.SP_UPDATE_PROSPECTOS_ASIGNADOS @P,@FECHAHOY,1
