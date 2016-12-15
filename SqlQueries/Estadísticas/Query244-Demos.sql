//[idprospecto|Integer,session.db|Untyped,session.idempresa|Untyped,tkp|Text,]
--select
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @IDPROSPECTO INT, @IDEMPRESA INT
SET @IDPROSPECTO=ISNULL(:IDPROSPECTO,0)
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>

DECLARE @TKP VARCHAR(MAX)
SET @TKP = ISNULL(:TKP,'')
IF @TKP != '' BEGIN SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) END

SELECT COUNT(*) AS TOTAL, @TKP as tkp, @IDPROSPECTO as IDPROSPECTO FROM <#SESSION.DB/>.DBO.OPORTUNIDADES WHERE IDPROSPECTO = @IDPROSPECTO