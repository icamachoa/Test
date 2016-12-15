//[session.idusuario|Untyped,idven|Integer,b|Text,i|Text,session.convertcode|Untyped,da|Text,tipocampo|Integer,tc|Integer,session.db|Untyped,]
--INSERT 
/*protegido*/
DECLARE @IDUSUARIO INT, @IDPANTALLA INT, @CAMPOTIPO INT, @tipocampo INT
DECLARE @BUSCARDATO VARCHAR(MAX), @INDICE VARCHAR(32), @CONVERTCODE VARCHAR(32), @DATOADICIONAL VARCHAR(MAX)

SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @CONVERTCODE = '<#SESSION.CONVERTCODE/>'
SET @IDPANTALLA = ISNULL(:IDVEN,0)
SET @BUSCARDATO = ISNULL(:B,'')
SET @INDICE = ISNULL(:I,'')
SET @DATOADICIONAL = ISNULL(:DA,'') 
set @tipocampo = ISNULL(:tipocampo,0)
SET @CAMPOTIPO = ISNULL(:tc,0)

EXEC <#SESSION.DB/>.dbo.SP_GUARDA_FILTRO_PERSONALIZADO @IDUSUARIO, @IDPANTALLA, @BUSCARDATO, @INDICE, @CONVERTCODE, @DATOADICIONAL, @CAMPOTIPO, @tipocampo