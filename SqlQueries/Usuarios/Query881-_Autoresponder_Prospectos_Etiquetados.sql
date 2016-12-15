//[idautoresponder|Integer,idetiqueta|Integer,session.idempresa|Untyped,ejecutivo|Integer,buscar|Text,tk|Text,session.db|Untyped,tkauto|Text,]
DECLARE @IDAUTORESPONDER INT
DECLARE @IDEMPRESA INT
DECLARE @IDETIQUETA INT 
DECLARE @IDUSUARIO INT
DECLARE @BUSCAR VARCHAR(256)
DECLARE @TK VARCHAR(128)
DECLARE @TKAUTO VARCHAR(128)
DECLARE @FILTROTEXTO VARCHAR(MAX)
DECLARE @FILTROUSUARIO VARCHAR(MAX)
DECLARE @SQL VARCHAR(MAX)

SET @IDAUTORESPONDER = ISNULL(:IDAUTORESPONDER,0)
SET @IDETIQUETA = ISNULL(:IDETIQUETA,0)
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = ISNULL(:EJECUTIVO, 0)
SET @BUSCAR = ISNULL(:BUSCAR, '')

SET @FILTROTEXTO = (CASE WHEN  ISNULL(@BUSCAR,'')!='' THEN ' AND (P.CORREO LIKE ''%''+'''+@BUSCAR+'''+''%'' OR P.NOMBRE LIKE ''%''+'''+@BUSCAR+'''+''%'' OR P.APELLIDOS LIKE ''%''+'''+@BUSCAR+'''+''%'' OR P.EMPRESA LIKE ''%''+'''+@BUSCAR+'''+''%'' OR INICIALES LIKE ''%''+'''+@BUSCAR+'''+''%'')' ELSE '' END)
SET @FILTROUSUARIO = (CASE WHEN @IDUSUARIO!=0 THEN' AND P.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000)) ELSE '' END)

SET @TK = ISNULL(:TK,'')
IF @TK != '' BEGIN SELECT @IDETIQUETA=IDETIQUETA FROM <#SESSION.DB/>.DBO.ETIQUETAS WHERE TK = @TK AND IDEMPRESA = <#SESSION.IDEMPRESA/> END

SET @TKAUTO = ISNULL(:TKAUTO,'')
IF @TKAUTO != '' BEGIN SELECT @IDAUTORESPONDER=IDAUTORESPONDER FROM <#SESSION.DB/>.DBO.AUTORESPONDERS WHERE CAST(TKAUTO AS VARCHAR(128))  = @TKAUTO AND IDEMPRESA = <#SESSION.IDEMPRESA/> END


SET @SQL='
SELECT P.IDPROSPECTO,CAST(P.TKP AS VARCHAR(128)) AS TKP,  P.NOMBRE +'' ''+ ISNULL(P.APELLIDOS, '''') AS PROSPECTO, P.CORREO, <#SESSION.DB/>.DBO.ValidaEmail(P.CORREO) AS ESCORREO,
P.EMPRESA, P.ESCLIENTE, ETIQUETA, INICIALES , MAILCONFIG AS MAILCONFIGURADO , PE.PAUSADO
FROM <#SESSION.DB/>.DBO.AUTORESPONDERS AR , <#SESSION.DB/>.DBO.ETIQUETAS E 
JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS PE ON PE.IDETIQUETA = '+CAST(@IDETIQUETA AS VARCHAR(1000))+'
JOIN <#SESSION.DB/>.DBO.PROSPECTOS P ON PE.IDPROSPECTO = P.IDPROSPECTO
JOIN <#SESSION.DB/>.DBO.USUARIOS U ON P.IDUSUARIO = U.IDUSUARIO 
WHERE E.IDETIQUETA = '+CAST(@IDETIQUETA AS VARCHAR(1000))+' AND AR.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(1000))+'  AND AR.IDAUTORESPONDER = '+CAST(@IDAUTORESPONDER AS VARCHAR(1000))+' AND P.CORREO != '''' AND P.CORREO IS NOT NULL 
'+@FILTROTEXTO+'
'+@FILTROUSUARIO+'
ORDER BY FECHAETIQUETADO DESC
'
EXEC (@SQL)
