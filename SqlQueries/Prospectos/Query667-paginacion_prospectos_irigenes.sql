//[session.db|Untyped,session.idempresa|Untyped,filtroagrupardetalle|Integer,]
--SELECT 
/*PROTEGIDO*/


DECLARE @FILTROAGRUPARDETALLE INT 

SET @FILTROAGRUPARDETALLE=ISNULL(:FILTROAGRUPARDETALLE, 0)

SELECT count(*) as totaln, @FILTROAGRUPARDETALLE AS FILTROAGRUPARDETALLE
 FROM <#SESSION.DB/>.dbo.PROSPECTOS_ORIGENES 
WHERE IDEMPRESA = <#SESSION.IDEMPRESA/>
