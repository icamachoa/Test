//[tipoi|Integer,session.db|Untyped,session.idempresa|Untyped,config|Text,]
--select

DECLARE @TIPOI INT
DECLARE @TOKEN VARCHAR(64)
SET @TIPOI = CAST(ISNULL(:TIPOI,0) AS INT)
IF  @TIPOI = 0 SET  @TIPOI = 1

IF  @TIPOI = 1
  SET @TOKEN = 'FB'+ LEFT(CAST(NEWID() AS VARCHAR(64)), 62)
IF  @TIPOI = 2
  SET @TOKEN = 'SN'+ LEFT(CAST(NEWID() AS VARCHAR(64)), 62)
IF  @TIPOI = 3
  SET @TOKEN = 'HM'+ LEFT(CAST(NEWID() AS VARCHAR(64)), 62)

  INSERT INTO <#SESSION.DB/>.dbo.EMPRESAS_INTEGRACIONES (IDEMPRESA, TIPOINTEGRACION, CONFIG1, TOKEN) VALUES (<#SESSION.IDEMPRESA/>, @TIPOI, :CONFIG, @TOKEN)
    

 SELECT TOP 1 TOKEN, idintegracion FROM <#SESSION.DB/>.dbo.EMPRESAS_INTEGRACIONES  
 WHERE  IDEMPRESA = <#SESSION.IDEMPRESA/> AND TIPOINTEGRACION = @TIPOI order by IDINTEGRACION desc