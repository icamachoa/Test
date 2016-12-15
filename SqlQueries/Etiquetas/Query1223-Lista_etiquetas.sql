//[session.idempresa|Untyped,session.db|Untyped,]
--SELECT
DECLARE @IDEMPRESA INT
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SELECT IdEtiqueta, REPLACE(Etiqueta, '"','&quot;') AS Etiqueta , IdEtiqueta as value, REPLACE(Etiqueta, '"','&quot;') as text, 1 as Creado FROM <#SESSION.DB/>.DBO.ETIQUETAS 
WHERE IDEMPRESA = @IDEMPRESA