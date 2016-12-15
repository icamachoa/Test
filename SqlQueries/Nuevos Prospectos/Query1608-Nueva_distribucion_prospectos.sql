//[usuarios_canal|Integer,tipo_dis|Integer,session.db|Untyped,session.idempresa|Untyped,usuarios_lista|Text,]
-- UPDATE

DECLARE @IDUSUARIO_CANALIZACION INT
DECLARE @CANALIZACION INT
DECLARE @usuarios_canal INT
DECLARE @TIPO_DIS INT
DECLARE @usuarios_lista VARCHAR(MAX)

SET @usuarios_canal=ISNULL(:usuarios_canal,0)
SET @TIPO_DIS=ISNULL(:TIPO_DIS,0)
SET @usuarios_lista=ISNULL(:usuarios_lista,'')
SET @IDUSUARIO_CANALIZACION = CAST(@usuarios_canal AS INT)
SET @CANALIZACION = CAST (@TIPO_DIS  AS INT)

UPDATE <#SESSION.DB/>.DBO.EMPRESAS SET IDUSUARIO_CANALIZACION=@IDUSUARIO_CANALIZACION, CANALIZACION=@CANALIZACION WHERE IDEMPRESA=<#SESSION.IDEMPRESA/>

IF (@usuarios_lista!='')
  EXEC <#SESSION.DB/>.DBO.SP_GUARDA_USUARIOS_CANALIZACION <#SESSION.IDEMPRESA/>,@usuarios_lista,1