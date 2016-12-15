//[tkrs|Text,session.idusuario|Untyped,session.db|Untyped,]
DECLARE @TKRS VARCHAR(MAX)
DECLARE @IDREPORTE INT, @IDUSUARIO INT 

SET @TKRS = ISNULL(:TKRS, '')
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>

SELECT @IDREPORTE = IDREPORTE 
FROM SALESUP_CT.DBO.REPORTES_SISTEMA 
WHERE TKRS = @TKRS

SELECT URFA.IDREPORTEVARIANTE*-1 as variante, URFA.IDFILTRO AS criterio, URFA.valor, URFA.filtro, CAST(URFA.TKURFA AS VARCHAR(MAX)) AS tk, OPERADOR_LOGICO as operador
FROM <#SESSION.DB/>.DBO.USUARIOS_REPORTES_VARIANTES URV
JOIN <#SESSION.DB/>.DBO.USUARIOS_REPORTES_FILTROS_ADICIONALES URFA ON URFA.IDREPORTEVARIANTE = URV.IDREPORTEVARIANTE
WHERE URV.IDREPORTE = @IDREPORTE


