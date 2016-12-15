//[session.idempresa|Untyped,session.db|Untyped,]
--SELECT
DECLARE @IDEMPRESA INT
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SELECT '-'+CAST(C.IDCAMPO AS VARCHAR(MAX)) as IdC, C.ID AS IdHtml, EC.TIPO AS Restriccion, EC.Mostrar , C.Tip
/*,
CASE 
	 WHEN EC.TIPO = 1 THEN 'InfoUnico' 
	 WHEN EC.TIPO = 2 THEN 'InfoObligatorio'
	 WHEN EC.TIPO = 3 THEN 'InfoUnico InfoObligatorio'
	 ELSE '' END AS Res
*/
FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_CONFIGURACION EC , SALESUP_CT.DBO.CAMPOS C
WHERE EC.CAMPO = C.IDCAMPO AND IDEMPRESA = @IDEMPRESA
ORDER BY C.Ocultar DESC