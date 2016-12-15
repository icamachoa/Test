//[session.idusuario|Untyped,session.idempresa|Untyped,ltidinbox|Text,session.db|Untyped,]
--DELETE
/*protegido*/
DECLARE @ltIdInbox VARCHAR(MAX)
DECLARE @IDUSUARIO INT, @IDEMPRESA INT

SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @ltIdInbox = ISNULL(:ltIdInbox,'')

UPDATE UI SET UI.ACTIVO = 0, [READ] = 1 
FROM SALESUP_CT.dbo.Split(@ltIdInbox, '|') S1
LEFT JOIN <#SESSION.DB/>.dbo.USUARIOS_INBOX UI ON UI.IDINBOX = S1.SPLITVALUE AND UI.IDUSUARIO = @IDUSUARIO


UPDATE UIM SET ACTIVO = 0, [READ] = 1 
FROM SALESUP_CT.dbo.Split(@ltIdInbox, '|') S1
LEFT JOIN <#SESSION.DB/>.dbo.USUARIOS_INBOX UI ON UI.IDINBOX = S1.SPLITVALUE AND UI.IDUSUARIO = @IDUSUARIO 
JOIN <#SESSION.DB/>.dbo.USUARIOS_INBOX UIM ON UIM.IDINBOXMASTER = UI.IDINBOXMASTER AND UIM.ACTIVO = 1


