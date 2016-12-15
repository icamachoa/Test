//[buscar|Text,session.db|Untyped,session.idusuario|Untyped,directorio|Text,mostrar|Text,orden1|Text,orden2|Text,session.idempresa|Untyped,]
--SELECT
declare @SQL VARCHAR(MAX)
DECLARE @IDGRUPO INT
DECLARE @NIVEL INT
DECLARE @BUSCAR VARCHAR(MAX)
DECLARE @DIRECTORIO VARCHAR(MAX)
DECLARE @MOSTRAR VARCHAR(MAX)
DECLARE @ORDEN1 VARCHAR(MAX)
DECLARE @ORDEN2 VARCHAR(MAX)
SET @BUSCAR = ISNULL(:BUSCAR,'')
SELECT @IDGRUPO=IDGRUPO, @NIVEL=NIVEL FROM <#SESSION.DB/>.DBO.USUARIOS WHERE IDUSUARIO=<#SESSION.IDUSUARIO/>
SET @DIRECTORIO= ISNULL(:DIRECTORIO,'')
SET @MOSTRAR =ISNULL(:MOSTRAR,'')
SET @ORDEN1= ISNULL(:ORDEN1,'')
SET @ORDEN2= ISNULL(:ORDEN2,'')


SET @SQL='
DECLARE @BUSCAR VARCHAR(MAX)
DECLARE @NIVEL INT
DECLARE @DIRECTORIO VARCHAR(MAX)
DECLARE @IDGRUPO INT
SET @IDGRUPO ='+CAST(@IDGRUPO AS VARCHAR(1000))+'
SET @BUSCAR='''+@BUSCAR+'''
SET @DIRECTORIO= '''+@DIRECTORIO+'''
SET @NIVEL='+CAST(@NIVEL AS VARCHAR(1000))+'

IF (@NIVEL=1)
BEGIN
SELECT 
P.TKP,
  P.IDPROSPECTO,
  P.IDEMPRESA,
  P.NOMBRE,
  P.APELLIDOS,
  P.EMPRESA,
  P.CORREO,
  P.TITULO,
  P.SEXO,
  P.TELEFONO, 
  P.IDPAIS,
  P.IDESTADO,
  PAI.PAIS,
  E.ESTADO,P.ESCLIENTE,P.IDUSUARIO, ISNULL(P.IDCOMPANIA,0) AS IDCOMPANIA,C.TKCOM,U.INICIALES,U.NOMBRE AS NOMBREUSR, U.APELLIDOS AS APELLIDOSUSR
  ,(CASE WHEN (SELECT COUNT(*) FROM <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS PA WHERE PA.IDPROSPECTO=P.IDPROSPECTO)> 1 THEN 1 ELSE 0 END) AS COMPARTIDO
  FROM <#SESSION.DB/>.dbo.USUARIOS U,<#SESSION.DB/>.dbo.PROSPECTOS P
  LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS C ON P.IDCOMPANIA=C.IDCOMPANIA
  LEFT JOIN <#SESSION.DB/>.dbo.PAISES PAI ON PAI.IDPAIS=P.IDPAIS
  LEFT JOIN <#SESSION.DB/>.dbo.ESTADOS E ON PAI.IDPAIS=E.IDPAIS AND E.IDESTADO=P.IDESTADO
  WHERE U.IDUSUARIO=P.IDUSUARIO AND P.IDEMPRESA=<#SESSION.IDEMPRESA/>  
  AND P.NOMBRE LIKE @DIRECTORIO+''%''
   '+@MOSTRAR+'
  and (P.NOMBRE LIKE ''%''+@BUSCAR+''%'' OR P.APELLIDOS LIKE ''%''+@BUSCAR+''%'' OR P.CORREO LIKE ''%''+@BUSCAR+''%'' )
  ORDER BY '+@ORDEN1+' '+@ORDEN2+'
END

IF @NIVEL=2
BEGIN
SELECT 
  P.TKP,
  P.IDPROSPECTO,
  P.IDEMPRESA,
  P.NOMBRE,
  P.APELLIDOS,
  P.EMPRESA,
  P.CORREO,
  P.TITULO,
  P.SEXO,
  P.TELEFONO, 
  P.IDPAIS,
  P.IDESTADO,
  PAI.PAIS,
  E.ESTADO,P.ESCLIENTE,P.IDUSUARIO, ISNULL(P.IDCOMPANIA,0) AS IDCOMPANIA,C.TKCOM,U.INICIALES,U.NOMBRE AS NOMBREUSR, U.APELLIDOS AS APELLIDOSUSR
   ,(CASE WHEN (SELECT COUNT(*) FROM <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS PA WHERE PA.IDPROSPECTO=P.IDPROSPECTO)> 1 THEN 1 ELSE 0 END) AS COMPARTIDO
  FROM <#SESSION.DB/>.dbo.USUARIOS U,<#SESSION.DB/>.dbo.PROSPECTOS P
  LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS C ON P.IDCOMPANIA=C.IDCOMPANIA
  LEFT JOIN <#SESSION.DB/>.dbo.PAISES PAI ON PAI.IDPAIS=P.IDPAIS
  LEFT JOIN <#SESSION.DB/>.dbo.ESTADOS E ON PAI.IDPAIS=E.IDPAIS AND E.IDESTADO=P.IDESTADO
  WHERE P.IDEMPRESA=<#SESSION.IDEMPRESA/>  
  AND U.IDUSUARIO=P.IDUSUARIO AND U.IDGRUPO=@IDGRUPO
  AND P.NOMBRE LIKE @DIRECTORIO+''%''
   '+@MOSTRAR+'
  and (P.NOMBRE LIKE ''%''+@BUSCAR+''%'' OR P.APELLIDOS LIKE ''%''+@BUSCAR+''%'' OR P.CORREO LIKE ''%''+@BUSCAR+''%'' )
  ORDER BY '+@ORDEN1+' '+@ORDEN2+'
END
 
IF @NIVEL=3
BEGIN
SELECT 
  P.TKP,	   
  P.IDPROSPECTO,
  P.IDEMPRESA,
  P.NOMBRE,
  P.APELLIDOS,
  P.EMPRESA,
  P.CORREO,
  P.TITULO,
  P.SEXO,
  P.TELEFONO, 
  P.IDPAIS,
  P.IDESTADO,
  PAI.PAIS,
  E.ESTADO,P.ESCLIENTE,P.IDUSUARIO, ISNULL(P.IDCOMPANIA,0) AS IDCOMPANIA,U.INICIALES,C.TKCOM,U.NOMBRE AS NOMBREUSR, U.APELLIDOS AS APELLIDOSUSR
   ,(CASE WHEN (SELECT COUNT(*) FROM <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS PA WHERE PA.IDPROSPECTO=P.IDPROSPECTO)> 1 THEN 1 ELSE 0 END) AS COMPARTIDO
  FROM <#SESSION.DB/>.dbo.USUARIOS U,<#SESSION.DB/>.dbo.PROSPECTOS P
  LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS C ON P.IDCOMPANIA=C.IDCOMPANIA
  LEFT JOIN <#SESSION.DB/>.dbo.PAISES PAI ON PAI.IDPAIS=P.IDPAIS
  LEFT JOIN <#SESSION.DB/>.dbo.ESTADOS E ON PAI.IDPAIS=E.IDPAIS AND E.IDESTADO=P.IDESTADO
  WHERE P.IDEMPRESA=<#SESSION.IDEMPRESA/> 
  AND U.IDUSUARIO=P.IDUSUARIO AND p.IDUSUARIO=<#SESSION.IDUSUARIO/>
  AND P.NOMBRE LIKE @DIRECTORIO+''%''
   '+@MOSTRAR+'
  and (P.NOMBRE LIKE ''%''+@BUSCAR+''%'' OR P.APELLIDOS LIKE ''%''+@BUSCAR+''%'' OR P.CORREO LIKE ''%''+@BUSCAR+''%'' )
  ORDER BY '+@ORDEN1+' '+@ORDEN2+'
END
'

EXEC (@SQL)