 //[session.idusuario|Untyped,session.idproducto|Untyped,idcomentario|Integer,session.db|Untyped,]
--select
DECLARE @IDUSUARIO INT
DECLARE @IDEMPRESA INT
DECLARE @IDCOMENTARIO INT

SET @IDUSUARIO = 66
SET @IDEMPRESA =  26122
SET @IDCOMENTARIO =  ISNULL(:idcomentario,'')
 
  
EXEC <#SESSION.DB/>.DBO.SP_COMENTARIO_EJECUTIVO_TEST @IDEMPRESA, @IDUSUARIO ,@IDCOMENTARIO