//[condicion|Text,idetiqueta|Integer,idautoresponder|Integer,session.idempresa|Untyped,tk|Text,session.db|Untyped,tkauto|Text,]
--SELECT
/*PROTEGIDOS*/
DECLARE @CONDICION VARCHAR(MAX)
SET @CONDICION = ISNULL(:CONDICION,'')


DECLARE @IDETIQUETA INT, @IDAUTORESPONDER INT, @IDEMPRESA INT
DECLARE @TKAUTO VARCHAR(128)
DECLARE @TK VARCHAR(128)
DECLARE @TKPI VARCHAR(128)
DECLARE @SQL VARCHAR(MAX)

SET @IDETIQUETA = ISNULL(:IDETIQUETA,0)
SET @IDAUTORESPONDER = ISNULL(:IDAUTORESPONDER,0)
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>

SET @TK = ISNULL(:TK,'')
IF @TK != '' BEGIN SELECT @IDETIQUETA=IDETIQUETA FROM <#SESSION.DB/>.DBO.ETIQUETAS WHERE CAST(TK AS VARCHAR(128))  = @TK AND IDEMPRESA =@IDEMPRESA END


SET @TKAUTO = ISNULL(:TKAUTO,'')
IF @TKAUTO != '' BEGIN SELECT @IDAUTORESPONDER=IDAUTORESPONDER FROM <#SESSION.DB/>.DBO.AUTORESPONDERS WHERE CAST(TKAUTO AS VARCHAR(128))  = @TKAUTO AND IDEMPRESA = @IDEMPRESA END



SET @SQL='
SELECT  '+CAST(@IDETIQUETA AS VARCHAR(1000))+' AS IDETIQUETA, '+CAST(@IDAUTORESPONDER AS VARCHAR(1000))+' AS IDAUTORESPONDER, '+CAST(@IDEMPRESA AS VARCHAR(1000))+' AS IDEMPRESA,CAST(AP.TKPI AS VARCHAR(MAX)) AS TKPI, '''+@TK+''' AS TK, '''+@TKAUTO+''' AS TKAUTO,'''+REPLACE(@CONDICION,'''','''''')+''' AS CONDICION,
LEN(CONVERT(VARCHAR(MAX), ISNULL(REPLACE(CONVERT(VARCHAR(MAX), ANEXOS), CHAR(10)+CHAR(13) , ''''),''''))) as TieneAnexos,
AP.TIPOCORREO,
<#SESSION.DB/>.DBO.fnCountChar(ANEXOS,'','') AS TOTALFILES,
AP.IDAUTORESPONDER, AP.IDPIEZA,
(CASE WHEN RTRIM(LTRIM(REPLACE(REPLACE(CAST(AP.anexos AS VARCHAR(max)),CHAR(10),''''),CHAR(13),'''')))='''' THEN '''' ELSE REPLACE(REPLACE(REPLACE(CAST(AP.anexos AS VARCHAR(max)),CHAR(10)+CHAR(10),CHAR(10)),CHAR(10),'',''),CHAR(13),'''')END) as anexos,

 AP.NOMBRE_ARCHIVO, AP.ENVIAR_TIEMPO, AP.ESTADO, AP.ASUNTO , AP.CUERPO, ISNULL(AP.ORDEN,999999999) AS ORDEN,AP.NOMBRE_ARCHIVO_REAL,
AU.IDAUTORESPONDER, AU.IDETIQUETA  ,

    (
       SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_EMAILS WHERE IDAUTORESPONDER = AP.IDAUTORESPONDER AND ESTADO = 1
			AND IDPIEZA IN 
			(
				SELECT IDPIEZA FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_CONTROL WHERE IDPIEZA = AP.IDPIEZA AND IDETIQUETA='+CAST(@IDETIQUETA AS VARCHAR(1000))+'
			)  
    ) AS ENVIADOS,
	(
	   SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_EMAILS WHERE IDAUTORESPONDER = AP.IDAUTORESPONDER AND ESTADO = 0 AND ERRORES > 0
			AND IDPIEZA IN 
			(
				SELECT IDPIEZA FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_CONTROL WHERE IDPIEZA = AP.IDPIEZA AND IDETIQUETA='+CAST(@IDETIQUETA AS VARCHAR(1000))+'
			)
    )AS NOENVIADOS,
    (
	 SELECT COUNT(*) 
	 FROM <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS PE
	 LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS P ON P.IDPROSPECTO = PE.IDPROSPECTO AND DESCARTADO = 0
	 LEFT JOIN <#SESSION.DB/>.DBO.AUTORESPONDERS AU ON AU.IDAUTORESPONDER = '+CAST(@IDAUTORESPONDER AS VARCHAR(MAX))+'
	 WHERE P.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(MAX))+' AND PE.IDETIQUETA = '+CAST(@IDETIQUETA AS VARCHAR(1000))+'
	 AND ( ( AU.ESPROSPECTO = 1 AND P.ESOPORTUNIDAD = 0 AND P.ESCLIENTE = 0) OR (AU.ESOPORTUNIDAD = 1 AND P.ESOPORTUNIDAD = 1) OR (AU.ESCLIENTE= 1 AND P.ESCLIENTE = 1))
	 )AS TOTAL,
	 (CASE 
	 	WHEN TIPOCORREO = 1 THEN
	 	(
		  SELECT COUNT(*)
	      FROM <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS PE
	      LEFT JOIN <#SESSION.DB/>.DBO.AUTORESPONDERS AU ON AU.IDAUTORESPONDER =  '+CAST(@IDAUTORESPONDER AS VARCHAR(MAX))+'
		  LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS P ON P.IDPROSPECTO = PE.IDPROSPECTO AND DESCARTADO = 0 
	    	AND P.IDPROSPECTO NOT IN (SELECT IDPROSPECTO FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_CONTROL WHERE IDPIEZA = AP.IDPIEZA AND IDETIQUETA='+CAST(@IDETIQUETA AS VARCHAR(1000))+')
		  WHERE P.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(MAX))+' AND PE.IDETIQUETA = '+CAST(@IDETIQUETA AS VARCHAR(1000))+'
		  AND ( ( AU.ESPROSPECTO = 1 AND P.ESOPORTUNIDAD = 0 AND P.ESCLIENTE = 0) OR (AU.ESOPORTUNIDAD = 1 AND P.ESOPORTUNIDAD = 1) OR (AU.ESCLIENTE= 1 AND P.ESCLIENTE = 1)) AND CORREO != '''' AND CORREO IS NOT NULL

		 )
		WHEN TIPOCORREO = 2 THEN 
		(
		  SELECT COUNT(*)
	      FROM <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS PE
	      LEFT JOIN <#SESSION.DB/>.DBO.AUTORESPONDERS AU ON AU.IDAUTORESPONDER =  '+CAST(@IDAUTORESPONDER AS VARCHAR(MAX))+'
		  LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS P ON P.IDPROSPECTO = PE.IDPROSPECTO AND DESCARTADO = 0 
	    	AND P.IDPROSPECTO NOT IN (SELECT IDPROSPECTO FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_CONTROL WHERE IDPIEZA = AP.IDPIEZA AND IDETIQUETA='+CAST(@IDETIQUETA AS VARCHAR(1000))+')
		  WHERE P.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(MAX))+' AND PE.IDETIQUETA = '+CAST(@IDETIQUETA AS VARCHAR(1000))+'
		  AND ( ( AU.ESPROSPECTO = 1 AND P.ESOPORTUNIDAD = 0 AND P.ESCLIENTE = 0) OR (AU.ESOPORTUNIDAD = 1 AND P.ESOPORTUNIDAD = 1) OR (AU.ESCLIENTE= 1 AND P.ESCLIENTE = 1)) AND MOVIL != '''' AND MOVIL IS NOT NULL

		 )
	 END) AS RESTAN2
FROM <#SESSION.DB/>.DBO.AUTORESPONDERS_PIEZAS AP
JOIN <#SESSION.DB/>.DBO.AUTORESPONDERS AU ON AP.IDAUTORESPONDER = AU.IDAUTORESPONDER
JOIN <#SESSION.DB/>.DBO.ETIQUETAS ETI ON ETI.IDETIQUETA = AU.IDETIQUETA
WHERE AP.IDAUTORESPONDER =  '+CAST(@IDAUTORESPONDER AS VARCHAR(MAX))+' AND AU.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(MAX))+'  '+@CONDICION+'
ORDER BY ORDEN
'

EXEC (@SQL)