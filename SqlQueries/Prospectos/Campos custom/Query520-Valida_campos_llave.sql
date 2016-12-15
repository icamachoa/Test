//[idcampo|Integer,valor|Text,session.db|Untyped,session.convertcode|Untyped,idprospecto|Integer,session.idempresa|Untyped,]
-- SELECT

DECLARE @IDPROSPECTO INT
DECLARE @IDPROS INT
DECLARE @INDICE INT
DECLARE @VALOR VARCHAR(200) 
DECLARE @IDCAMPO INT
SET @IDCAMPO=ISNULL(:IDCAMPO,0)
SET @VALOR=:VALOR
SET @IDPROS = ISNULL(:IDPROSPECTO,0)

SELECT @INDICE = INDICE FROM <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS WHERE IDCAMPO = @IDCAMPO
IF (@INDICE in (9,10,11,12))
  SET  @IDPROSPECTO = <#SESSION.DB/>.dbo.ValidaCampoLlave(@IDCAMPO,CONVERT (DATETIME,@VALOR,<#SESSION.CONVERTCODE/>), @IDPROS, <#SESSION.IDEMPRESA/>)
ELSE
  SET  @IDPROSPECTO = <#SESSION.DB/>.dbo.ValidaCampoLlave(@IDCAMPO,@VALOR, @IDPROS, <#SESSION.IDEMPRESA/>)


IF  @IDPROSPECTO  = -1 
  SELECT  '-1' AS RESULTADO , 0 AS DESCARTADO, @IDPROS AS  IDPROSPECTO 
ELSE
IF  @IDPROSPECTO  = 0
  SELECT  '0' AS RESULTADO, 0 AS DESCARTADO, @IDPROS AS  IDPROSPECTO 
ELSE
  SELECT DESCARTADO, CAST(ISNULL(NOMBRE, '') AS VARCHAR(256))+ ' ' + CAST(ISNULL(APELLIDOS, '') AS VARCHAR(256))  AS RESULTADO, @IDPROS AS  IDPROSPECTO FROM <#SESSION.DB/>.dbo.PROSPECTOS WHERE IDPROSPECTO = @IDPROSPECTO 
  
  
  
