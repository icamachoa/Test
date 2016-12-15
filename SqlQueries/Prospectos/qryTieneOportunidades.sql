//[USUARIOPROSPECTO|Integer,session.db|Untyped,session.idempresa|Untyped,session.nivel|Untyped,tkp|Text,]
--SELECT

DECLARE @IDPROSPECTO INT, @IDEMPRESA INT, @IDUSUARIOPROSPECTO INT, @tieneOportunidad int, @conservarOportunidad int, @NIVEL INT
DECLARE @TKP VARCHAR(MAX)

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @NIVEL = <#SESSION.NIVEL/>
SET @IDUSUARIOPROSPECTO = ISNULL(:USUARIOPROSPECTO,0)
SET @TKP = ISNULL(:TKP,'')

SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA)

SELECT @tieneOportunidad = COUNT(*)
FROM <#SESSION.DB/>.DBO.OPORTUNIDADES O 
WHERE O.IDPROSPECTO = @IDPROSPECTO

SELECT @conservarOportunidad = CASE WHEN (@IDUSUARIOPROSPECTO = IDUSUARIO) THEN 1 ELSE 0 END
FROM <#SESSION.DB/>.dbo.PROSPECTOS 
WHERE IDPROSPECTO = @IDPROSPECTO AND IDEMPRESA = @IDEMPRESA 

SELECT @tieneOportunidad AS tieneOportunidad, @conservarOportunidad AS conservarOportunidad, @NIVEL AS nivel

