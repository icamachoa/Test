//[idp|Integer,tkp|Text,tko|Text,session.idempresa|Untyped,session.idusuario|Untyped,session.db|Untyped,]
-- SELECT
/*PROTEGIDO*/
DECLARE @IDPROSPECTO INT
DECLARE @TKP VARCHAR(64), @ETIQUETAS VARCHAR(MAX)

DECLARE @IDOPORTUNIDAD INT
DECLARE @TKO VARCHAR(64)

SET @IDPROSPECTO = ISNULL(:IDP,0)
SET @TKP = ISNULL(:TKP,'')
SET @TKO = ISNULL(:TKO,'')
SET @ETIQUETAS = ''

DECLARE @IDEMPRESA INT, @IDUSUARIO INT

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

IF @TKP != '' BEGIN SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) END

IF @TKO != '' BEGIN SELECT @IDOPORTUNIDAD = IDOPORTUNIDAD FROM <#SESSION.DB/>.dbo.OPORTUNIDADES  WHERE CAST(TKO AS VARCHAR(64)) = @TKO END



SELECT 
@ETIQUETAS = @ETIQUETAS + CAST(E.IDETIQUETA AS VARCHAR(MAX)) + ','
FROM 
<#SESSION.DB/>.dbo.PROSPECTOS P, 
<#SESSION.DB/>.dbo.PROSPECTOS_ETIQUETAS PE, 
<#SESSION.DB/>.dbo.ETIQUETAS E
WHERE 
P.IDPROSPECTO = PE.IDPROSPECTO AND PE.IDETIQUETA = E.IDETIQUETA AND P.IDPROSPECTO = @IDPROSPECTO

SELECT 
    SALESUP_CT.dbo.esCanalizado(P.TKP, P.TKPM) AS esCanalizado, @IDOPORTUNIDAD AS IDOPORTUNIDAD, @IDPROSPECTO AS IDPROSPECTO,
	p.APROBACIONESTADO as autorizacionPendiente, 
	P.Tkp, P.IdUsuario, P.Nombre, P.Apellidos, ET.IdTitulo, P.Titulo, P.Sexo, P.Correo, P.Puesto, P.Telefono, P.Telefono2, P.Movil,
	P.Comentarios, P.IdOrigen, P.IdFase, 
	P.Facebook, P.Twitter, P.Skype, P.Linkedin, P.Googleplus,
	
	P.Empresa, P.noempleados as nEmpleados, P.Url, P.IdPais, P.IdEstado, P.IdMunicipio, P.direccion1 AS Calle, P.direccion2 as Colonia, P.Ciudad, P.codigopostal as Cp,
	P.IdCompania, P.IdIndustria, P.TelefonoCorporativo, P.IdCompaniaGrupo,COM.TKCOM,
	
	P.Campo1, P.Campo2, P.Campo3, P.Campo4,
	P.Campo5, P.Campo6, P.Campo7, P.Campo8,
	
	CONVERT(VARCHAR(10), P.Campo9, 103 ) AS Campo9,
	CONVERT(VARCHAR(10), P.Campo10, 103 ) AS Campo10,
	CONVERT(VARCHAR(10), P.Campo11, 103 ) AS Campo11,
	CONVERT(VARCHAR(10), P.Campo12, 103 ) AS Campo12, 
	
	P.Campo13, P.Campo14, P.Campo15, P.Campo16, P.Campo17, P.Campo18, P.Campo19, P.Campo20,
	P.Campo21, P.Campo22, P.Campo23, P.Campo24, P.Campo25,
	P.Campo26, P.Campo27, P.Campo28, P.Campo29, P.Campo30, P.Campo31, P.Campo32,
	
	P.Campo35, P.Campo36, P.Campo37, P.Campo38, P.Campo39, 
	P.Campo40, P.Campo41, P.Campo42, P.Campo43, P.Campo44, 
	P.Campo45, P.Campo46, P.Campo47, P.Campo48, P.Campo49, 
	P.Campo50, P.Campo51, P.Campo52, P.Campo53, P.Campo54, 
	P.Campo55, P.Campo56, P.Campo57, P.Campo58, P.Campo59, 
	P.Campo60, P.Campo61, P.Campo62, P.Campo63, P.Campo64, 
	
	EI.Industria, CG.CompaniaGrupo, PA.Pais, E.Estado, @ETIQUETAS AS Etiquetas,
	P.IDCATALOGOOPCION1 AS OpcionCatalogo1, P.IDCATALOGOOPCION2 AS OpcionCatalogo2, P.IDCATALOGOOPCION3 AS OpcionCatalogo3,
	 <#SESSION.DB/>.dbo.OpcionesMostrar (@IDEMPRESA, @IDPROSPECTO, 0) AS OpcionMostrar
FROM 
<#SESSION.DB/>.dbo.PROSPECTOS P
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_TITULOS ET ON ET.TITULO = P.TITULO AND P.IDEMPRESA = ET.IDEMPRESA
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_INDUSTRIAS EI ON P.IDINDUSTRIA = EI.IDINDUSTRIA 
LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS_GRUPOS CG ON CG.IDCOMPANIAGRUPO = P.IDCOMPANIAGRUPO 
LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS COM ON COM.IDCOMPANIA = P.IDCOMPANIA
LEFT JOIN <#SESSION.DB/>.dbo.PAISES PA ON PA.IDPAIS = P.IDPAIS
LEFT JOIN <#SESSION.DB/>.dbo.ESTADOS E ON E.IDESTADO = P.IDESTADO AND E.IDPAIS = P.IDPAIS
WHERE P.IDPROSPECTO = @IDPROSPECTO