//[session.idusuario|Untyped,session.idempresa|Untyped,session.gmt|Untyped,buscar|Text,session.db|Untyped,]
--select
/*protegido*/
DECLARE @IDUSUARIO INT, @GMT INT, @IDEMPRESA INT, @MAXIDINBOX INT
DECLARE @BUSCAR VARCHAR(MAX) 
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @GMT = <#SESSION.GMT/>

SET @BUSCAR = ISNULL(:BUSCAR,'') 
SET @BUSCAR = '%'+@BUSCAR+'%'

SELECT @MAXIDINBOX = max(UI.IDINBOX)
FROM <#SESSION.DB/>.DBO.USUARIOS_INBOX UI,
<#SESSION.DB/>.DBO.USUARIOS U
WHERE U.IDUSUARIO = UI.IDUSUARIO AND U.IDEMPRESA = @IDEMPRESA AND UI.IDUSUARIO = @IDUSUARIO AND UI.ACTIVO = 1

SELECT @MAXIDINBOX AS maxIdInbox, U.NOMBRE+' '+ISNULL(U.APELLIDOS,'')+ ' ('+LTRIM(RTRIM(ISNULL(U.INICIALES,'')))+')'  AS duenio, ISNULL(UI.idColaborador,0) AS idColaborador,
CASE WHEN @IDUSUARIO != ISNULL(PA.IDUSUARIO,0) THEN 1 ELSE 0 END AS noEsTuyo, 
CASE WHEN ISNULL(PA.GUARDAINBOX,0) = 0  THEN 1 ELSE 0 END AS guardaSeguimiento,
ui.tkui,
UI.IdInbox, ISNULL(UI.idInboxMaster,0) AS idInboxMaster, UI.idTabInbox, ISNULL(UI.idSeguimiento,0) AS idSeguimiento, 
 [READ] AS noLeido,

CASE
WHEN ISNULL(UI.IDCOLABORADOR,0) > 0 THEN 1
WHEN ISNULL(UI.IDPROSPECTO,0) > 0 THEN 2
WHEN ISNULL(UI.IDPROSPECTO,0) = 0 AND ISNULL(UI.IDCOLABORADOR,0) = 0 AND ISNULL(UI.FROMNAME,'') != '' 
THEN 3 END as tFrom,

CASE
WHEN ISNULL(UI.IDCOLABORADOR,0) > 0 THEN RTRIM(US.NOMBRE)+' '+ISNULL(LTRIM(US.APELLIDOS),'') + ' ('+LTRIM(RTRIM(US.INICIALES))+')' 
WHEN ISNULL(UI.IDPROSPECTO,0) > 0 THEN RTRIM(P.NOMBRE)+' '+ISNULL(LTRIM(P.APELLIDOS),'')
WHEN ISNULL(UI.IDPROSPECTO,0) = 0 AND ISNULL(UI.IDCOLABORADOR,0) = 0 AND ISNULL(UI.FROMNAME,'') = '' 
THEN (CASE WHEN ISNULL(UI.REPLYTO,'') = '' THEN UI.FROMADDRESS ELSE UI.REPLYTO END)
ELSE UI.FROMNAME
END as De, 

CASE WHEN ISNULL(UI.REPLYTO,'') = '' THEN UI.FROMADDRESS ELSE UI.REPLYTO END as correoDe,
UI.cc, UI.TOADDRESS as Para, UI.toaddresses, CASE WHEN ISNULL(SUBJECT,'') = '' THEN '(Sin asunto)' ELSE SUBJECT END as Asunto,
'' as bodyEmail, CONVERT(VARCHAR(10),SALESUP_CT.dbo.fechaOffSet(@GMT,UI.DATE),103) as Fecha, SALESUP_CT.DBO.OBTIENEHORA(SALESUP_CT.dbo.fechaOffSet(@GMT,UI.DATE)) AS Hora, 
CASE WHEN LEN(UI.ATTACHMENTS)>0 THEN 1 ELSE 0 END AS tieneAdjuntos, UI.ATTACHMENTS as Adjuntos,
RTRIM(P.NOMBRE)+' '+ISNULL(LTRIM(P.APELLIDOS),'') AS Contacto, 
P.Empresa, P.tkp, P.Idprospecto, P.esCliente, P.ETIQUETAS_TXT as etiquetas,
CAST(UI.DATE AS DECIMAL(38,10)) AS dtf, UI.conversaciones, UCC.proveedor, UCC.POP3_USERNAME AS correoEntrante,
cast(year(date) as varchar(4))+'|'+cast(month(date) as varchar(2))+'|'+cast(@IDEMPRESA as varchar(10)) as ciaa
FROM <#SESSION.DB/>.DBO.USUARIOS_INBOX UI WITH(NOLOCK) 
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS PA WITH(NOLOCK) ON PA.IDPROSPECTO = UI.IDPROSPECTO AND PA.IDUSUARIO = @IDUSUARIO AND PA.IDTABINBOX = UI.IDTABINBOX
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS P WITH(NOLOCK) ON P.IDPROSPECTO = UI.IDPROSPECTO AND P.IDEMPRESA = @IDEMPRESA
LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U WITH(NOLOCK) ON U.IDEMPRESA = @IDEMPRESA AND U.IDUSUARIO = P.IDUSUARIO
LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS US WITH(NOLOCK) ON US.IDUSUARIO = UI.IDCOLABORADOR
LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS UCC WITH(NOLOCK) ON UCC.IDUSUARIO = UI.IDUSUARIO AND UCC.IDUSUARIOCORREO = UI.IDUSUARIOCORREO
WHERE
UI.IDUSUARIO = @IDUSUARIO 
AND UI.ACTIVO = 1
AND ( 
	  UI.FROMNAME LIKE @BUSCAR
	  OR UI.FROMADDRESS LIKE @BUSCAR
	  OR UI.REPLYTO LIKE @BUSCAR
	  OR UI.SUBJECT LIKE @BUSCAR
	  OR UI.TOADDRESS LIKE @BUSCAR
	  OR UI.BODY LIKE @BUSCAR
	  OR US.EMAIL LIKE @BUSCAR
	  OR US.NOMBRE LIKE @BUSCAR
	  OR US.APELLIDOS LIKE @BUSCAR
	  OR P.NOMBRE LIKE @BUSCAR
	  OR P.APELLIDOS LIKE @BUSCAR
	  OR P.EMPRESA LIKE @BUSCAR
	  OR P.EMPRESA LIKE @BUSCAR
	  OR P.ETIQUETAS_TXT LIKE @BUSCAR
	)
AND (ISNULL(UI.idInboxMaster,0) = 0 or UI.IDINBOX  IN (SELECT MAX(IDinbox) AS IDINBOX from <#SESSION.DB/>.DBO.USUARIOS_INBOX WITH(NOLOCK) where IDUSUARIO = @IDUSUARIO and ACTIVO = 1 group by IDINBOXMASTER) )
ORDER BY UI.DATE DESC

