//[session.db|Untyped,session.idempresa|Untyped,tipo|Integer,]
--SELECT
/*PROTEGIDO*/
/*SEP2015*/
SELECT IDRAZONPERDIDA,RAZONPERDIDA, SALESUP_CT.dbo.esCanalizado(TK, TKM) AS esCanalizado FROM <#SESSION.DB/>.DBO.EMPRESAS_RAZONES_PERDIDA
WHERE IDEMPRESA=<#SESSION.IDEMPRESA/> AND TIPO =ISNULL(:TIPO,0)
ORDER BY IDRAZONPERDIDA DESC