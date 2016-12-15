//[idrep|Integer,session.idempresa|Untyped,session.db|Untyped,]
--SELECT
DECLARE @IDEMPRESA INT 
DECLARE @IDREP INT
SELECT @IDREP = ISNULL(:IDREP,0)

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SELECT IdAgrupacion, Agrupacion ,0, @IDREP  AS IDREP 
FROM <#SESSION.DB/>.dbo.V_AGRUPACIONES 
WHERE (IDEMPRESA = @IDEMPRESA OR IDEMPRESA = 0)
AND ((@IDREP = 0 AND IDREP = 0) OR (@IDREP!= 0 AND  ( IDREP = @IDREP )) OR IDREP = -1)