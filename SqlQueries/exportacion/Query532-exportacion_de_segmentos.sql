//[session.db|Untyped,session.idusuario|Untyped,session.idempresa|Untyped,session.sessionid|Untyped,elnivel|Text,]
--UPDATE
DECLARE @SQL VARCHAR(8000)
DECLARE @CAMPOS_PERSONALIZADOS_NOMBRES VARCHAR(MAX)
DECLARE @CAMPOS_PERSONALIZADOS_VALORES VARCHAR(MAX)
declare @FILTRO varchar(MAX)
DECLARE @ELNIVEL VARCHAR(MAX)
SET @FILTRO = ''
SET @ELNIVEL=ISNULL(:ELNIVEL,'')

DECLARE @SERVIDORIP VARCHAR(16)
SET @SERVIDORIP =  REPLACE(@@SERVERNAME,'-','.')


select @FILTRO = <#SESSION.DB/>.DBO.UDF_CONSTRUYE_FILTRO (<#SESSION.IDUSUARIO/>, 5)
SET @CAMPOS_PERSONALIZADOS_NOMBRES  = <#SESSION.DB/>.DBO.ObtieneCamposLlave(<#SESSIOn.IDEMPRESA/>, 1, '<#SESSION.DB/>',1)
SET @CAMPOS_PERSONALIZADOS_VALORES  = <#SESSION.DB/>.DBO.ObtieneCamposLlave(<#SESSIOn.IDEMPRESA/>, 2, '<#SESSION.DB/>',1)
SELECT @SQL = ' bcp " SELECT  ''ID'','' TITULO'' COLLATE DATABASE_DEFAULT , ''NOMBRE'' COLLATE DATABASE_DEFAULT , ''APELLIDOS'' COLLATE DATABASE_DEFAULT ,''CORREO'' COLLATE DATABASE_DEFAULT , ''EMPRESA'' COLLATE DATABASE_DEFAULT , ''NOEMPLEADOS'' COLLATE DATABASE_DEFAULT , '
SELECT @SQL = @SQL + ' ''PUESTO'' COLLATE DATABASE_DEFAULT , ''URL'' COLLATE DATABASE_DEFAULT , ''TELEFONO'' COLLATE DATABASE_DEFAULT , ''TELEFONO2'' COLLATE DATABASE_DEFAULT , ''MOVIL'' COLLATE DATABASE_DEFAULT , ''FECHACONTACTO'' COLLATE DATABASE_DEFAULT , ''COMENTARIOS'' COLLATE DATABASE_DEFAULT ,' 
SELECT @SQL = @SQL + ' ''PAIS'' COLLATE DATABASE_DEFAULT , ''ESTADO'' COLLATE DATABASE_DEFAULT ,''MUNICIPIO'' COLLATE DATABASE_DEFAULT ,''DIRECCION1'' COLLATE DATABASE_DEFAULT , ''DIRECCION2'' COLLATE DATABASE_DEFAULT , ''CIUDAD'' COLLATE DATABASE_DEFAULT , ''CODIGOPOSTAL'' COLLATE DATABASE_DEFAULT , ''ORIGEN'' COLLATE DATABASE_DEFAULT , ''FASE'' COLLATE DATABASE_DEFAULT ,' 
SELECT @SQL = @SQL + ' ''EJECUTIVO_NOMBRE'' '+@CAMPOS_PERSONALIZADOS_NOMBRES  + ', ''ETIQUETAS'' '
SELECT @SQL = @SQL + ' " queryout C:\FileRepository\exporta\archivos\segmentos-<#SESSION.SESSIONID/>-1.csv   -c -C"Latin1" -t, -T -S'+ @@servername
exec master..xp_cmdshell @sql
SELECT @SQL = ''
SELECT @SQL = ' bcp  " SELECT P.IDPROSPECTO,TITULO + ''.'', NOMBRE_COM, APELLIDOS_COM, CORREO_COM, EMPRESA_COM, CAST(NOEMPLEADOS AS VARCHAR(10)), PUESTO_COM, URL_COM, TELEFONO_COM, TELEFONO2_COM, MOVIL, CAST(FECHACONTACTO AS VARCHAR(12)), COMMENTARIOS_MINI, PAIS, ESTADO,MUNICIPIO,DIRECCION1_COM, DIRECCION2_COM, CIUDAD_COM, CODIGOPOSTAL, ORIGEN, FASE, U.NOMBRE + '' '' + U.APELLIDOS AS EJECUTIVO_NOMBRE '+ @CAMPOS_PERSONALIZADOS_VALORES+'  , <#SESSION.DB/>.DBO.ObtiqueEtiquetasProspecto(P.IDPROSPECTO) FROM <#SESSION.DB/>.DBO.V_PROSPECTOS P WITH(NOLOCK) , <#SESSION.DB/>.DBO.USUARIOS U WITH(NOLOCK) WHERE P.IDEMPRESA = <#SESSIOn.IDEMPRESA/> AND U.IDUSUARIO = P.IDUSUARIO  AND DESCARTADO = 0 '+@ELNIVEL+' '+ @FILTRO+ ' " queryout C:\FileRepository\exporta\archivos\segmentos-<#SESSION.SESSIONID/>-2.csv   -c -C"Latin1" -t, -T -S'+ @@servername
--select @sql
exec master..xp_cmdshell @sql
SET @SQL =  'copy C:\FileRepository\exporta\archivos\segmentos-<#SESSION.SESSIONID/>-1.csv +  C:\FileRepository\exporta\archivos\segmentos-<#SESSION.SESSIONID/>-2.csv C:\FileRepository\exporta\archivos\segmentos-<#SESSION.SESSIONID/>.csv' 
exec master..xp_cmdshell @SQL 


