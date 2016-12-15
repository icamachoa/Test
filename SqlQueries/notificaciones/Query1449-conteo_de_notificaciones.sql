//[session.db|Untyped,session.idusuario|Untyped,crit|Text,]
-- select 
DECLARE @CRIT VARCHAR(MAX)
SET @CRIT = ISNULL( :CRIT , '')
SELECT COUNT (*) AS   totaln ,@CRIT AS CRIT 
FROM
 <#SESSION.DB/>.DBO.USUARIOS_ALERTAS A WITH(NOLOCK)
 JOIN <#SESSION.DB/>.DBO.USUARIOS_SUCESOS S WITH(NOLOCK) ON S.IDSUCESO =  A.IDSUCESO
 JOIN SALESUP_CT.dbo.TIPOS_SUCESOS T WITH(NOLOCK) ON T.IDSUCESO = S.TIPO
 LEFT JOIN <#SESSION.DB/>.DBO.TAREAS TR WITH(NOLOCK) ON TR.IDTAREA = S.IDTAREA
 LEFT JOIN <#SESSION.DB/>.DBO.CITAS C WITH(NOLOCK) ON C.IDCITA = S.IDCITA
WHERE A.IDUSUARIO=<#SESSION.IDUSUARIO> AND A.LEIDO = 0 AND ISNULL(ALERTA, '') !='' AND S.IDMETA IS NULL