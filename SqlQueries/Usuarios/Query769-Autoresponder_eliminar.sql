//[idautoresponder|Integer,session.db|Untyped,tkauto|Text,session.idempresa|Untyped,]
--DELETE
DECLARE @IDAUTORESPONDER INT
DECLARE @TKAUTO VARCHAR(128)

SET @IDAUTORESPONDER = ISNULL(:IDAUTORESPONDER,0)


SET @TKAUTO = ISNULL(:TKAUTO,'')
IF @TKAUTO != '' BEGIN SELECT @IDAUTORESPONDER=IDAUTORESPONDER FROM <#SESSION.DB/>.DBO.AUTORESPONDERS WHERE CAST(TKAUTO AS VARCHAR(128))  = @TKAUTO AND IDEMPRESA = <#SESSION.IDEMPRESA/> END

UPDATE <#SESSION.DB/>.DBO.USUARIOS_EMAILS SET IDPIEZA = NULL , IDAUTORESPONDER = NULL WHERE IDAUTORESPONDER = @IDAUTORESPONDER AND IDPIEZA IN (SELECT IDPIEZA FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS WHERE IDAUTORESPONDER = @IDAUTORESPONDER)
DELETE FROM <#SESSION.DB/>.dbo.AUTORESPONDERS_CONTROL WHERE IDPIEZA IN (SELECT IDPIEZA FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS WHERE IDAUTORESPONDER = @IDAUTORESPONDER)

DELETE FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS WHERE IDAUTORESPONDER = @IDAUTORESPONDER
DELETE FROM <#SESSION.DB/>.DBO.AUTORESPONDERS WHERE IDAUTORESPONDER = @IDAUTORESPONDER
