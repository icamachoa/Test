//[session.db|Untyped,nombre|Text,idusuario|Integer,etiquetas|Integer,session.idempresa|Untyped,esprospecto|Integer,esoportunidad|Integer,escliente|Integer]
--SELECT 
DECLARE @IDULTIMO INT

INSERT INTO <#SESSION.DB/>.DBO.AUTORESPONDERS (TITULO, IDUSUARIO, IDETIQUETA, ESTADO, IDEMPRESA, ESPROSPECTO, ESOPORTUNIDAD, ESCLIENTE) 
VALUES (:NOMBRE,ISNULL(:IDUSUARIO,0),ISNULL(:ETIQUETAS,0),0,<#SESSION.IDEMPRESA/>, ISNULL(:ESPROSPECTO,0), ISNULL(:ESOPORTUNIDAD,0),ISNULL(:ESCLIENTE,0))
--SELECT

-- SELECT TOP 1 @IDULTIMO = IDAUTORESPONDER FROM <#SESSION.DB/>.DBO.AUTORESPONDERS WHERE IDEMPRESA=<#SESSION.IDEMPRESA/> ORDER BY 1 DESC 

-- SELECT A.IDAUTORESPONDER, A.TITULO,A.IDETIQUETA,CAST(TKAUTO AS VARCHAR(256)) AS TKAUTO, CAST(E.TK AS VARCHAR(256)) AS TK
-- FROM <#SESSION.DB/>.DBO.AUTORESPONDERS A
-- LEFT JOIN <#SESSION.DB/>.DBO.ETIQUETAS E ON E.IDETIQUETA=A.IDETIQUETA
-- WHERE IDAUTORESPONDER = @IDULTIMO

