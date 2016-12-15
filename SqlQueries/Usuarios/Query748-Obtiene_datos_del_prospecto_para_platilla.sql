//[session.idusuario|Untyped,session.idempresa|Untyped,idprospecto|Integer,idplantilla|Integer,idoportunidad|Text,sinprospecto|Integer,tkp|Text,tko|Text,session.db|Untyped,]
--select
/*PROTEGIDO*/
DECLARE @CADENA VARCHAR(MAX), @ASUNTO VARCHAR(MAX)
DECLARE @INICIO INT, @INICIO2 INT, @FIN INT, @CONTADOR INT, @INTENTOS INT
DECLARE @VALOR VARCHAR(MAX), @ANEXOS VARCHAR(MAX), @OPORTUNIDADES VARCHAR(MAX)
DECLARE @IDoportunidad INT, @TieneAnexos INT
DECLARE @IDUSUARIO INT , @IDEMPRESA INT
DECLARE @IDPROSPECTO INT , @IDPLANTILLA INT
DECLARE @SINPROSPECTO INT
DECLARE @JSONETIQUETAS VARCHAR(MAX)
DECLARE @TEXTOPLANTILLA VARCHAR(MAX)

SET @IDUSUARIO = <#SESSION.IDUSUARIO/> 
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDPROSPECTO = ISNULL(:IDPROSPECTO, 0)
SET @IDPLANTILLA = ISNULL(:IDPLANTILLA, 0)
SET @IDOPORTUNIDAD = ISNULL(:IDoportunidad,'')
SET @SINPROSPECTO = ISNULL(:SINPROSPECTO,0)

DECLARE @TKP VARCHAR(MAX), @TKO VARCHAR(MAX)

SET @TKP = ISNULL(:TKP,'')
SET @TKO = ISNULL(:TKO,'')

IF @TKP != '' BEGIN SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) END
IF @TKO != '' BEGIN SET @IDOPORTUNIDAD = <#SESSION.DB/>.dbo.obtieneIdOportunidad(@TKO) END



SET @ANEXOS = ''
SELECT TOP 1 @IDoportunidad = CAST(SplitValue AS INT) from <#SESSION.DB/>.dbo.Split(@OPORTUNIDADES,',')


SELECT @CADENA = CUERPO, @ASUNTO = ASUNTO ,
@TieneAnexos = LEN(CONVERT(VARCHAR(MAX), ISNULL(REPLACE(CONVERT(VARCHAR(MAX), ANEXOS), CHAR(10)+CHAR(13) , ''),''))),
@ANEXOS = ANEXOS
FROM <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS 
WHERE IDPLANTILLA = @IDPLANTILLA


IF(@SINPROSPECTO = 0)
BEGIN
SET @VALOR = ''
SET @CONTADOR = 0
SET @INTENTOS = 30
SET @INICIO = CHARINDEX ('[', @CADENA,1)
SET @FIN = CHARINDEX (']', @CADENA,1)
SET @INICIO2 = CHARINDEX('[', @CADENA,1+CHARINDEX(']', @CADENA,1)) 
IF @INICIO2 = '0'
SET @INICIO2 = @FIN+1

WHILE @INICIO <> 0 AND @FIN <> 0 AND @CONTADOR < @INTENTOS
BEGIN

IF ( (@INICIO > @FIN) OR (@INICIO=@INICIO2) )
BEGIN
   SET @VALOR = SUBSTRING(CAST(@CADENA AS VARCHAR(MAX)), 0, @INICIO2-1)
   SET @VALOR = REPLACE (@VALOR,']','<b style=''color:red''>} << ERROR: ETIQUETA NO VALIDA  </b>')
   SET @CADENA = REPLACE (@CADENA,SUBSTRING(CAST(@CADENA AS VARCHAR(MAX)), 0, @INICIO2-1),@VALOR)

END
ELSE
BEGIN

IF (@FIN > @INICIO2)
  BEGIN
  SET @FIN = @FIN-@INICIO
   SET @VALOR = SUBSTRING(CAST(@CADENA AS VARCHAR(MAX)), @INICIO+1, @FIN-1)
   SET @VALOR = REPLACE (@VALOR,'[','{')
   SET @VALOR = '<b style=''color:red''>{'+@VALOR+'}</b><b style=''color:red''> << ERROR: ETIQUETA NO VALIDA </b>'
   SET @CADENA = REPLACE (@CADENA,'['+SUBSTRING(CAST(@CADENA AS VARCHAR(MAX)), @INICIO+1, @FIN-1)+']',@VALOR)
  END
  ELSE
  BEGIN
  SET @FIN = @FIN-@INICIO
  SET @VALOR = <#SESSION.DB/>.DBO.ObtieneEtiquetasPlantillas(@IDPROSPECTO,@IDUSUARIO,@IDEMPRESA,SUBSTRING(CAST(@CADENA AS VARCHAR(MAX)), @INICIO+1, @FIN-1),@IDoportunidad)
  SET @CADENA = REPLACE (@CADENA,'['+SUBSTRING(CAST(@CADENA AS VARCHAR(MAX)), @INICIO+1, @FIN-1)+']',@VALOR)
  END
  
END
SET @INICIO = CHARINDEX ('[', @CADENA,1)
SET @INICIO2 = CHARINDEX('[', @CADENA,1+CHARINDEX(']', @CADENA,1))   
SET @FIN = CHARINDEX (']', @CADENA,1)
SET @CONTADOR = @CONTADOR+1

IF @INICIO2 = '0'
SET @INICIO2 = @FIN+1

END

SELECT @CADENA AS TEXTO , <#SESSION.DB/>.dbo.ObtieneCuerpoAutoresponder(@ASUNTO,@IDPROSPECTO,@IDUSUARIO,@IDEMPRESA,@IDoportunidad) AS ASUNTO, @TieneAnexos AS TieneAnexos, @ANEXOS AS Anexos
END
ELSE
BEGIN
	 SELECT @CADENA AS TEXTO , @ASUNTO AS ASUNTO, @TieneAnexos AS TieneAnexos, @ANEXOS AS Anexos
END



