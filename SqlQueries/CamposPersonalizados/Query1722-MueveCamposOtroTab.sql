//[session.idempresa|Untyped,taborigen|Integer,tabdestino|Integer,session.db|Untyped,]
--UPDATE

DECLARE @IDEMPRESA INT
DECLARE @TABORIGEN INT
DECLARE @TABDESTINO INT

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @TABORIGEN = CAST(ISNULL(:TABORIGEN,0) AS INT)
SET @TABDESTINO = CAST(ISNULL(:TABDESTINO,0) AS INT)

UPDATE <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS SET IDTAB=@TABDESTINO WHERE IDTAB=@TABORIGEN AND IDEMPRESA = @IDEMPRESA

UPDATE <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_CONFIGURACION SET IDTAB=@TABDESTINO WHERE IDTAB=@TABORIGEN AND IDEMPRESA = @IDEMPRESA

UPDATE <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS SET TAMBIENEN_IDTAB=@TABDESTINO WHERE TAMBIENEN_IDTAB=@TABORIGEN AND IDEMPRESA = @IDEMPRESA


