//[session.db|Untyped,session.idempresa|Untyped,vizualizaren|Text,]
--SELECT 
DECLARE @VizualizarEn VARCHAR(MAX)
SET  @VizualizarEn=ISNULL(:VizualizarEn,'')

SELECT NOMBRE_CAMPO, @VizualizarEn AS VizualizarEn,
CASE 
WHEN TIPO IN (1,3) THEN CAST(INDICE AS VARCHAR(MAX)) + 'P'
WHEN TIPO IN (2,4) THEN CAST(INDICE AS VARCHAR(MAX)) + 'O'
END AS INDICE, INDICE AS INDICEAUX,
TIPO, COMPARTIR,
CASE WHEN INDICE IN (9,10,11,12) THEN 'FormatDate' ELSE '' END EsFecha,
TIPO_CAMPO AS TipoCampo, 
CASE TIPO_CAMPO 
WHEN 9 THEN 'generaGrafica'
WHEN 6 THEN 'generaTemperatura'
WHEN 7 THEN 'tdListaChecks'
WHEN 8 THEN 'tdListaRadio'
WHEN 3 THEN 'tdListaTexto'
ELSE ''
END AS claseAdicional
FROM <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS 
WHERE 
IDEMPRESA = <#SESSION.IDEMPRESA/> 
AND INDICE NOT IN (21,22,23,24,25)
AND (TIPO IN (SELECT  SPLITVALUE FROM <#SESSION.DB/>.DBO.SPLIT(@VizualizarEn,',')) OR COMPARTIR IN (SELECT  SPLITVALUE FROM <#SESSION.DB/>.DBO.SPLIT(@VizualizarEn,',')))
ORDER BY LLAVE DESC, NOMBRE_CAMPO


