//[session.idempresa|Untyped,session.db|Untyped,]
DECLARE @IDEMPRESA INT
SET @IDEMPRESA= CAST('<#SESSION.IDEMPRESA/>' AS INT)

SELECT LP.TK, LP.IDLISTA_PRECIO, LP.NOMBRE, 'precio'+CAST(LP.INDICE AS VARCHAR(8)) AS INDICE, LP.IDMONEDA, LP.STATUS, LP.INDICE AS INDX,M.IDEMPRESAMONEDA,M.TIPODECAMBIO
FROM <#SESSION.DB/>.DBO.LISTAS_PRECIO LP,<#SESSION.DB/>.DBO.MONEDAS M   
WHERE M.IDEMPRESA=@IDEMPRESA  AND LP.IDEMPRESA=@IDEMPRESA AND LP.IDMONEDA=M.IDMONEDA AND LP.STATUS = 1
