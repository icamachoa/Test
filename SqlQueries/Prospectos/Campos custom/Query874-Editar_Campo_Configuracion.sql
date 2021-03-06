//[idcampo|Integer,tipo|Integer,idcampocon|Integer,mostrarcampo|Text,session.db|Untyped,session.idempresa|Untyped,]
--UPDATE
DECLARE @IDCAMPO INT
DECLARE @IDCAMPOCON INT
DECLARE @TIPO INT, @mostrar INT
DECLARE @VALIDACION VARCHAR(256)

SET @IDCAMPO = ISNULL(:IDCAMPO,0)
SET @TIPO = ISNULL(:TIPO,0)
SET @IDCAMPOCON = ISNULL(:IDCAMPOCON,0)
set @mostrar = ISNULL(:MostrarCampo,'')

IF @TIPO = 0 SET @VALIDACION = ''

IF @TIPO = 1 SET @VALIDACION = 'llave'

IF @TIPO = 2 SET @VALIDACION = 'obligatorio'

IF @TIPO = 3 SET @VALIDACION = 'llave obligatorio'

IF @TIPO = 4 SET @VALIDACION = 'sugerido'

UPDATE <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_CONFIGURACION 
SET IDEMPRESA = <#SESSION.IDEMPRESA/>,
CAMPO = @IDCAMPO,
TIPO = @TIPO,
VALIDACION = @VALIDACION, MOSTRAR = @MOSTRAR
WHERE IDCAMPOCON = @IDCAMPOCON