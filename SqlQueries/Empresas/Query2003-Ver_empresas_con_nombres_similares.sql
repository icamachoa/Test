//[session.nivel|Untyped,session.idempresa|Untyped,empresa|Text,session.idusuario|Untyped,session.db|Untyped,]
--SELECT

DECLARE @IDEMPRESA INT
DECLARE @COMPANIA VARCHAR(MAX)
DECLARE @NIVEL INT
DECLARE @IDUSUARIO INT


SET @NIVEL = <#SESSION.NIVEL/>
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @COMPANIA = ISNULL(:empresa,'')
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>

EXEC <#SESSION.DB/>.DBO.SP_NOMBRE_EMPRESAS_SIMILARES @COMPANIA,@IDEMPRESA,@NIVEL,@IDUSUARIO