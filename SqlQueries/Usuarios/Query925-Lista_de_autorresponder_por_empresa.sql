//[session.db|Untyped,session.idempresa|Untyped,idautoresponderactual|Integer,]
SELECT IDAUTORESPONDER, TITULO FROM <#SESSION.DB/>.DBO.AUTORESPONDERS WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> AND IDAUTORESPONDER <> :IdAutoResponderActual