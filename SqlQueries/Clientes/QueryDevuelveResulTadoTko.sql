//[criterio|Text,crit|Text,f_usuario|Text,critarchivar|Text,porempresa|Text,porcatalogo|Text,idpantalla|Integer,tkcom|Text,session.idempresa|Untyped,session.idusuario|Untyped,session.nivel|Untyped,session.db|Untyped,session.idgrupo|Untyped,session.mailconfig|Untyped,descartado|Text,]
--select
DECLARE @SQL VARCHAR(MAX)
DECLARE @CRITERIO VARCHAR(MAX)
DECLARE @CRIT VARCHAR(MAX)
DECLARE @F_USUARIO VARCHAR(MAX)
DECLARE @CRITARCHIVAR VARCHAR(MAX)
DECLARE @POREMPRESA VARCHAR(MAX)
DECLARE @PORCATALOGO VARCHAR(MAX)

SET @CRITERIO=ISNULL(:CRITERIO,'')
SET @CRIT=ISNULL(:CRIT,'')
SET @F_USUARIO=ISNULL(:F_USUARIO,'')
SET @CRITARCHIVAR=ISNULL(:CRITARCHIVAR,'')
SET @POREMPRESA=ISNULL(:POREMPRESA,'')
SET @PORCATALOGO=ISNULL(:PORCATALOGO,'')

DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @NIVELUSUARIO INT
DECLARE @IDGRUPO INT
DECLARE @MAILCONFIG INT
DECLARE @Descartado INT
--DECLARE @IDCOMPANIA INT
DECLARE @TkCom VARCHAR(64)

DECLARE @IDPANTALLA INT SET @IDPANTALLA = ISNULL(:IDPANTALLA,4)
DECLARE @DBNAME VARCHAR(MAX)
SET @TkCom = isnull(:TKCOM,'')
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @NIVELUSUARIO = <#SESSION.NIVEL/>
SET @DBNAME = '<#SESSION.DB/>'
SET @IDGRUPO = <#SESSION.IDGRUPO/>
SET @MAILCONFIG = <#SESSION.MAILCONFIG/>
SET @DESCARTADO = CAST(ISNULL(:DESCARTADO,'') AS INT)
SET @POREMPRESA=ISNULL(:PorEmpresa,'')
--SET @IDCOMPANIA = 0

 DECLARE @APROBADO VARCHAR(10)
 DECLARE @TABLADEFILTROS TABLE(ID INT, VAL VARCHAR(MAX))
 
SET @TkCom = CAST(ISNULL(:TKCOM,' ')  AS VARCHAR(MAX))

DECLARE @PORTKCOM VARCHAR(MAX)
SET @PORTKCOM = ''
--DECLARE @IDCOMPANIA INT;
--SET @IDCOMPANIA = 0
IF @TkCom != ''
BEGIN
   --SELECT @IDCOMPANIA  = IDCOMPANIA FROM <#SESSION.DB/>.dbo.COMPANIAS WHERE TKCOM = @TkCom
   SET @PORTKCOM = ' AND COM.TKCOM = '''+CAST(@TkCom AS VARCHAR(MAX))+''' '
END
  
  INSERT INTO @TABLADEFILTROS
  SELECT * FROM <#SESSION.DB/>.dbo.filtrospantallas(@IDPANTALLA, @IDEMPRESA, @IDUSUARIO)

  SELECT
    @CRIT = <#SESSION.DB/>.DBO.UDF_CONSTRUYE_FILTRO(@IDUSUARIO, CAST(RTRIM(LTRIM(@IDPANTALLA)) AS int))
  SELECT
      @CRIT = @CRIT + <#SESSION.DB/>.DBO.UDF_CONSTRUYE_FILTRO(@IDUSUARIO, 15)

  SELECT @F_USUARIO = VAL
  FROM @TABLADEFILTROS
  WHERE ID = 1
  
  SELECT @CRITARCHIVAR = VAL
  FROM @TABLADEFILTROS
  WHERE ID = 2
  
  SELECT @DESCARTADO = VAL
  FROM @TABLADEFILTROS
  WHERE ID = 3

  SELECT @APROBADO = VAL
  FROM @TABLADEFILTROS
  WHERE ID = 5
/*
IF @TkCom != ''''
BEGIN
   SELECT @IDCOMPANIA = IDCOMPANIA FROM <#SESSION.DB/>.dbo.COMPANIAS WHERE TKCOM = @TkCom
END
*/

IF @F_USUARIO IS NOT NULL AND @TKCOM != ''
  BEGIN
    DECLARE @IDSUSUARIOS VARCHAR(MAX)
    SET @IDSUSUARIOS = ''
    SELECT @IDSUSUARIOS=CAST(ID AS VARCHAR(1000))+','+@IDSUSUARIOS FROM <#SESSION.DB/>.DBO.ObtieneUsuariosAutorizadosModulos (@IDUSUARIO,@IDPANTALLA,0)
    SET @IDSUSUARIOS=@IDSUSUARIOS+'0'
    SET @F_USUARIO = ' AND ( (P.IDUSUARIO IN('+@IDSUSUARIOS+')))'
  END

SET @SQL='


SELECT 
    DISTINCT P.TKP as TKP  
  FROM 
  
    <#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES PO WITH(NOLOCK)
  JOIN <#SESSION.DB/>.DBO.PROSPECTOS P WITH(NOLOCK) ON P.IDORIGEN = PO.IDORIGEN 
  JOIN  <#SESSION.DB/>.DBO.PROSPECTOS_FASES F WITH(NOLOCK) ON P.IDFASE = F.IDFASE 
    LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS A2 WITH(NOLOCK) ON A2.IDPROSPECTO = P.IDPROSPECTO AND A2.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(MAX))+'
  

    LEFT JOIN <#SESSION.DB/>.DBO.OPORTUNIDADES O WITH(NOLOCK) ON P.IDPROSPECTO = O.IDPROSPECTO 
    LEFT JOIN <#SESSION.DB/>.DBO.VENTAS V WITH(NOLOCK) ON O.IDOPORTUNIDAD = V.IDOPORTUNIDAD
  LEFT JOIN <#SESSION.DB/>.DBO.VENTAS_COBROS VC WITH(NOLOCK) ON VC.PAGADO = 0 AND VC.FECHAHORA < GETDATE() AND VC.IDVENTA = V.IDVENTA
  LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS COM WITH(NOLOCK) ON COM.IDCOMPANIA = P.IDCOMPANIA
    JOIN  <#SESSION.DB/>.DBO.USUARIOS U WITH(NOLOCK) ON P.IDUSUARIO = U.IDUSUARIO
  JOIN <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO PS WITH(NOLOCK) ON PS.IDSEGUIMIENTO = P.IDULTIMOSEGUIMIENTO
  JOIN <#SESSION.DB/>.DBO.USUARIOS U1 WITH(NOLOCK) ON U1.IDUSUARIO = PS.IDUSUARIO
    JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS A WITH(NOLOCK) ON P.IDPROSPECTO = A.IDPROSPECTO
    
  LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_INDUSTRIAS CatI WITH(NOLOCK) ON CatI.IDINDUSTRIA = COM.IDINDUSTRIA      
  LEFT JOIN <#SESSION.DB/>.DBO.COMPANIAS_GRUPOS CatG WITH(NOLOCK) ON CatG.IDCOMPANIAGRUPO = COM.IDCOMPANIAGRUPO         
  
  WHERE  
    P.IDEMPRESA ='+CAST(@IDEMPRESA AS VARCHAR(MAX))+' AND P.ESCLIENTE =1  AND P.APROBACIONESTADO '+CAST(@APROBADO AS VARCHAR(MAX))+'
     '+CAST(@CRIT AS VARCHAR(MAX))+ ' '+CAST(@F_USUARIO AS VARCHAR(MAX))+ ' '+CAST(@CRITARCHIVAR AS VARCHAR(MAX))+ ' '+CAST(@POREMPRESA AS VARCHAR(MAX))+ ' '+CAST(@PORCATALOGO AS VARCHAR(MAX))+ ' '+CAST(@PORTKCOM AS VARCHAR(MAX))+'
    

'

EXEC (@SQL)