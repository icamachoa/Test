//[session.idempresa|Untyped,veren|Integer,session.db|Untyped,]
--SELECT
/*PROTEGIDO*/
DECLARE @IDEMPRESA INT, @TEXTO INT, @NUMERICOS INT, @DECIMALES INT
DECLARE @LISTA INT, @FECHA INT, @TOTAL INT, @UUID INT, @AUTOINCREMENTABLE INT, @TIPO INT
DECLARE @TIPOS VARCHAR(6)
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @TIPO = ISNULL(:VerEn,0)
SET @TIPOS = ''

IF @TIPO IN (1,3) BEGIN SET @TIPOS = '1,3' END
IF @TIPO IN (2,4) BEGIN SET @TIPOS = '2,4' END


SELECT @NUMERICOS = 4 -COUNT(*) FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS where IDEMPRESA = @IDEMPRESA AND TIPO IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@TIPOS,',')) AND INDICE BETWEEN 1 AND 4 
SELECT @DECIMALES = 4 -COUNT(*) FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS where IDEMPRESA = @IDEMPRESA AND TIPO IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@TIPOS,',')) AND INDICE BETWEEN 5 AND 8
SELECT @FECHA     = 4 -COUNT(*) FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS where IDEMPRESA = @IDEMPRESA AND TIPO IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@TIPOS,',')) AND INDICE BETWEEN 9 AND 12
SELECT @TEXTO     = 45-COUNT(*) FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS where IDEMPRESA = @IDEMPRESA AND TIPO IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@TIPOS,',')) AND ( (INDICE BETWEEN 13 AND 20) OR (INDICE BETWEEN 26 AND 32) OR (INDICE BETWEEN 35 AND 64) ) 
SELECT @LISTA     = 5 -COUNT(*) FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS where IDEMPRESA = @IDEMPRESA AND TIPO IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@TIPOS,',')) AND INDICE BETWEEN 21 AND 25
SELECT @AUTOINCREMENTABLE = 1-COUNT(*) FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS where IDEMPRESA = @IDEMPRESA AND TIPO IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@TIPOS,',')) AND INDICE BETWEEN 33 AND 33 
SELECT @UUID      = 1-COUNT(*) FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS where IDEMPRESA = @IDEMPRESA AND TIPO IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT(@TIPOS,',')) AND INDICE BETWEEN 34 AND 34 

SET @TOTAL = @NUMERICOS + @DECIMALES + @TEXTO + @LISTA + @FECHA + @AUTOINCREMENTABLE + @UUID

SELECT @NUMERICOS AS NUMERO , @DECIMALES AS DECIMALES , @TEXTO AS TEXTO , @LISTA AS LISTA , 
@FECHA AS FECHA, @AUTOINCREMENTABLE AS AUTO, @UUID AS UUID, @TOTAL AS TOTAL