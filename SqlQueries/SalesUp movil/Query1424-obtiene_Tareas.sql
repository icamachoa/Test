//[idusuario|Integer,bd|Text,fecha|Text,]
-- select
DECLARE @IDUSUARIO VARCHAR(1000)
DECLARE @SQL VARCHAR(MAX)
DECLARE @FECHA VARCHAR(1000)
DECLARE @BD VARCHAR(1000)
SET @IDUSUARIO = CAST(ISNULL(:IDUSUARIO,0) AS VARCHAR(1000))
SET @FECHA=ISNULL(:FECHA,'')
SET @BD=ISNULL(:BD,'')

SET @SQL='
SELECT FECHA_CREACION, FECHA_VENCIMIENTO,IDESTADO,IDINICIADOR,IDREALIZADOR,IDTAREA, 
IDTAREASEGUIMIENTO, SALESUP_CT.DBO.PreparaCadenaApp2(TITULO) AS TITULO, ISNULL(IDPROSPECTO,0) AS IDPROSPECTO,  
ISNULL(IDOPORTUNIDAD,0) AS IDOPORTUNIDAD, 
MASTIEMPO, FECHA_PROPUESTA 
FROM '+@BD+'.dbo.TAREAS WITH(NOLOCK)  
WHERE (IDREALIZADOR =  '+@IDUSUARIO+' and IDINICIADOR !=  '+@IDUSUARIO+' ) or (IDINICIADOR =  '+@IDUSUARIO+'  and IDREALIZADOR !=  '+@IDUSUARIO+' ) AND ULTIMAMODIFICACION >= CONVERT(DATETIME,'''+@FECHA+''',20) 
'
EXEC (@SQL)