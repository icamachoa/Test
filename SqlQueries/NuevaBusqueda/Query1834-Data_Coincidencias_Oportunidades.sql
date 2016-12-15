//[session.idempresa|Untyped,session.idusuario|Untyped,ids|Text,campo|Text,session.db|Untyped,p|Integer,start|Integer,]
--select
/*protegido*/

DECLARE @IDEMPRESA INT, @IDUSUARIO INT
DECLARE  @IDTABLA INT, @PERMISOMODULO INT
DECLARE @HOWMANY INT, @PAGE INT, @START INT
DECLARE @IDS VARCHAR(max)
DECLARE @COINCIDENCIAS VARCHAR(max)

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

SET @IDTABLA = 15
SET @PERMISOMODULO = 1

SET @PAGE = cast(isnull(:p, 0) as int)
SET @START = cast(isnull(:start, 0) as int)

SET @IDS = :IDS
SET @COINCIDENCIAS=:CAMPO 

SET @HOWMANY = 5
IF @START > 0 BEGIN SET @HOWMANY = 20 END


EXEC <#SESSION.DB/>.DBO.SP_BUSQUEDA_EN_BASE_COINCIDENCIAS_OPORTUNIDADES @IDTABLA, @PERMISOMODULO, @IDUSUARIO, @IDEMPRESA, @IDS,@COINCIDENCIAS, @HOWMANY, @PAGE
