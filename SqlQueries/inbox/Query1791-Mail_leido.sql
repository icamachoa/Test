//[session.idusuario|Untyped,idtabinbox|Integer,idinbox|Integer,session.db|Untyped,]
--update
/*protegido*/
DECLARE @IDUSUARIO INT, @idTabInbox INT, @IDINBOX INT, @LEIDO INT, @IDINBOXMASTER INT

SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @idTabInbox = ISNULL(:idTabInbox,0)
SET @IDINBOX = ISNULL(:IdInbox,0)

SELECT @IDINBOXMASTER = IDINBOXMASTER FROM <#SESSION.DB/>.dbo.USUARIOS_INBOX 
WHERE IDINBOX = @IDINBOX AND IDUSUARIO = @IDUSUARIO

UPDATE <#SESSION.DB/>.dbo.USUARIOS_INBOX
SET [READ] = 1 
WHERE IDINBOX = @IDINBOX AND IDUSUARIO = @IDUSUARIO

UPDATE <#SESSION.DB/>.dbo.USUARIOS_INBOX
SET [READ] = 1 
WHERE IDINBOXMASTER = @IDINBOXMASTER AND IDUSUARIO = @IDUSUARIO


