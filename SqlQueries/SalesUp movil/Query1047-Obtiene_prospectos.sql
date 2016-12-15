//[bd|Text,fecha|Text,idusuario|Text,]
-- select
declare @sql varchar(max)
DECLARE @BD VARCHAR(512)
DECLARE @EXECSQL VARCHAR(8000)
DECLARE @YASINCRONIZADO INT
DECLARE @FECHA VARCHAR(MAX)
DECLARE @IDUSUARIO VARCHAR(MAX)
DECLARE @FECHA2 DATETIME
SET @IDUSUARIO = ISNULL(:IDUSUARIO,'')

SET @BD = isnull(:BD,'')

SET @FECHA = isnull(:FECHA,'')
SET @FECHA2 = CONVERT(DATETIME,isnull(:FECHA,''),20)

IF(@FECHA2 = 0) 
BEGIN
	SET @YASINCRONIZADO = 0
END 
ELSE 
BEGIN 
	SET @YASINCRONIZADO = 1
END 

SET @SQL='
SELECT ISNULL(CONVERT(VARCHAR,P.ULTIMAMODIFICACION,20),'''') AS MODIF, ISNULL(CONVERT(VARCHAR,FECHACONTACTO,20),'''') AS FECHACONTACTO,ISNULL(CONVERT(VARCHAR,P.FECHAHORA,20),'''') AS FECHAHORA, ISNULL(CONVERT(VARCHAR,DESCARTADOFECHA,20),'''') AS DESCARTADOFECHA, A.IDUSUARIO AS ASIGNADO,
CONVERT(VARCHAR,FECHA_ULTIMOSEGUIMIENTO,20) AS FECHA_ULTIMOSEGUIMIENTOS, ISNULL(A.ARCHIVADO,0) AS ARCHIVA, P.IDPROSPECTO,P.IDEMPRESA,SALESUP_CT.DBO.PreparaCadenaApp2(NOMBRE) as NOMBRE,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(APELLIDOS,'''')) as APELLIDOS,ISNULL(TITULO,'''')  AS TITULO,ISNULL(SEXO,'''') AS SEXO,ISNULL(CORREO,'''') AS CORREO,
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(EMPRESA,'''')) AS EMPRESA,ISNULL(NOEMPLEADOS,'''') AS NOEMPLEADOS,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(PUESTO,'''')) as PUESTO,ISNULL(URL,'''') AS URL,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(TELEFONO,'''')) AS TELEFONO,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(TELEFONO2,'''')) AS TELEFONO2,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(MOVIL,'''')) AS MOVIL,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(COMENTARIOS,'''')) AS COMENTARIOS,IDPAIS,IDESTADO,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(DIRECCION1,'''')) as DIRECCION1,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(DIRECCION2,'''')) as DIRECCION2,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CIUDAD,'''')) as CIUDAD,ISNULL(CODIGOPOSTAL,'''')CODIGOPOSTAL,IDORIGEN,ISNULL(SITIO_CAPTURA,'''') SITIO_CAPTURA ,IDFASE,P.IDUSUARIO,ESOPORTUNIDAD,ESCLIENTE,DESCARTADO,DESCARTADOPOR,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(DESCARTADORAZON,'''')) as DESCARTADORAZON,IDULTIMOSEGUIMIENTO, 
ISNULL(CAMPO1,'''') AS CAMPO1,ISNULL(CAMPO2,'''') AS CAMPO2,ISNULL(CAMPO3,'''') AS CAMPO3,ISNULL(CAMPO4,'''') AS CAMPO4,ISNULL(CAMPO5,'''') AS CAMPO5,ISNULL(CAMPO6,'''') AS CAMPO6,ISNULL(CAMPO7,'''') AS CAMPO7,ISNULL(CAMPO8,'''') AS CAMPO8,CONVERT(VARCHAR,CAMPO9,20) as CAMPO9,CONVERT(VARCHAR,CAMPO10,20) as CAMPO10,CONVERT(VARCHAR,CAMPO11,20) as CAMPO11,CONVERT(VARCHAR,CAMPO12,20) as CAMPO12, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO13,'''')) as CAMPO13,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO14,'''')) as CAMPO14,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO15,'''')) as CAMPO15,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO16,'''')) as CAMPO16,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO17,'''')) as CAMPO17,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO18,'''')) as CAMPO18,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO19,'''')) as CAMPO19,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO20,'''')) as CAMPO20, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO21,'''')) as CAMPO21,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO22,'''')) as CAMPO22,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO23,'''')) as CAMPO23,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO24,'''')) as CAMPO24,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO25,'''')) as CAMPO25, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO26,'''')) as CAMPO26,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO27,'''')) as CAMPO27,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO28,'''')) as CAMPO28,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO29,'''')) as CAMPO29,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO30,'''')) as CAMPO30,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO31,'''')) as CAMPO31,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO32,'''')) as CAMPO32,
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO33,'''')) as CAMPO33,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO34,'''')) as CAMPO34, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO35,'''')) as CAMPO35, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO36,'''')) as CAMPO36, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO37,'''')) as CAMPO37, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO38,'''')) as CAMPO38, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO39,'''')) as CAMPO39, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO40,'''')) as CAMPO40, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO41,'''')) as CAMPO41, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO42,'''')) as CAMPO42,  
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO43,'''')) as CAMPO43, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO44,'''')) as CAMPO44, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO45,'''')) as CAMPO45, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO46,'''')) as CAMPO46, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO47,'''')) as CAMPO47, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO48,'''')) as CAMPO48, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO49,'''')) as CAMPO49, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO50,'''')) as CAMPO50, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO51,'''')) as CAMPO51, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO52,'''')) as CAMPO52, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO53,'''')) as CAMPO53, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO54,'''')) as CAMPO54, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO55,'''')) as CAMPO55, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO56,'''')) as CAMPO56, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO57,'''')) as CAMPO57, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO58,'''')) as CAMPO58, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO59,'''')) as CAMPO59, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO60,'''')) as CAMPO60, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO61,'''')) as CAMPO61, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO62,'''')) as CAMPO62, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO63,'''')) as CAMPO63, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO64,'''')) as CAMPO64,
IDCOMPANIA,IDINDUSTRIA,ISNULL(TELEFONOCORPORATIVO,'''')TELEFONOCORPORATIVO,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(FACEBOOK,'''')) as FACEBOOK,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(TWITTER,'''')) as TWITTER,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(SKYPE,'''')) as SKYPE,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(LINKEDIN,'''')) as LINKEDIN,  
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(GOOGLEPLUS,'''')) as GOOGLEPLUS,IDCOMPANIAGRUPO,
IDCATALOGOOPCION1, IDCATALOGOOPCION2,IDCATALOGOOPCION3,TKP,TKPM
FROM '+@BD+'.dbo.PROSPECTOS P WITH (NOLOCK), '+@BD+'.dbo.PROSPECTOS_ASIGNADOS A WITH (NOLOCK) WHERE A.IDUSUARIO = CAST('+@IDUSUARIO+' AS INT) AND P.IDPROSPECTO = A.IDPROSPECTO AND (P.DESCARTADO = 0 OR (P.DESCARTADOFECHA >= CONVERT(DATETIME,'''+@FECHA+''',20) AND '+CAST(@YASINCRONIZADO AS VARCHAR(1000))+' > 0)) AND P.IDULTIMOSEGUIMIENTO IS NOT NULL 
AND P.ULTIMAMODIFICACION >= CONVERT(DATETIME,'''+@FECHA+''',20)
UNION ALL 
SELECT CONVERT(VARCHAR,E.FECHAHORA,20) AS MODIF,CONVERT(VARCHAR,FECHACONTACTO,20) AS FECHACONTACTO,CONVERT(VARCHAR,P.FECHAHORA,20) AS FECHAHORA, CONVERT(VARCHAR,DESCARTADOFECHA,20) AS DESCARTADOFECHA, 0 AS ASIGNADO,
CONVERT(VARCHAR,FECHA_ULTIMOSEGUIMIENTO,20) AS FECHA_ULTIMOSEGUIMIENTOS, 0 AS ARCHIVA, P.IDPROSPECTO,P.IDEMPRESA,SALESUP_CT.DBO.PreparaCadenaApp2(NOMBRE) as NOMBRE,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(APELLIDOS,'''')) as APELLIDOS,ISNULL(TITULO,''''),ISNULL(SEXO,''''),ISNULL(CORREO,''''),SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(EMPRESA,'''')) AS EMPRESA,ISNULL(NOEMPLEADOS,''''),SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(PUESTO,'''')) as PUESTO,ISNULL(URL,''''),SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(TELEFONO,'''')) AS TELEFONO,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(TELEFONO2,'''')) AS TELEFONO2,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(MOVIL,'''')) AS MOVIL,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(COMENTARIOS,'''')) AS COMENTARIOS,IDPAIS,IDESTADO,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(DIRECCION1,'''')) as DIRECCION1,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(DIRECCION2,'''')) as DIRECCION2,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CIUDAD,'''')) as CIUDAD,ISNULL(CODIGOPOSTAL,''''),IDORIGEN,ISNULL(SITIO_CAPTURA,'''') SITIO_CAPTURA,IDFASE,P.IDUSUARIO,ESOPORTUNIDAD,ESCLIENTE,DESCARTADO,DESCARTADOPOR,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(DESCARTADORAZON,'''')) as DESCARTADORAZON,IDULTIMOSEGUIMIENTO, 
CAMPO1,CAMPO2,CAMPO3,CAMPO4,CAMPO5,CAMPO6,CAMPO7,CAMPO8,CONVERT(VARCHAR,CAMPO9,20) as CAMPO9,CONVERT(VARCHAR,CAMPO10,20) as CAMPO10,CONVERT(VARCHAR,CAMPO11,20) as CAMPO11,CONVERT(VARCHAR,CAMPO12,20) as CAMPO12, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO13,'''')) as CAMPO13,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO14,'''')) as CAMPO14,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO15,'''')) as CAMPO15,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO16,'''')) as CAMPO16,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO17,'''')) as CAMPO17,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO18,'''')) as CAMPO18,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO19,'''')) as CAMPO19,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO20,'''')) as CAMPO20, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO21,'''')) as CAMPO21,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO22,'''')) as CAMPO22,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO23,'''')) as CAMPO23,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO24,'''')) as CAMPO24,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO25,'''')) as CAMPO25, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO26,'''')) as CAMPO26,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO27,'''')) as CAMPO27,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO28,'''')) as CAMPO28,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO29,'''')) as CAMPO29,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO30,'''')) as CAMPO30,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO31,'''')) as CAMPO31,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO32,'''')) as CAMPO32,
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO33,'''')) as CAMPO33,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO34,'''')) as CAMPO34, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO35,'''')) as CAMPO35, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO36,'''')) as CAMPO36, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO37,'''')) as CAMPO37, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO38,'''')) as CAMPO38, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO39,'''')) as CAMPO39, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO40,'''')) as CAMPO40, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO41,'''')) as CAMPO41, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO42,'''')) as CAMPO42,  
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO43,'''')) as CAMPO43, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO44,'''')) as CAMPO44, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO45,'''')) as CAMPO45, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO46,'''')) as CAMPO46, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO47,'''')) as CAMPO47, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO48,'''')) as CAMPO48, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO49,'''')) as CAMPO49, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO50,'''')) as CAMPO50, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO51,'''')) as CAMPO51, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO52,'''')) as CAMPO52, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO53,'''')) as CAMPO53, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO54,'''')) as CAMPO54, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO55,'''')) as CAMPO55, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO56,'''')) as CAMPO56, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO57,'''')) as CAMPO57, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO58,'''')) as CAMPO58, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO59,'''')) as CAMPO59, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO60,'''')) as CAMPO60, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO61,'''')) as CAMPO61, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO62,'''')) as CAMPO62, 
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO63,'''')) as CAMPO63, SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(CAMPO64,'''')) as CAMPO64,
IDCOMPANIA,IDINDUSTRIA,ISNULL(TELEFONOCORPORATIVO,''''),SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(FACEBOOK,'''')) as FACEBOOK,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(TWITTER,'''')) as TWITTER,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(SKYPE,'''')) as SKYPE,SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(LINKEDIN,'''')) as LINKEDIN,  
SALESUP_CT.DBO.PreparaCadenaApp2(ISNULL(GOOGLEPLUS,'''')) as GOOGLEPLUS,IDCOMPANIAGRUPO,
IDCATALOGOOPCION1, IDCATALOGOOPCION2,IDCATALOGOOPCION3,TKP,TKPM
FROM '+@BD+'.dbo.PROSPECTOS P WITH (NOLOCK), '+@BD+'.dbo.ELIMINACIONES E WITH (NOLOCK) WHERE '+CAST(@YASINCRONIZADO AS VARCHAR(1000))+' > 0 AND E.IDELIMINADO = P.IDPROSPECTO AND E.IDUSUARIO= CAST('+@IDUSUARIO+' AS INT)  AND E.TIPO = 2 
AND E.FECHAHORA >=CONVERT(DATETIME,'''+@FECHA+''',20) ORDER BY 1 ASC
' 
EXEC(@SQL)
