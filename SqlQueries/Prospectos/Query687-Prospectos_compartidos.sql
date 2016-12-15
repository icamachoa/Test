//[idprospecto|Integer,session.db|Untyped,session.idempresa|Untyped,tkp|Text,]
--SELECT 
DECLARE @DUENIO INT
DECLARE @IDPROSPECTO INT, @IDEMPRESA INT

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDPROSPECTO = ISNULL(:IDPROSPECTO,0)


DECLARE @TKP VARCHAR(MAX)
SET @TKP = ISNULL(:TKP,'')
IF @TKP != '' BEGIN SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) END


SELECT @DUENIO = IDUSUARIO FROM <#SESSION.DB/>.dbo.PROSPECTOS WHERE IDPROSPECTO = @IDPROSPECTO

SELECT US.IDUSUARIO, US.NOMBRE, US.APELLIDOS FROM <#SESSION.DB/>.dbo.USUARIOS US WHERE US.IDEMPRESA = <#SESSION.IDEMPRESA/> AND US.IDUSUARIO IN(
SELECT IDUSUARIO FROM <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS WHERE IDPROSPECTO = @IDPROSPECTO AND IDUSUARIO <> @DUENIO)

