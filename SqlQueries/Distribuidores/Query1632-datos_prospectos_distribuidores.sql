//[session.idempresa|Untyped,session.idusuario|Untyped,session.mailconfig|Untyped,session.db|Untyped,ordersql|Text,ids|Text,]
--select
DECLARE @DESCARTADOS INT
DECLARE @IDS VARCHAR(MAX)
DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @MAILCONFIG INT
DECLARE @SQL VARCHAR(MAX)
DECLARE @OrderSql VARCHAR(MAX)

SET @IDS = ISNULL(:IDS,'')
SET @IDEMPRESA=CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO=CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @MAILCONFIG = CAST('<#SESSION.MAILCONFIG/>' AS INT )
SET @OrderSql=ISNULL(:OrderSql,'')

SET @SQL ='
SELECT
CAST(S.FECHAHORA AS FLOAT) AS CAMPO1,
CASE '+CAST(@MAILCONFIG AS VARCHAR(1000))+' WHEN 0 THEN ''1'' ELSE '''' END AS NoConfigurado,
CASE '+CAST(@MAILCONFIG AS VARCHAR(1000))+' WHEN 1 THEN ''1'' ELSE '''' END AS EmailConfigurado,
CASE '+CAST(@MAILCONFIG AS VARCHAR(1000))+' WHEN 2 THEN ''1'' ELSE '''' END AS MailTo,
P.PUESTO,ISNULL(F.Fase,'''') AS Fase,P.SEXO,
CASE WHEN P.ESCLIENTE = 1 THEN ''1'' ELSE '''' END AS ESCLIENTE,P.Tkp AS Tkp, 
SALESUP_CT.dbo.esCanalizado(P.TKP, P.TKPM) AS esCanalizado, P.CANALIZADOEL AS FechaCanalizado, SALESUP_CT.dbo.ObtieneHora(P.CANALIZADOEL) AS HoraCanalizado, P.USRCANALIZO as Canalizo, P.USRCANALIZADO AS Canalizado,
P.IDCOMPANIA,C.TKCOM,P.ETIQUETAS_TXT AS ETIQUETAS, CONVERT(VARCHAR(10),P.FECHACONTACTO,103) AS FechaContacto,ISNULL(O.Origen,'''') AS Origen,S.FECHAHORA AS FECHAULTIMOCONTACTO,
(<#SESSION.DB/>.DBO.TIEMPO_TXT (S.FECHAHORA,GETDATE())) AS UltimoContactoTiempo,ISNULL(U1.INICIALES,'''') AS UltimoUsuario, ISNULL(U1.NOMBRE,'''') + '' '' + ISNULL(U1.APELLIDOS,'''') AS UltimoUsuarioNombre,
P.IDPROSPECTO,LTRIM(ISNULL(TELEFONO, '''')) AS TELEFONO, LTRIM(ISNULL(TELEFONO2, '''')) AS TELEFONO2, LTRIM(ISNULL(MOVIL, '''')) AS MOVIL, LTRIM(ISNULL(CORREO, '''')) AS CORREO,
P.NOMBRE + '' '' + ISNULL(P.APELLIDOS,'''') AS NOMBRE, ISNULL(CAST(S.COMENTARIO AS VARCHAR(MAX)),'''')  AS UltimoContacto,  DESCARTADORAZON, 
CASE WHEN DESCARTADO = 1 THEN CAST(DESCARTADO AS VARCHAR) ELSE '''' END AS DESCARTADO, 
P.EMPRESA, U.INICIALES,U.NOMBRE+'' ''+U.APELLIDOS AS EjecutivoNombre,
CASE WHEN <#SESSION.DB/>.DBO.ValidaEmail(ISNULL(P.CORREO,'''')) = ''NO'' THEN ''1'' ELSE '''' END as ESCORREO,
CASE WHEN COUNT(A3.IDPROSPECTO) > 0 THEN ''1'' ELSE '''' END AS Compartido,
LTRIM(P.Facebook) as Facebook, LTRIM(P.Twitter) AS Twitter, LTRIM(P.Skype) AS Skype, LTRIM(P.Linkedin) AS Linkedin, LTRIM(P.Googleplus) AS Googleplus
FROM
<#SESSION.DB/>.dbo.PROSPECTOS P WITH (NOLOCK) 
LEFT JOIN <#SESSION.DB/>.dbo.PROSPECTOS_ORIGENES O ON P.IDORIGEN =O.IDORIGEN
LEFT JOIN <#SESSION.DB/>.dbo.PAISES PAI ON P.IDPAIS =PAI.IDPAIS
LEFT JOIN <#SESSION.DB/>.dbo.ESTADOS ES ON ES.IDPAIS =P.IDPAIS AND ES.IDESTADO = P.IDESTADO
LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS C ON P.IDCOMPANIA =C.IDCOMPANIA 
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO S WITH(NOLOCK) ON P.IDULTIMOSEGUIMIENTO = S.IDSEGUIMIENTO
LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U1 WITH(NOLOCK) ON S.IDUSUARIO = U1.IDUSUARIO  
INNER JOIN <#SESSION.DB/>.dbo.USUARIOS U WITH (NOLOCK) ON P.IDUSUARIO = U.IDUSUARIO
INNER  JOIN <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS A3 WITH (NOLOCK) ON P.IDPROSPECTO = A3.IDPROSPECTO 
JOIN <#SESSION.DB/>.DBO.PROSPECTOS_FASES F WITH(NOLOCK) ON P.IDFASE = F.IDFASE 
LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS COM WITH(NOLOCK) ON COM.IDCOMPANIA = P.IDCOMPANIA
WHERE 
 P.IDPROSPECTO = a3.IDPROSPECTO AND  
 P.IDUSUARIO = U.IDUSUARIO AND P.IDEMPRESA='+CAST(@IDEMPRESA AS VARCHAR(1000))+'
 AND P.IDPROSPECTO IN (SELECT SPLITVALUE FROM <#SESSION.DB/>.DBO.SPLIT('''+@IDS+''','',''))
 GROUP BY
 S.FECHAHORA,
 P.PUESTO,F.FASE,P.SEXO,
P.TKP, P.TKPM,P.CANALIZADOEL , P.CANALIZADOEL,P.USRCANALIZO, P.USRCANALIZADO,
P.IDCOMPANIA,C.TKCOM,P.ETIQUETAS_TXT,P.FECHACONTACTO,O.ORIGEN,
 s.fechahora,U1.INICIALES,ISNULL(U1.NOMBRE,'''') + '' '' + ISNULL(U1.APELLIDOS,''''),
P.IDPROSPECTO,
    LTRIM(ISNULL(TELEFONO, '''')) , LTRIM(ISNULL(TELEFONO2, '''')) , LTRIM(ISNULL(MOVIL, '''')) , LTRIM(ISNULL(CORREO, '''')) ,
P.NOMBRE ,P.APELLIDOS, CAST(S.COMENTARIO AS VARCHAR(MAX)),  DESCARTADORAZON,TELEFONO, MOVIL,TELEFONO2, CORREO, DESCARTADO, P.EMPRESA,P.ESCLIENTE, U.INICIALES,U.NOMBRE+'' ''+U.APELLIDOS ,
P.CORREO,A3.IDPROSPECTO,
P.Facebook, P.Twitter, P.Skype, P.Linkedin, P.Googleplus
'+@OrderSql+'
'
EXEC (@SQL)