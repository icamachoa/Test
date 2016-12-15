//[idc|Integer,v|Text,session.idempresa|Untyped,session.idusuario|Untyped,tkcom|Text,session.db|Untyped,]
--SELECT
DECLARE @INDICE INT, @IDEMPRESA INT, @IDUSUARIO INT, @IDCOMPANIA INT
DECLARE @TKCOM VARCHAR(MAX), @VALOR VARCHAR(MAX)

SET @INDICE = ISNULL(:IDC,0)
SET @VALOR = :V
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

SET @TKCOM = ISNULL(:TKCOM,'')

IF @TKCOM != ''BEGIN SET @IDCOMPANIA = CAST(<#SESSION.DB/>.DBO.obtieneIdCompania(@TKCOM, @IDEMPRESA, @IDUSUARIO) AS VARCHAR(MAX)) END

SET @IDCOMPANIA = <#SESSION.DB/>.DBO.ValidaCamposUnicosEmpresas(@INDICE, @VALOR, @TKCOM, @IDEMPRESA)

SELECT C.IDCOMPANIA AS IDCOM, C.EMPRESA AS EMPRESA, U.IDUSUARIO, U.NOMBRE + ' ' + U.APELLIDOS +' ('+ U.INICIALES+ ')' as Usuario
FROM <#SESSION.DB/>.DBO.COMPANIAS C
LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U ON U.IDUSUARIO = C.IDUSUARIO 
WHERE C.IDCOMPANIA = @IDCOMPANIA AND C.IDEMPRESA = @IDEMPRESA