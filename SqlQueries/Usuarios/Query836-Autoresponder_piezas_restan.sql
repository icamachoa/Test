//[session.idempresa|Untyped,ejecutivo|Integer,buscar|Text,desde|Text,hasta|Text,session.db|Untyped,session.convertcode|Untyped,idautoresponder|Integer,idpieza|Integer,idetiqueta|Integer,tk|Text,tkpi|Text,tkauto|Text,]
DECLARE @IDAUTORESPONDER INT
DECLARE @IDPIEZA INT
DECLARE @IDETIQUETA INT
DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @EJECUTIVO INT
DECLARE @FILTROUSUARIO VARCHAR(MAX)
DECLARE @BUSCAR VARCHAR(MAX)
DECLARE @FILTROTEXTO VARCHAR(MAX)
DECLARE @DESDE VARCHAR(1000)
DECLARE @HASTA VARCHAR(1000)
DECLARE @FILTROFECHAS VARCHAR(1000)
DECLARE @PIESACOND VARCHAR(MAX)
DECLARE @TK VARCHAR(128)
DECLARE @TKPI VARCHAR(128)
DECLARE @TKAUTO VARCHAR(128)
DECLARE @TIPOAUTORESPONDER INT
DECLARE @FILTROAUTORESPONDER VARCHAR(MAX)

DECLARE @SQL VARCHAR(MAX)
SET @SQL=''

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @EJECUTIVO=ISNULL(:EJECUTIVO,0)
SET @FILTROUSUARIO=ISNULL((CASE WHEN @EJECUTIVO!= 0 THEN ' AND P.IDUSUARIO = '+CAST(@EJECUTIVO AS VARCHAR(100)) ELSE '' END),'')
SET @BUSCAR=:BUSCAR
SET @BUSCAR=(CASE WHEN @BUSCAR='UNDEF' THEN '' ELSE @BUSCAR END)
SET @FILTROTEXTO=ISNULL((CASE WHEN @BUSCAR!='' THEN 'AND (U.INICIALES LIKE ''%''+'''+@BUSCAR+'''+''%'' OR P.CORREO LIKE ''%''+'''+@BUSCAR+'''+''%'' OR P.NOMBRE LIKE ''%''+'''+@BUSCAR+'''+''%'' OR P.APELLIDOS LIKE ''%''+'''+@BUSCAR+'''+''%'' OR P.EMPRESA LIKE ''%''+'''+@BUSCAR+'''+''%'')' ELSE '' END),'')
SET @DESDE=:DESDE
SET @HASTA=:HASTA
SET @DESDE=(CASE WHEN @DESDE='UNDEF' THEN '' ELSE @DESDE END)
SET @HASTA=(CASE WHEN @HASTA='UNDEF' THEN '' ELSE @HASTA END)
SET @FILTROFECHAS=ISNULL((CASE WHEN ISNULL(@DESDE,'')!='' AND ISNULL(@HASTA,'')!='' THEN 'AND <#SESSION.DB/>.DBO.GETONLYDATE(PE.FECHAETIQUETADO)  BETWEEN CONVERT(DATETIME,'''+@DESDE+''',<#SESSION.CONVERTCODE/>) AND CONVERT(DATETIME,'''+@HASTA+''',<#SESSION.CONVERTCODE/>)' ELSE '' END ),'')

SET @IDAUTORESPONDER = ISNULL(:IDAUTORESPONDER,0)
SET @IDPIEZA = ISNULL(:IDPIEZA,0)
SET @IDETIQUETA = ISNULL(:IDETIQUETA,0)
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>

SET @TK = ISNULL(:TK,'')
IF @TK != '' BEGIN SELECT @IDETIQUETA=IDETIQUETA FROM <#SESSION.DB/>.DBO.ETIQUETAS WHERE TK = @TK AND IDEMPRESA = <#SESSION.IDEMPRESA/> END

SET @TKPI = ISNULL(:TKPI,'')
IF @TKPI != '' BEGIN SELECT @IDPIEZA=IDPIEZA FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS WHERE CAST(TKPI AS VARCHAR(128))  = @TKPI END

SET @TKAUTO = ISNULL(:TKAUTO,'')
IF @TKAUTO != '' BEGIN SELECT @IDAUTORESPONDER=IDAUTORESPONDER FROM <#SESSION.DB/>.DBO.AUTORESPONDERS WHERE CAST(TKAUTO AS VARCHAR(128))  = @TKAUTO AND IDEMPRESA = <#SESSION.IDEMPRESA/> END

SELECT @TIPOAUTORESPONDER = ISNULL(TIPOCORREO,1) FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS WHERE IDAUTORESPONDER = @IDAUTORESPONDER AND IDPIEZA = @IDPIEZA

SET @FILTROAUTORESPONDER = (CASE 
	WHEN @TIPOAUTORESPONDER = 1 THEN 'AND P.CORREO != '''' AND P.CORREO IS NOT NULL'
	WHEN @TIPOAUTORESPONDER = 2 THEN 'AND P.MOVIL != '''' AND P.MOVIL IS NOT NULL'
END)

SET  @PIESACOND=ISNULL((CASE WHEN @IDPIEZA >0  THEN ' AND AC.IDPIEZA = '+CAST(@IDPIEZA AS VARCHAR(1000)) ELSE ''END),'')

SET @SQL='
SELECT P.NOMBRE, P.APELLIDOS , P.EMPRESA ,P.CORREO , PE.FECHAETIQUETADO, U.INICIALES
FROM <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS PE
LEFT JOIN <#SESSION.DB/>.DBO.AUTORESPONDERS AU ON AU.IDAUTORESPONDER = '+CAST(@IDAUTORESPONDER AS VARCHAR(1000))+'
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS P ON P.IDPROSPECTO = PE.IDPROSPECTO AND DESCARTADO = 0 
	AND P.IDPROSPECTO NOT IN (SELECT IDPROSPECTO FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_CONTROL WHERE IDPIEZA = '+CAST(@IDPIEZA AS VARCHAR(1000))+' AND IDETIQUETA='+CAST(@IDETIQUETA AS VARCHAR(1000))+')
LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U ON P.IDUSUARIO = U.IDUSUARIO
WHERE P.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(1000))+' AND PE.IDETIQUETA = '+CAST(@IDETIQUETA AS VARCHAR(1000))+'
AND ( ( AU.ESPROSPECTO = 1 AND P.ESOPORTUNIDAD = 0 AND P.ESCLIENTE = 0) OR (AU.ESOPORTUNIDAD = 1 AND P.ESOPORTUNIDAD = 1) OR (AU.ESCLIENTE= 1 AND P.ESCLIENTE = 1))
'+@FILTROAUTORESPONDER+'
'+@FILTROUSUARIO+'
'+@FILTROTEXTO+'
'+@FILTROFECHAS+'
ORDER BY PE.FECHAETIQUETADO DESC'
EXEC (@SQL)