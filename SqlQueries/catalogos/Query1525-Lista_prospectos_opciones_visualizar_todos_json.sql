//[tkco|Text,descartado|Integer,session.idusuario|Untyped,f_usuario|Text,session.nivel|Untyped,session.idgrupo|Untyped,session.mailconfig|Untyped,session.db|Untyped,]
--SELECT 
DECLARE @IDUSUARIO INT, @NIVELUSUARIO INT, @IDGRUPO INT, @MAILCONFIG INT
DECLARE @DESCARTADO TINYINT
DECLARE @TkCo VARCHAR(MAX)
DECLARE @F_USUARIO VARCHAR(MAX)

SET @TkCo = dbo.ValidaToken(ISNULL(:TKCo,''))
SET @DESCARTADO=CAST (ISNULL(:DESCARTADO,0) AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @F_USUARIO = ISNULL(:F_USUARIO,'')
SET @NIVELUSUARIO = CAST('<#SESSION.NIVEL/>' AS INT)
SET @IDGRUPO = CAST('<#SESSION.IDGRUPO/>' AS INT) 
SET @MAILCONFIG = CAST('<#SESSION.MAILCONFIG/>' AS INT )

EXEC <#SESSION.DB/>.DBO.SP_SELECT_PROSPECTOS_OPCIONES @IDUSUARIO,2,@F_USUARIO,@DESCARTADO,@TkCo,@MAILCONFIG,@NIVELUSUARIO