//[tk|Text,session.db|Untyped,]
--UPDATE
DECLARE @TK VARCHAR(64)

SET @TK = ISNULL(:TK,'')

DELETE FROM <#SESSION.DB/>.dbo.DASHBOARD_CONFIGURACION WHERE TKDBCONF = @TK
