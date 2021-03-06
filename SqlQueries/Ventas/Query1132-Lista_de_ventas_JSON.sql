//[f_usuario|Text|,ordersql|Text|,crit|Text|,session.idempresa|Untyped|11811,session.idusuario|Untyped|56,session.nivel|Untyped|1,session.idgrupo|Untyped|2,session.multimoneda|Untyped|,session.db|Untyped|SALESUP_DB1]
--select
/*protegido*/
DECLARE @SQL VARCHAR(MAX)
DECLARE @F_USUARIO VARCHAR(MAX)
DECLARE @CRIT VARCHAr(MAX)
DECLARE @OrderSql VARCHAR(MAX)
SET @F_USUARIO=ISNULL(:F_USUARIO,'')
SET @OrderSql=ISNULL(:OrderSql,'')
SET @CRIT=ISNULL(:CRIT,'')

SET @SQL='


DECLARE @IDEMPRESA INT , @IDUSUARIO INT, @NIVELUSUARIO INT, @IDGRUPO INT
DECLARE @MULTIMONEDA INT
DECLARE @IDEMPRESAMONEDA INT
SET @IDEMPRESA = CAST(''<#SESSION.IDEMPRESA/>'' AS INT)
SET @IDUSUARIO = CAST(''<#SESSION.IDUSUARIO/>'' AS INT)
SET @NIVELUSUARIO = CAST(''<#SESSION.NIVEL/>'' AS INT)
SET @IDGRUPO = CAST(''<#SESSION.IDGRUPO/>'' AS INT)
SET @MULTIMONEDA = ISNULL(''<#SESSION.MULTIMONEDA/>'', 0)

DECLARE @TIPODECAMBIODEFAULT MONEY = 1



IF(@MULTIMONEDA > 0)
BEGIN
	 SELECT @TIPODECAMBIODEFAULT = TIPODECAMBIO,@IDEMPRESAMONEDA=IDEMPRESAMONEDA  FROM <#SESSION.DB/>.DBO.MONEDAS WHERE IDEMPRESA = @IDEMPRESA AND PORDEFECTO = 1
END

SELECT
  1 AS R,
  SALESUP_CT.dbo.esCanalizado(P.TKP, P.TKPM) AS esCanalizado, P.CANALIZADOEL AS FechaCanalizado, SALESUP_CT.dbo.ObtieneHora(P.CANALIZADOEL) AS HoraCanalizado, P.USRCANALIZO as Canalizo, P.USRCANALIZADO AS Canalizado,
   v.Tkv, o.Tko, P.Tkp,
  SALESUP_CT.dbo.VerLtArchivos(P.IDPROSPECTO, P.NARCHIVOS, O.IDOPORTUNIDAD, O.NARCHIVOS)  AS VerArchivos,
  ISNULL(P.NARCHIVOS,0) + ISNULL(O.NARCHIVOS,0) as tieneArchivos,
  P.IdProspecto, V.IdVenta, V.IdOportunidad,M.IDMONEDA AS Moneda,ISNULL(V.TIPODECAMBIO,1) AS TipoDeCambio,@TIPODECAMBIODEFAULT AS CambioDefault,
  ISNULL(PA.IDUSUARIO, 0) AS asignado,
  CASE WHEN V.IDUSUARIO = @IDUSUARIO OR  P.IDUSUARIO = @IDUSUARIO OR PA.IDUSUARIO = @IDUSUARIO THEN ''true'' ELSE '''' END AS tOportunidad,
  CASE WHEN V.IDUSUARIO = @IDUSUARIO OR  P.IDUSUARIO = @IDUSUARIO OR PA.IDUSUARIO = @IDUSUARIO OR @NIVELUSUARIO <= 2 THEN ''true'' ELSE '''' END AS tEtiquetar,
  CASE WHEN V.IDUSUARIO = @IDUSUARIO OR  P.IDUSUARIO = @IDUSUARIO OR @NIVELUSUARIO <= 2 OR @IDGRUPO = U.IDGRUPO THEN ''true'' ELSE '''' END AS tCancelar,
  LTRIM(RTRIM(P.NOMBRE))+'' ''+ISNULL(LTRIM(RTRIM(P.APELLIDOS)),'''') AS NombreCliente, O.Concepto, P.Puesto,
  CASE P.Sexo WHEN ''H'' THEN ''Hombre'' WHEN ''M'' THEN ''Mujer'' ELSE '''' END AS Sexo,
  V.Anticipos_Monto AS AnticiposMonto, V.Anticipos_Comision AS AnticiposComision,  CAST(Referencia AS VARCHAR(MAX)) AS Referencia,
  O.Subtotal, O.Impuestos,O.Descuento, 
  CASE WHEN ISNULL(ANTICIPOS_MONTO, 0) != 0 THEN ANTICIPOS_COMISION/ANTICIPOS_MONTO ELSE 0 END AS PorcentajeComision,
  V.SALDO_MONTO AS SaldoMonto, V.MONTO as Monto, GANADA_FECHA AS GanadaFecha, 

 (SELECT TOP 1 CONVERT(VARCHAR(10),VC.FECHAHORA,103) FROM <#SESSION.DB/>.DBO.VENTAS_COBROS VC WHERE V.IDVENTA = VC.IDVENTA AND VC.PAGADO = 1 ORDER BY VC.FECHAHORA DESC) AS Pagada_Fecha,
  
  CONVERT(VARCHAR(10),O.GANADA_FECHA,103) AS Ganada_Fecha,

  P.ETIQUETAS_TXT AS Etiquetas,
  P.Empresa as Empresa, 
  LTRIM(RTRIM(ISNULL(U.Iniciales,''''))) AS Iniciales, U.IdGrupo,
  U.NOMBRE+'' ''+U.APELLIDOS AS EjecutivoNombre, ISNULL(F.Fase,'''') as Fase, isnull(F.orden,'''') as orden,
  ISNULL(ABS (CAST (O.GANADA_FECHA-O.FECHAHORA AS INT)),0) as TiempoTranscurrido, PO.Origen,
  LP.LINEA_PRODUCTO AS LineaProducto,
  
  CASE WHEN P.CAMPO1 IS NOT NULL THEN P.CAMPO1 ELSE '''' END AS cp1,
  CASE WHEN P.CAMPO2 IS NOT NULL THEN P.CAMPO2 ELSE '''' END AS cp2,
  CASE WHEN P.CAMPO3 IS NOT NULL THEN P.CAMPO3 ELSE '''' END AS cp3,
  CASE WHEN P.CAMPO4 IS NOT NULL THEN P.CAMPO4 ELSE '''' END AS cp4,
  
  CASE WHEN P.CAMPO5 IS NOT NULL THEN P.CAMPO5 ELSE '''' END AS cp5,
  CASE WHEN P.CAMPO6 IS NOT NULL THEN P.CAMPO6 ELSE '''' END AS cp6,
  CASE WHEN P.CAMPO7 IS NOT NULL THEN P.CAMPO7 ELSE '''' END AS cp7,
  CASE WHEN P.CAMPO8 IS NOT NULL THEN P.CAMPO8 ELSE '''' END AS cp8,
  
  CASE WHEN P.CAMPO9 IS NOT NULL THEN CONVERT(VARCHAR(10),P.CAMPO9,103) ELSE '''' END AS cp9,
  CASE WHEN P.CAMPO10 IS NOT NULL THEN CONVERT(VARCHAR(10),P.CAMPO10,103) ELSE '''' END AS cp10,
  CASE WHEN P.CAMPO11 IS NOT NULL THEN CONVERT(VARCHAR(10),P.CAMPO11,103) ELSE '''' END AS cp11,
  CASE WHEN P.CAMPO12 IS NOT NULL THEN CONVERT(VARCHAR(10),P.CAMPO12,103) ELSE '''' END AS cp12,
  
  ISNULL(P.CAMPO13,'''') AS cp13,
  ISNULL(P.CAMPO14,'''') AS cp14,
  ISNULL(P.CAMPO15,'''') AS cp15,
  ISNULL(P.CAMPO16,'''') AS cp16,
  ISNULL(P.CAMPO17,'''') AS cp17,
  ISNULL(P.CAMPO18,'''') AS cp18,
  ISNULL(P.CAMPO19,'''') AS cp19,
  ISNULL(P.CAMPO20,'''') AS cp20,

  CP21.OPCION AS cp21,
  CP22.OPCION AS cp22,
  CP23.OPCION AS cp23,
  CP24.OPCION AS cp24,
  CP25.OPCION AS cp25,
  
  P.CAMPO26 AS cp26, P.CAMPO27 AS cp27, P.CAMPO28 AS cp28P,
  P.CAMPO29 AS cp29, P.CAMPO30 AS cp30, P.CAMPO31 AS cp31P, P.CAMPO32 AS cp32P,
  P.CAMPO33 AS cp33, P.CAMPO34 AS cp34,
  P.CAMPO35 AS cp35, P.CAMPO36 AS cp36, P.CAMPO37 AS cp37, P.CAMPO38 AS cp38, P.CAMPO39 AS cp39, 
  P.CAMPO40 AS cp40, P.CAMPO41 AS cp41, P.CAMPO42 AS cp42, P.CAMPO43 AS cp43, P.CAMPO44 AS cp44, 
  P.CAMPO45 AS cp45, P.CAMPO46 AS cp46, P.CAMPO47 AS cp47, P.CAMPO48 AS cp48, P.CAMPO49 AS cp49, 
  P.CAMPO50 AS cp50, P.CAMPO51 AS cp51, P.CAMPO52 AS cp52, P.CAMPO53 AS cp53, P.CAMPO54 AS cp54, 
  P.CAMPO55 AS cp55, P.CAMPO56 AS cp56, P.CAMPO57 AS cp57, P.CAMPO58 AS cp58, P.CAMPO59 AS cp59, 
  P.CAMPO60 AS cp60, P.CAMPO61 AS cp61, P.CAMPO62 AS cp62, P.CAMPO63 AS cp63, P.CAMPO64 AS cp64,
  
  O.CAMPO1 AS cp1O, O.CAMPO2 AS cp2O, O.CAMPO3 AS cp3O, O.CAMPO4 AS cp4O,
  O.CAMPO5 AS cp5O, O.CAMPO6 AS cp6O, O.CAMPO7 AS cp7O, O.CAMPO8 AS cp8O,
  CASE WHEN O.CAMPO9 IS NOT NULL THEN CONVERT(VARCHAR(10),O.CAMPO9,103) ELSE '''' END AS cp9O,
  CASE WHEN O.CAMPO10 IS NOT NULL THEN CONVERT(VARCHAR(10),O.CAMPO10,103) ELSE '''' END AS cp10O,
  CASE WHEN O.CAMPO11 IS NOT NULL THEN CONVERT(VARCHAR(10),O.CAMPO11,103) ELSE '''' END AS cp11O,
  CASE WHEN O.CAMPO12 IS NOT NULL THEN CONVERT(VARCHAR(10),O.CAMPO12,103) ELSE '''' END AS cp12O,
  O.CAMPO13 AS cp13O, O.CAMPO14 AS cp14O, O.CAMPO15 AS cp15O, O.CAMPO16 AS cp16O,
  O.CAMPO17 AS cp17O, O.CAMPO18 AS cp18O, O.CAMPO19 AS cp19O, O.CAMPO20 AS cp20O,
  CPO21.OPCION AS cp21O, CPO22.OPCION AS cp22O, CPO23.OPCION AS cp23O, CPO24.OPCION AS cp24O, CPO25.OPCION AS cp25O,
  O.CAMPO26 AS cp26O, O.CAMPO27 AS cp27O, O.CAMPO28 AS cp28O,
  O.CAMPO29 AS cp29O, O.CAMPO30 AS cp30O, O.CAMPO31 AS cp31O, O.CAMPO32 AS cp32O,
  O.CAMPO33 AS cp33O, O.CAMPO34 AS cp34O,
  O.CAMPO35 AS cp35O, O.CAMPO36 AS cp36O, O.CAMPO37 AS cp37O, O.CAMPO38 AS cp38O, O.CAMPO39 AS cp39O, 
  O.CAMPO40 AS cp40O, O.CAMPO41 AS cp41O, O.CAMPO42 AS cp42O, O.CAMPO43 AS cp43O, O.CAMPO44 AS cp44O, 
  O.CAMPO45 AS cp45O, O.CAMPO46 AS cp46O, O.CAMPO47 AS cp47O, O.CAMPO48 AS cp48O, O.CAMPO49 AS cp49O, 
  O.CAMPO50 AS cp50O, O.CAMPO51 AS cp51O, O.CAMPO52 AS cp52O, O.CAMPO53 AS cp53O, O.CAMPO54 AS cp54O, 
  O.CAMPO55 AS cp55O, O.CAMPO56 AS cp56O, O.CAMPO57 AS cp57O, O.CAMPO58 AS cp58O, O.CAMPO59 AS cp59O, 
  O.CAMPO60 AS cp60O, O.CAMPO61 AS cp61O, O.CAMPO62 AS cp62O, O.CAMPO63 AS cp63O, O.CAMPO64 AS cp64O
  
  ,CatP1.OPCION AS pCat1, CatP2.OPCION AS pCat2,CatP3.OPCION AS pCat3,
  CatO1.OPCION AS oCat1, CatO2.OPCION AS oCat2,CatO2.OPCION AS oCat3,
  CatE1.OPCION AS eCat1,CatE2.OPCION AS eCat2,CatE3.OPCION AS eCat3  , 
  CatI.INDUSTRIA AS CatIndustria, CatG.COMPANIAGRUPO AS CatCorporativo, 
  PA.JSONEVENTO AS proximoEvento, 
  MON.MONEDA_SIMBOLO AS SIMBOLO, 
  UNICODE(MON.MONEDA_SIMBOLO) AS UNICODE

  
FROM 
<#SESSION.DB/>.DBO.VENTAS V WITH(NOLOCK)
LEFT JOIN <#SESSION.DB/>.DBO.MONEDAS M WITH(NOLOCK) ON M.IDEMPRESAMONEDA = (CASE WHEN V.IDMONEDA IS NULL THEN @IDEMPRESAMONEDA ELSE V.IDMONEDA END)
LEFT JOIN SALESUP_CT.DBO.MONEDAS MON  ON MON.IDMONEDA=M.IDMONEDA,
<#SESSION.DB/>.DBO.OPORTUNIDADES O WITH(NOLOCK)
JOIN <#SESSION.DB/>.DBO.PROSPECTOS P WITH(NOLOCK) ON P.IDPROSPECTO = O.IDPROSPECTO
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS PA WITH(NOLOCK) ON PA.IDUSUARIO = @IDUSUARIO AND P.IDPROSPECTO = PA.IDPROSPECTO
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CPO21 WITH(NOLOCK) ON CPO21.IDOPCION = O.CAMPO21
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CPO22 WITH(NOLOCK) ON CPO22.IDOPCION = O.CAMPO22
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CPO23 WITH(NOLOCK) ON CPO23.IDOPCION = O.CAMPO23
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CPO24 WITH(NOLOCK) ON CPO24.IDOPCION = O.CAMPO24
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CPO25 WITH(NOLOCK) ON CPO25.IDOPCION = O.CAMPO25
LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS COM WITH(NOLOCK) ON COM.IDCOMPANIA = P.IDCOMPANIA
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatP1 WITH(NOLOCK) ON CatP1.IDCATALOGOOPCION = P.IDCATALOGOOPCION1      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatP2 WITH(NOLOCK) ON CatP2.IDCATALOGOOPCION = P.IDCATALOGOOPCION2      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatP3 WITH(NOLOCK) ON CatP3.IDCATALOGOOPCION = P.IDCATALOGOOPCION3      

LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatO1 WITH(NOLOCK) ON CatO1.IDCATALOGOOPCION = O.IDCATALOGOOPCION1      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatO2 WITH(NOLOCK) ON CatO2.IDCATALOGOOPCION = O.IDCATALOGOOPCION2      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatO3 WITH(NOLOCK) ON CatO3.IDCATALOGOOPCION = O.IDCATALOGOOPCION3      

LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatE1 WITH(NOLOCK) ON CatE1.IDCATALOGOOPCION = COM.IDCATALOGOOPCION1      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatE2 WITH(NOLOCK) ON CatE2.IDCATALOGOOPCION = COM.IDCATALOGOOPCION2      
LEFT JOIN <#SESSION.DB/>.DBO.CATALOGOS_OPCIONES CatE3 WITH(NOLOCK) ON CatE3.IDCATALOGOOPCION = COM.IDCATALOGOOPCION3      

LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_INDUSTRIAS CatI WITH(NOLOCK) ON CatI.IDINDUSTRIA = COM.IDINDUSTRIA      
LEFT JOIN <#SESSION.DB/>.DBO.COMPANIAS_GRUPOS CatG WITH(NOLOCK) ON CatG.IDCOMPANIAGRUPO = COM.IDCOMPANIAGRUPO		      
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP21 WITH(NOLOCK) ON CP21.IDOPCION = P.CAMPO21
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP22 WITH(NOLOCK) ON CP22.IDOPCION = P.CAMPO22
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP23 WITH(NOLOCK) ON CP23.IDOPCION = P.CAMPO23
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP24 WITH(NOLOCK) ON CP24.IDOPCION = P.CAMPO24
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP25 WITH(NOLOCK) ON CP25.IDOPCION = P.CAMPO25, 
<#SESSION.DB/>.DBO.OPORTUNIDADES_FASES F WITH(NOLOCK),
<#SESSION.DB/>.DBO.USUARIOS U WITH(NOLOCK), <#SESSION.DB/>.DBO.EMPRESAS_LINEAS_PRODUCTO LP WITH(NOLOCK), 
<#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES PO WITH(NOLOCK)

WHERE
  V.IDOPORTUNIDAD = O.IDOPORTUNIDAD AND
  O.IDPROSPECTO = P.IDPROSPECTO AND
  P.DESCARTADO = 0 AND v.IDUSUARIO = U.IDUSUARIO AND   
  O.IDFASE = F.IDFASE AND
  O.IDLINEA_PRODUCTO = LP.IDLINEA_PRODUCTO AND P.IDEMPRESA = @IDEMPRESA
  AND P.IDORIGEN = PO.IDORIGEN 
  '+@F_USUARIO+'
  '+@CRIT+'
  
  '+@OrderSql+'




'
EXEC (@SQL)