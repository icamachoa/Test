//[t|Integer,tk|Text,session.db|Untyped,]
--select
DECLARE @IDTABLA INT
DECLARE @TOKEN VARCHAR(1000)
SET @IDTABLA=ISNULL(:T,0)
SET @TOKEN = ISNULL(:TK,'')

EXEC <#SESSION.DB/>.dbo.SP_BUSQUEDA_EN_BASE_COINCIDENCIAS_OTROS_CAMPOS @IDTABLA, @TOKEN