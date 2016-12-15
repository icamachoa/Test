//[valor|Text,idcampo|Integer,session.db|Untyped,session.convertcode|Untyped,idprospecto|Integer,session.idempresa|Untyped,]
-- SELECT
DECLARE @USR INT
DECLARE @IDPROSPECTO INT
DECLARE @INDICE INT
DECLARE @VALOR VARCHAR(200) 
DECLARE @IDCAMPO INT
DECLARE @IDPROSPECTOF INT
SET @IDPROSPECTOF=ISNULL(:IDPROSPECTO,0)
SET @IDCAMPO=ISNULL(:IDCAMPO,0)

SET @VALOR=:VALOR
IF @IDCAMPO >= 0 
BEGIN
	 SELECT @INDICE = INDICE FROM <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS WHERE IDCAMPO = @IDCAMPO
	 IF (@INDICE in (9,10,11,12))
	 SET  @IDPROSPECTO = <#SESSION.DB/>.dbo.ValidaCampoLlave_V2(@IDCAMPO,CONVERT (DATETIME,@VALOR,<#SESSION.CONVERTCODE/>), @IDPROSPECTOF, <#SESSION.IDEMPRESA/>)
	 ELSE
	 SET  @IDPROSPECTO = <#SESSION.DB/>.dbo.ValidaCampoLlave_V2(@IDCAMPO,@VALOR, @IDPROSPECTOF, <#SESSION.IDEMPRESA/>)
END
ELSE
BEGIN
	 SET  @IDPROSPECTO = <#SESSION.DB/>.dbo.ValidaCampoLlave_V2(@IDCAMPO,@VALOR, @IDPROSPECTOF, <#SESSION.IDEMPRESA/>)
END
  
  
  

	 IF @IDPROSPECTO  = -1 
	   SELECT  '-1' AS RESULTADO , 0 AS DESCARTADO, @IDCAMPO AS IDCAMPO, @IDPROSPECTOF AS IDPROSPECTO
	 ELSE
	 IF  @IDPROSPECTO  = 0
	   SELECT  '0' AS RESULTADO, 0 AS DESCARTADO, @IDCAMPO AS IDCAMPO, @IDPROSPECTOF AS IDPROSPECTO
	 ELSE
	   SELECT IDPROSPECTO ,DESCARTADO, CAST(ISNULL(NOMBRE, '') AS VARCHAR(256))+ ' ' + CAST(ISNULL(APELLIDOS, '') AS VARCHAR(256))  AS RESULTADO  , @IDCAMPO AS IDCAMPO, @IDPROSPECTOF AS IDPROSPECTO
	   FROM <#SESSION.DB/>.dbo.PROSPECTOS WHERE IDPROSPECTO = @IDPROSPECTO 
