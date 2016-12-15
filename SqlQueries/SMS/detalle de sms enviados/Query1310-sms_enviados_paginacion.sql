//[session.convertcode|Untyped,session.idempresa|Untyped,ejecutivo|Integer,buscar|Text,estado|Integer,session.idgrupo|Untyped,desde|Text,hasta|Text,session.db|Untyped,session.idusuario|Untyped,correo|Integer,]
--SELECT
/*PROTEGIDO*/

DECLARE @IDEMPRESA INT, @IDUSUARIO INT, @CONVERTECODE INT, @ESTADO INT, @IDGRUPO INT
DECLARE @CORREO INT
DECLARE @BUSCAR VARCHAR(256)
DECLARE @DESDE VARCHAR(128), @HASTA VARCHAR(128)
DECLARE @FILTRO VARCHAR(MAX) = ''
DECLARE @SQLTXT VARCHAR(MAX) = ''

SET @CONVERTECODE = <#SESSION.CONVERTCODE/>
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = ISNULL(:ejecutivo,0)
SET @CORREO = ISNULL(:correo,0)
SET @BUSCAR = ISNULL(:BUSCAR,'')
SET @ESTADO = ISNULL(:ESTADO,0)
SET @IDGRUPO = <#SESSION.IDGRUPO/>

SET @DESDE = ISNULL(:DESDE,'')
SET @HASTA = ISNULL(:HASTA,'')

IF(@ESTADO <> 2)
    SET @FILTRO =  @FILTRO + ' AND ESTADO = ' + CAST(@ESTADO AS VARCHAR(5))
 
IF(@CORREO <> 2)
    SET @FILTRO =  @FILTRO + ' AND TIPO = ' + CAST(@CORREO AS VARCHAR(5))
    
IF(@IDUSUARIO <> 0)
    SET @FILTRO =  @FILTRO + ' AND UE.IDUSUARIO = ' + CAST(@IDUSUARIO AS VARCHAR(5))
 
IF(@BUSCAR <> '')
    SET @FILTRO =  @FILTRO + ' AND (UE.DESTINATARIO LIKE ''%'+@BUSCAR+'%'' OR UE.ASUNTO LIKE ''%'+@BUSCAR+'%'' OR P.NOMBRE LIKE ''%'+@BUSCAR+'%'' OR P.APELLIDOS LIKE ''%'+@BUSCAR+'%'' OR P.EMPRESA LIKE ''%'+@BUSCAR+'%'') '
 
IF(@DESDE <> '')
BEGIN
    IF(@DESDE <> @HASTA)
        SET @FILTRO =  @FILTRO + ' AND SALESUP_DB8.DBO.GETONLYDATE(UE.FECHAHORA) BETWEEN CONVERT(DATETIME,'''+@DESDE+''','+CAST(@CONVERTECODE AS VARCHAR(5))+') AND CONVERT(DATETIME,'''+@HASTA+''','+CAST(@CONVERTECODE AS VARCHAR(5))+') ' 
    ELSE
       SET @FILTRO =  @FILTRO + ' AND SALESUP_DB8.DBO.GETONLYDATE(UE.FECHAHORA) = SALESUP_DB8.DBO.GETONLYDATE(CONVERT(DATETIME,'''+@HASTA+''','+CAST(@CONVERTECODE AS VARCHAR(5))+')) ' 
END

SET @SQLTXT = ' SELECT COUNT(*) AS TOTALN,'+CAST(@IDUSUARIO AS VARCHAR(10))+' AS EJECUTIVO,'+CAST(@CORREO AS VARCHAR(10))+' AS CORREO, '''+@BUSCAR +''' AS BUSCAR,'+CAST(@ESTADO AS VARCHAR(MAX))+' AS ESTADO,CONVERT(DATETIME,'''+@DESDE+''','+CAST(@CONVERTECODE AS VARCHAR(5))+') AS DESDE, CONVERT(DATETIME,'''+@HASTA+''','+CAST(@CONVERTECODE AS VARCHAR(5))+') AS HASTA
FROM <#SESSION.DB/>.DBO.ObtieneUsuariosAutorizadosModulos (<#SESSION.IDUSUARIO/>,8,0) UL,<#SESSION.DB/>.DBO.USUARIOS_SMS UE 
LEFT JOIN <#SESSION.DB/>.DBO.AUTORESPONDERS_CONTROL AC ON AC.IDPROSPECTO = UE.IDPROSPECTO AND AC.IDPIEZA = UE.IDPIEZA,
 <#SESSION.DB/>.DBO.PROSPECTOS P , <#SESSION.DB/>.DBO.USUARIOS U 
WHERE UL.ID=U.IDUSUARIO AND
UE.IDUSUARIO = U.IDUSUARIO 
AND U.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(5))+' 
AND P.IDPROSPECTO = UE.IDPROSPECTO
AND U.IDUSUARIO = UE.IDUSUARIO ' + @FILTRO + ' '

EXEC(@SQLTXT)

