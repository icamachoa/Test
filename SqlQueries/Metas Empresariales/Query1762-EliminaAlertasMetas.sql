//[idusarioalerta|Text,session.db|Untyped,]
--UPDATE
DECLARE @IDUSUARIOALERTA VARCHAR(MAX)
SET @IDUSUARIOALERTA =ISNULL(:IDUSARIOALERTA,'')

UPDATE UA SET UA.LEIDO=1, UA.NOTIFICADO=1
FROM SALESUP_CT.DBO.SPLIT(@IDUSUARIOALERTA,',') UALERT
JOIN <#SESSION.DB/>.DBO.USUARIOS_ALERTAS UA ON UA.IDUSUARIOALERTA= UALERT.SPLITVALUE