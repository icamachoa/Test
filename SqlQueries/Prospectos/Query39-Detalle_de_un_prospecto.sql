//[filtroagrupardetalle|Integer,tko|Text,tkp|Text,idprospecto|Integer,session.convertcode|Untyped,session.idempresa|Untyped,session.idusuario|Untyped,session.db|Untyped,]
 --SELECT
  DECLARE @TKP VARCHAR(64)
  DECLARE @IDPROSPECTO INT
  DECLARE @IDEMPRESA INT
  DECLARE @CODIGO INT
  DECLARE @TKO VARCHAR(64)
  DECLARE @IDUSUARIO INT
  DECLARE @FILTROAGRUPARDETALLE INT 
  SET @FILTROAGRUPARDETALLE= ISNULL(:FILTROAGRUPARDETALLE, 0)
  
  DECLARE @IDOPORTUNIDAD INT
  
  SET @TKO=ISNULL(:Tko,0)
  SET @TKP = :TKP
  SET @IDPROSPECTO = :IDPROSPECTO 
  SET @CODIGO='<#SESSION.CONVERTCODE/>' IF @CODIGO = '' SET @CODIGO=103
  SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
  SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

  IF(@TKO != '')BEGIN SELECT @IDOPORTUNIDAD = IDOPORTUNIDAD FROM <#SESSION.DB/>.dbo.OPORTUNIDADES WHERE TKO = @TKO END
  
  IF @TKP != '' BEGIN SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) END
  
  SELECT TOP 1 P.IDPROSPECTO as idp, @IDPROSPECTO AS IDPROSPECTO,@TKO as tko,@IDOPORTUNIDAD AS IDOPORTUNIDAD, @FILTROAGRUPARDETALLE AS FILTROAGRUPARDETALLE,U.Tku,COM.TkCom, <#SESSION.DB/>.dbo.obtienePermisoUtilizarEmpresa(CAST(@IDUSUARIO AS VARCHAR(MAX)),Com.IdCompania) as hPermiso, 
  SALESUP_CT.dbo.esCanalizado(P.TKP, P.TKPM) AS esCanalizado, CONVERT(VARCHAR(10),P.CANALIZADOEL ,103)AS FechaCanalizado, SALESUP_CT.dbo.ObtieneHora(P.CANALIZADOEL) AS HoraCanalizado, P.USRCANALIZO as Canalizo, P.USRCANALIZADO AS Canalizado,
 
  (SELECT CASE WHEN COUNT(PA1.IDPROSPECTO) > 0 THEN '1' ELSE '' END FROM <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS PA1 WHERE PA1.IDPROSPECTO = P.IDPROSPECTO AND P.IDUSUARIO != PA1.IDUSUARIO) AS COMPARTIDO,
  EI.INDUSTRIA, CG.COMPANIAGRUPO, COM.URL AS URLEMPRESA,COM.DIRECCION1 AS DIRECCIONEMPRESA1, COM.DIRECCION2 AS DIRECCIONEMPRESA2, 
  COM.CIUDAD AS CIUDADEMPRESA,COM.CODIGOPOSTAL AS CPEMPRESA,
  (SELECT ESTADO FROM <#SESSION.DB/>.DBO.ESTADOS WHERE IDESTADO = COM.IDESTADO AND IDPAIS=COM.IDPAIS) AS ESTADOEMPRESA, COM.NEMPLEADOS AS NEMPRESA,
  (SELECT PAIS FROM <#SESSION.DB/>.DBO.PAISES WHERE IDPAIS = COM.IDPAIS) AS PAISEMPRESA, tkInd, Tkcg, 
  COM.TELEFONOCORPORATIVO,
  
  CASE WHEN ISNULL(P.IDCOMPANIA, 0) > 0 THEN '<a href="EmpresasVisualizar.dbsp?tkcom='+com.tkcom+'"><i class="fa fa-building-o"></i> '+COM.EMPRESA+'</a>' ELSE p.EMPRESA END AS EMPRESA,
  CASE WHEN ISNULL(P.IDCOMPANIA, 0) > 0 THEN '<i class="fa fa-building-o"></i>&nbsp;'+COM.EMPRESA ELSE p.EMPRESA END AS EMPRESATXT,

  LEN(ISNULL(P.MOVIL,0)) AS TIENEMOVIL, 
  convert(varchar(12), GETDATE(), @CODIGO) as LA_FECHA_CIERRE,
  CONVERT(VARCHAR, p.CAMPO9,@CODIGO) AS CAMPO9,  CONVERT(VARCHAR, CAMPO10,@CODIGO) AS CAMPO10,  CONVERT(VARCHAR, CAMPO11,@CODIGO) AS CAMPO11,  CONVERT(VARCHAR, CAMPO12,@CODIGO) AS CAMPO12,
  
  P.CAMPO1 AS Campo1P, P.CAMPO2 AS Campo2P, P.CAMPO3 AS Campo3P, P.CAMPO4 AS Campo4P,
  P.CAMPO5 AS Campo5P, P.CAMPO6 AS Campo6P, P.CAMPO7 AS Campo7P, P.CAMPO8 AS Campo8P,
  CASE WHEN P.CAMPO9 IS NOT NULL THEN CONVERT(VARCHAR(10),P.CAMPO9,103) ELSE '' END AS Campo9P,
  CASE WHEN P.CAMPO10 IS NOT NULL THEN CONVERT(VARCHAR(10),P.CAMPO10,103) ELSE '' END AS Campo10P,
  CASE WHEN P.CAMPO11 IS NOT NULL THEN CONVERT(VARCHAR(10),P.CAMPO11,103) ELSE '' END AS Campo11P,
  CASE WHEN P.CAMPO12 IS NOT NULL THEN CONVERT(VARCHAR(10),P.CAMPO12,103) ELSE '' END AS Campo12P,
  P.CAMPO13+' ' AS Campo13P, P.CAMPO14+' ' AS Campo14P, P.CAMPO15+' ' AS Campo15P, P.CAMPO16+' ' AS Campo16P,
  P.CAMPO17+' ' AS Campo17P, P.CAMPO18+' ' AS Campo18P, P.CAMPO19+' ' AS Campo19P, P.CAMPO20+' ' AS Campo20P,
  P.CAMPO21 AS Campo21P, P.CAMPO22 AS Campo22P, P.CAMPO23 AS Campo23P, P.CAMPO24 AS Campo24P,
  P.CAMPO25 AS Campo25P, P.CAMPO26+' ' AS Campo26P, P.CAMPO27+' ' AS Campo27P, P.CAMPO28+' ' AS Campo28P,
  P.CAMPO29+' ' AS Campo29P, P.CAMPO30+' ' AS Campo30P, P.CAMPO31+' ' AS Campo31P, P.CAMPO32+' ' AS Campo32P,
  P.CAMPO33+' ' AS Campo33P, P.CAMPO34+' ' AS Campo34P,
  
  A.ARCHIVADO, P.*, F.FASE,O.ORIGEN, A.IDUSUARIO AS IDUSER, U.IDGRUPO,U.CALENDARIOPAGOS,
  <#SESSION.DB/>.DBO.ValidaEmail(P.CORREO) as ESCORREO ,
  (SELECT ESTADO FROM <#SESSION.DB/>.DBO.ESTADOS WHERE IDESTADO = P.IDESTADO AND IDPAIS=P.IDPAIS) AS ESTADO,
  (SELECT PAIS FROM <#SESSION.DB/>.DBO.PAISES WHERE IDPAIS = P.IDPAIS) AS PAIS,
  P.ETIQUETAS_TXT AS ETIQUETAS, 
  
  (U.NOMBRE + ' ' + U.APELLIDOS) AS AGENTE, U.EMAIL, A.IDUSUARIO AS USUARIO,
  isnull((SELECT IDUSUARIO FROM <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS PA WHERE PA.IDUSUARIO = @IDUSUARIO AND PA.IDPROSPECTO = P.IDPROSPECTO),0) AS asignado,
  <#SESSION.DB/>.dbo.OpcionesMostrar (@IDEMPRESA, @IDPROSPECTO, 0) AS OpcionMostrar, P.APROBACIONESTADO AS APROBACION,
  CASE WHEN COM.IDUSUARIO = @IDUSUARIO THEN '1' ELSE '' END AS COMPROP
  FROM 
    <#SESSION.DB/>.DBO.ObtieneUsuariosAutorizadosModulos (@IDUSUARIO, 1, 0) UL,
	 <#SESSION.DB/>.DBO.PROSPECTOS P
	LEFT JOIN <#SESSION.DB/>.DBO.COMPANIAS COM ON COM.IDCOMPANIA = P.IDCOMPANIA AND COM.IDEMPRESA = @IDEMPRESA
    LEFT JOIN <#SESSION.DB/>.DBO.COMPANIAS_GRUPOS CG ON CG.IDCOMPANIAGRUPO = COM.IDCOMPANIAGRUPO 
    LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_INDUSTRIAS EI ON EI.IDINDUSTRIA = COM.IDINDUSTRIA, 
    <#SESSION.DB/>.DBO.PROSPECTOS_FASES F, 
    <#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES O,
    <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS A, 
    <#SESSION.DB/>.DBO.USUARIOS U
  WHERE 
    UL.ID=A.IDUSUARIO AND
    P.IDPROSPECTO = @IDPROSPECTO
    AND P.IDPROSPECTO = A.IDPROSPECTO
    AND P.IDEMPRESA = @IDEMPRESA 
    AND P.IDFASE = F.IDFASE 
    AND P.IDORIGEN = O.IDORIGEN 
    AND P.IDUSUARIO = U.IDUSUARIO
	
	
	
	
