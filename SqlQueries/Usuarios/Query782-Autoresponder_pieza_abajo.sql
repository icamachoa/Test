//[session.db|Untyped,idpieza|Integer,idautoresponder|Integer,]
--UPDATE
DECLARE @IDPIEZA INT = ISNULL(:IDPIEZA,0)
DECLARE @IDAUTORESPONDER INT = ISNULL(:IDAUTORESPONDER,0)
DECLARE @ARRIBA INT = 0

EXEC <#SESSION.DB/>.DBO.SP_AUTORESPONDER_PIEZA_LUGAR @IDPIEZA,@IDAUTORESPONDER,@ARRIBA
