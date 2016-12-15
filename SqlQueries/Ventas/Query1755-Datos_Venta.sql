//[session.convertcode|Untyped|103,session.idempresa|Untyped|11811,session.idusuario|Untyped|56,tkv|Text|V-CB186C62-7D43-412A-8C0C-79E2164DA348,idventa|Integer|,session.db|Untyped|salesup_db1]
--SELECT

DECLARE @TKV VARCHAR(64) 
DECLARE @IDVENTA INT, @GRUPOAUDITADO INT, @CONVERTCODE INT, @TOTALCOBROS INT, @MUESTRAPAGOS INT, @IDEMPRESA INT, @IDUSUARIO INT

SET @CONVERTCODE = '<#SESSION.CONVERTCODE/>' IF @CONVERTCODE = '' BEGIN SET @CONVERTCODE = 103 END
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

SET @TKV = ISNULL(:TKV,'')  
SET @IDVENTA = ISNULL(:IDVENTA,0) 
  
IF @TKV != '' BEGIN SELECT @IDVENTA = IDVENTA FROM <#SESSION.DB/>.DBO.VENTAS WHERE TKV = @TKV END

SET @TOTALCOBROS = 0

SELECT @TOTALCOBROS = COUNT(*) FROM <#SESSION.DB/>.DBO.VENTAS_COBROS VC WHERE IDVENTA = @IDVENTA 

IF @TOTALCOBROS > 1 
BEGIN 
  SET @MUESTRAPAGOS = 1 
END 
ELSE 
BEGIN 
  SELECT @MUESTRAPAGOS = (CASE WHEN PAGADO = 1 THEN 0 ELSE 1 END) FROM <#SESSION.DB/>.DBO.VENTAS_COBROS WHERE IDVENTA = @IDVENTA AND NOPARCIALIDAD = 1
END
   

SELECT @GRUPOAUDITADO = UG.AUDITADO 
FROM 
<#SESSION.DB/>.DBO.VENTAS V,
<#SESSION.DB/>.DBO.USUARIOS U , 
<#SESSION.DB/>.DBO.USUARIOS_GRUPOS UG 
WHERE V.IDVENTA = @IDVENTA AND V.IDUSUARIO = U.IDUSUARIO AND U.IDGRUPO = UG.IDUSUARIOGRUPO


SELECT 1 AS esVenta,
@GRUPOAUDITADO AS GrupoAuditado,
@MUESTRAPAGOS AS MuestraPagos,
SALESUP_CT.dbo.esCanalizado(O.TKO, O.TKOM) AS esCanalizado, 
(SELECT CASE WHEN COUNT(PA1.IDPROSPECTO) > 0 THEN '1' ELSE '' END FROM <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS PA1 WHERE PA1.IDPROSPECTO = P.IDPROSPECTO AND P.IDUSUARIO != PA1.IDUSUARIO) AS Compartido,
isnull((SELECT IDUSUARIO FROM <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS PA WHERE PA.IDUSUARIO = <#SESSION.IDUSUARIO/> AND PA.IDPROSPECTO = P.IDPROSPECTO),0) AS Asignado,
/*dProspecto*/
 	(U.NOMBRE+' '+U.APELLIDOS) AS Ejecutivo, U.Iniciales, U.Email as EmailEjecutivo,
 
    P.recibirCorreos, p.idprospecto AS idp, P.Tkp, P.IdUsuario, P.Nombre, P.Apellidos, P.Titulo, P.Sexo, P.Correo, P.Puesto, P.Telefono, P.Telefono2, P.Movil,
	P.Comentarios, PO.Origen, PF.Fase, P.ETIQUETAS_TXT AS Etiquetas, CONVERT(VARCHAR(10),P.FECHACONTACTO,103) AS CreadoEl, SALESUP_CT.dbo.ObtieneHora(P.FECHACONTACTO) as CreadoHora,
	 
	P.Facebook, P.Twitter, P.Skype, P.Linkedin, P.Googleplus,
	
	P.Empresa, P.Url, P.IdMunicipio, P.direccion1 AS pCalle, P.direccion2 as pColonia, P.Ciudad as pCiudad , P.codigopostal as pCodigoPostal,
	P.IdCompania, P.IdIndustria, P.IdCompaniaGrupo,
	
	P.Campo1, P.Campo2, P.Campo3, P.Campo4,
	P.Campo5, P.Campo6, P.Campo7, P.Campo8,
	
	CONVERT(VARCHAR(10), P.Campo9, 103 ) AS Campo9,
	CONVERT(VARCHAR(10), P.Campo10, 103 ) AS Campo10,
	CONVERT(VARCHAR(10), P.Campo11, 103 ) AS Campo11,
	CONVERT(VARCHAR(10), P.Campo12, 103 ) AS Campo12, 
	
	P.Campo13, P.Campo14, P.Campo15, P.Campo16, P.Campo17, P.Campo18, P.Campo19, P.Campo20,
	ECO1.OPCION AS Campo21, ECO2.OPCION AS Campo22, ECO3.OPCION AS Campo23, ECO4.OPCION AS Campo24, ECO5.OPCION AS Campo25,
	P.Campo26, P.Campo27, P.Campo28, P.Campo29, P.Campo30, P.Campo31, P.Campo32, P.Campo33, P.Campo34,
	
	P.Campo35, P.Campo36, P.Campo37, P.Campo38, P.Campo39, 
	P.Campo40, P.Campo41, P.Campo42, P.Campo43, P.Campo44, 
	P.Campo45, P.Campo46, P.Campo47, P.Campo48, P.Campo49, 
	P.Campo50, P.Campo51, P.Campo52, P.Campo53, P.Campo54, 
	P.Campo55, P.Campo56, P.Campo57, P.Campo58, P.Campo59, 
	P.Campo60, P.Campo61, P.Campo62, P.Campo63, P.Campo64, 
	
	(SELECT PAIS FROM <#SESSION.DB/>.DBO.PAISES WHERE IDPAIS = P.IDPAIS) AS pPais,
    (SELECT ESTADO FROM <#SESSION.DB/>.DBO.ESTADOS WHERE IDESTADO = P.IDESTADO AND IDPAIS=P.IDPAIS) AS pEstado,
    (SELECT M.MUNICIPIO FROM SALESUP_CT.DBO.MUNICIPIOS M WHERE M.IDMUNICIPIO = P.IDMUNICIPIO AND M.IDESTADO = P.IDESTADO AND M.IDPAIS = P.IDPAIS) AS pMunicipio,
  
  /*dEmpresa*/
  COM.TKCOM as tkcom, EI.Industria, CG.CompaniaGrupo as GrupoEmpresarial, COM.URL AS PaginaWeb, COM.DIRECCION1 AS Calle, COM.DIRECCION2 AS Colonia, 
  COM.CIUDAD AS Ciudad, COM.CODIGOPOSTAL AS CodigoPostal, COM.NEMPLEADOS AS nEmpleados, COM.TELEFONOCORPORATIVO AS TelefonoCorporativo,
COM.NUMERO_INTERIOR as NumInterior, COM.NUMERO_EXTERIOR as NumExterior, 
	COM.CCAMPO1 as Campo1C, COM.CCAMPO2 as Campo2C, COM.CCAMPO3 as Campo3C, COM.CCAMPO4 as Campo4C, COM.CCAMPO5 as Campo5C,
	COM.CCAMPO6 as Campo6C, COM.CCAMPO7 as Campo7C, COM.CCAMPO8 as Campo8C, COM.CCAMPO9 as Campo9C, COM.CCAMPO10 as Campo10C,
	(SELECT ESTADO FROM <#SESSION.DB/>.DBO.ESTADOS WHERE IDESTADO = COM.IDESTADO AND IDPAIS = COM.IDPAIS) AS Estado, 
	(SELECT PAIS FROM <#SESSION.DB/>.DBO.PAISES WHERE IDPAIS = COM.IDPAIS) AS Pais,
	(SELECT MUNICIPIO FROM SALESUP_CT.dbo.MUNICIPIOS WHERE IDPAIS = COM.IDPAIS AND IDESTADO = COM.IDESTADO AND IDMUNICIPIO = COM.IDMUNICIPIO) AS EmpMunicipio,
  EI.tkInd, CG.Tkcg,
  
/*dVenta*/
O.IDOPORTUNIDAD AS ido, O.Concepto, v.monto as vMonto, v.ANTICIPOS_MONTO as Pagado, 
v.COMISION as vComision, LP.LINEA_PRODUCTO as LineaProducto, CONVERT(VARCHAR(10), V.FECHAHORA, 103 )  AS fechaCierre,

O.Campo1 AS Campo1O, O.Campo2 AS Campo2O, O.Campo3 AS Campo3O, O.Campo4 AS Campo4O,
O.Campo5 AS Campo5O, O.Campo6 AS Campo6O, O.Campo7 AS Campo7O, O.Campo8 AS Campo8O,
	
	CONVERT(VARCHAR(10), O.Campo9, 103 ) AS Campo9O,
	CONVERT(VARCHAR(10), O.Campo10, 103 ) AS Campo10O,
	CONVERT(VARCHAR(10), O.Campo11, 103 ) AS Campo11O,
	CONVERT(VARCHAR(10), O.Campo12, 103 ) AS Campo12O, 
	
	O.Campo13 AS Campo13O, O.Campo14 AS Campo14O, O.Campo15 AS Campo15O, O.Campo16 AS Campo16O, O.Campo17 AS Campo17O, O.Campo18 AS Campo18O, O.Campo19 AS Campo19O, O.Campo20 AS Campo20O,
	OECO1.OPCION AS Campo21O, OECO2.OPCION AS Campo22O, OECO3.OPCION AS Campo23O, OECO4.OPCION AS Campo24O, OECO5.OPCION AS Campo25O,
	O.Campo26 AS Campo26O, O.Campo27 AS Campo27O, O.Campo28 AS Campo28O, O.Campo29 AS Campo29O, O.Campo30 AS Campo30O, O.Campo31 AS Campo31O, O.Campo32 AS Campo32O, O.Campo33 AS Campo33O, O.Campo34 AS Campo34O,
	
	O.Campo35 AS Campo35O, O.Campo36 AS Campo36O, O.Campo37 AS Campo37O, O.Campo38 AS Campo38O, O.Campo39 AS Campo39O, 
	O.Campo40 AS Campo40O, O.Campo41 AS Campo41O, O.Campo42 AS Campo42O, O.Campo43 AS Campo43O, O.Campo44 AS Campo44O, 
	O.Campo45 AS Campo45O, O.Campo46 AS Campo46O, O.Campo47 AS Campo47O, O.Campo48 AS Campo48O, O.Campo49 AS Campo49O, 
	O.Campo50 AS Campo50O, O.Campo51 AS Campo51O, O.Campo52 AS Campo52O, O.Campo53 AS Campo53O, O.Campo54 AS Campo54O, 
	O.Campo55 AS Campo55O, O.Campo56 AS Campo56O, O.Campo57 AS Campo57O, O.Campo58 AS Campo58O, O.Campo59 AS Campo59O, 
	O.Campo60 AS Campo60O, O.Campo61 AS Campo61O, O.Campo62 AS Campo62O, O.Campo63 AS Campo63O, O.Campo64 AS Campo64O, 
	
 /*dCatalogos*/
 O.IdCatalogoOpcion1, O.IdCatalogoOpcion2, O.IdCatalogoOpcion3,
 CatP1.OPCION AS pCat1, CatP2.OPCION AS pCat2, CatP2.OPCION AS pCat3,
	CatO1.OPCION AS oCat1, CatO2.OPCION AS oCat2, CatO2.OPCION AS oCat3,
	CatE1.OPCION AS eCat1,CatE2.OPCION AS eCat2, CatE3.OPCION AS eCat3,
 '' as nada, 
 mon2.moneda_simbolo as simbolo, unicode(mon2.moneda_simbolo) as UNICODE
   
FROM 
<#SESSION.DB/>.DBO.VENTAS V
left join <#session.db/>.dbo.monedas mon on mon.idempresamoneda=v.idmoneda
left join salesup_ct.dbo.monedas mon2 on mon2.idmoneda=mon.idmoneda,
<#SESSION.DB/>.DBO.EMPRESAS_LINEAS_PRODUCTO LP, 
<#SESSION.DB/>.DBO.OPORTUNIDADES O
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES OECO1 ON OECO1.IDOPCION = O.CAMPO21
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES OECO2 ON OECO2.IDOPCION = O.CAMPO22 
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES OECO3 ON OECO3.IDOPCION = O.CAMPO23 
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES OECO4 ON OECO4.IDOPCION = O.CAMPO24 
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES OECO5 ON OECO5.IDOPCION = O.CAMPO25
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatO1 WITH(NOLOCK) ON CatO1.IDCATALOGOOPCION = O.IDCATALOGOOPCION1      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatO2 WITH(NOLOCK) ON CatO2.IDCATALOGOOPCION = O.IDCATALOGOOPCION2      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatO3 WITH(NOLOCK) ON CatO3.IDCATALOGOOPCION = O.IDCATALOGOOPCION3
, <#SESSION.DB/>.DBO.PROSPECTOS P
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES ECO1 ON ECO1.IDOPCION = P.CAMPO21
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES ECO2 ON ECO2.IDOPCION = P.CAMPO22 
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES ECO3 ON ECO3.IDOPCION = P.CAMPO23 
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES ECO4 ON ECO4.IDOPCION = P.CAMPO24 
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS_OPCIONES ECO5 ON ECO5.IDOPCION = P.CAMPO25
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatP1 WITH(NOLOCK) ON CatP1.IDCATALOGOOPCION = P.IDCATALOGOOPCION1      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatP2 WITH(NOLOCK) ON CatP2.IDCATALOGOOPCION = P.IDCATALOGOOPCION2      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatP3 WITH(NOLOCK) ON CatP3.IDCATALOGOOPCION = P.IDCATALOGOOPCION3
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS_FASES PF ON PF.IDFASE = P.IDFASE
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES PO ON PO.IDORIGEN = P.IDORIGEN
LEFT JOIN <#SESSION.DB/>.DBO.COMPANIAS COM ON COM.IDCOMPANIA = P.IDCOMPANIA AND COM.IDEMPRESA = P.IDEMPRESA
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatE1 WITH(NOLOCK) ON CatE1.IDCATALOGOOPCION = COM.IDCATALOGOOPCION1      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatE2 WITH(NOLOCK) ON CatE2.IDCATALOGOOPCION = COM.IDCATALOGOOPCION2      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatE3 WITH(NOLOCK) ON CatE3.IDCATALOGOOPCION = COM.IDCATALOGOOPCION3
LEFT JOIN <#SESSION.DB/>.DBO.COMPANIAS_GRUPOS CG ON CG.IDCOMPANIAGRUPO = COM.IDCOMPANIAGRUPO 
LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_INDUSTRIAS EI ON EI.IDINDUSTRIA = COM.IDINDUSTRIA,
<#SESSION.DB/>.DBO.OPORTUNIDADES_FASES F, 
<#SESSION.DB/>.DBO.USUARIOS U
WHERE
  V.IDVENTA = @IDVENTA  
  AND P.IDEMPRESA = @IDEMPRESA 
  AND V.IDOPORTUNIDAD = O.IDOPORTUNIDAD 
  AND O.IDPROSPECTO = P.IDPROSPECTO  
  AND O.IDLINEA_PRODUCTO = LP.IDLINEA_PRODUCTO 
  AND O.IDFASE = F.IDFASE 
  AND P.IDUSUARIO = U.IDUSUARIO