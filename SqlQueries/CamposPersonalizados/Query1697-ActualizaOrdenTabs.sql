//[session.idempresa|Untyped,idtabs|Text,orden|Text,session.db|Untyped,]
--UPDATE

DECLARE @IDEMPRESA AS INT
DECLARE @LTTABS VARCHAR(MAX)
DECLARE @LTORDEN VARCHAR(MAX)

SET @IDEMPRESA =CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @LTTABS = ISNULL(:IDTABS,'') 
SET @LTORDEN =ISNULL(:ORDEN,'')

UPDATE ET SET ET.ORDEN = O.SPLITVALUE
FROM SALESUP_CT.DBO.SPLIT(@LTTABS,',') TAB
LEFT JOIN SALESUP_CT.DBO.SPLIT(@LTORDEN,',') O ON TAB.OCCURENCEID = O.OCCURENCEID
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_TABS ET ON ET.IDEMPRESA = @IDEMPRESA AND ET.IDTAB = TAB.SPLITVALUE
