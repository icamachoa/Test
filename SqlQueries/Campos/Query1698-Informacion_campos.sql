//[session.idempresa|Untyped,idtab|Integer,session.db|Untyped,]
--select 
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @IDEMPRESA INT, @IDTAB INT

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDTAB =ISNULL(:IDTAB,0)

exec <#SESSION.DB/>.DBO.SP_LISTAR_INFO_CAMPOS @IDTAB,@IDEMPRESA



