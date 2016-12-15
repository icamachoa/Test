//[session.db|Untyped,tkca|Text,opcion|Text,descripcion|Text,campo13|Text,]
-- INSERT

DECLARE @IDCATALOGO INT
DECLARE @TOTALOPCIONES INT

SELECT @IDCATALOGO = IDCATALOGO FROM <#SESSION.DB/>.dbo.CATALOGOS WHERE TKCA = :TKCA

INSERT INTO <#SESSION.DB/>.dbo.CATALOGOS_OPCIONES (IDCATALOGO,OPCION,DESCRIPCION, CAMPO13) VALUES(@IDCATALOGO,:OPCION,:DESCRIPCION, ISNULL(:CAMPO13,''))

SELECT @TOTALOPCIONES = COUNT(*) FROM <#SESSION.DB/>.dbo.CATALOGOS_OPCIONES WHERE IDCATALOGO = @IDCATALOGO

UPDATE <#SESSION.DB/>.dbo.CATALOGOS SET OPCIONES = @TOTALOPCIONES WHERE IDCATALOGO = @IDCATALOGO