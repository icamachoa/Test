//[session.idempresa|Untyped,session.db|Untyped,]
--SELECT
DECLARE @IDEMPRESA INT
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SELECT 
IDUSUARIOGRUPO AS Id, Grupo, cast(tk as varchar(64)) as tk
FROM 
<#SESSION.DB/>.DBO.USUARIOS_GRUPOS 
WHERE 
IDEMPRESA = @IDEMPRESA