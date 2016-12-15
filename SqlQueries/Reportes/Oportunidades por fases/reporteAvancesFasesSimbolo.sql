//[OBJETO|Text,session.db|Untyped]
--SELECT
/**************************/
DECLARE @OBJETO VARCHAR(MAX)
DECLARE @IDMONEDA VARCHAR(MAX)
DECLARE @TOTALMONEDA INT
DECLARE @TABLE_JSON table( ID int identity, PARENT_ID VARCHAR(MAX), NAME varchar(max), STRINGVALUE VARCHAR(MAX))

SET @OBJETO = ISNULL(:OBJETO,'')
INSERT INTO @TABLE_JSON
SELECT  PARENT_ID, NAME, STRINGVALUE AS VAL from [SALESUP_CT].[dbo].[parseJSON](@OBJETO) WHERE OBJECT_ID IS NULL AND STRINGVALUE != ''
SELECT @IDMONEDA = STRINGVALUE FROM @TABLE_JSON WHERE NAME = 'moneda'
SELECT @TOTALMONEDA = COUNT(NAME) FROM @TABLE_JSON WHERE NAME = 'moneda'
--SELECT @TOTALMONEDA
/**************************/
DECLARE @GUARDAIDMONEDA INT
DECLARE @IDMONEDASIMBOLO VARCHAR(MAX)
DECLARE @SIMBOLOOP VARCHAR(MAX)
SET @GUARDAIDMONEDA = 0
SET @SIMBOLOOP = ''
SET @IDMONEDASIMBOLO = ''


IF @IDMONEDA != ''
BEGIN
	IF @TOTALMONEDA > 1
	BEGIN 
		SET @SIMBOLOOP = '' 
	END
	ELSE
	BEGIN
		SELECT @GUARDAIDMONEDA = IDEMPRESAMONEDA FROM  <#SESSION.DB/>.DBO.MONEDAS WHERE TK = @IDMONEDA
		SELECT @IDMONEDASIMBOLO = IDMONEDA FROM  <#SESSION.DB/>.DBO.MONEDAS WHERE TK = @IDMONEDA
		SELECT @SIMBOLOOP = MONEDA_SIMBOLO  FROM SALESUP_CT.DBO.MONEDAS WHERE IDMONEDA = @IDMONEDASIMBOLO
		SET @SIMBOLOOP = <#SESSION.DB/>.dbo.FULL_UNICODE(@SIMBOLOOP)
	END
END

IF @TOTALMONEDA > 2
BEGIN
	SELECT @SIMBOLOOP
END
ELSE
BEGIN
	SELECT @SIMBOLOOP AS MONEDA_SIMBOLO
END

