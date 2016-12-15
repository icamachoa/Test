//[session.idempresa|Untyped,session.idusuario|Untyped,session.nivel|Untyped,session.idgrupo|Untyped,session.mailconfig|Untyped,descartado|Text,f_usuario|Text,critarchivar|Text,crit|Text,criterio|Text,session.db|Untyped,]
--select
DECLARE @IDEMPRESA INT , @IDUSUARIO INT, @NIVELUSUARIO INT, @IDGRUPO INT, @MAILCONFIG INT, @Descartado INT
DECLARE @F_USUARIO VARCHAR(MAX)
DECLARE @CRIT VARCHAR(MAX)
DECLARE @CRITARCHIVAR VARCHAR(MAX)
DECLARE @CRITERIO VARCHAR(MAX)
DECLARE @SQL VARCHAR(MAX) 

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @NIVELUSUARIO = CAST('<#SESSION.NIVEL/>' AS INT)
SET @IDGRUPO = CAST('<#SESSION.IDGRUPO/>' AS INT)
SET @MAILCONFIG = CAST('<#SESSION.MAILCONFIG/>' AS INT )
SET @DESCARTADO = CAST(ISNULL(:DESCARTADO,'') AS INT)
SET @F_USUARIO=ISNULL(:F_USUARIO,'')
SET @CRITARCHIVAR=ISNULL(:CRITARCHIVAR,'')
SELECT @CRIT=ISNULL(:CRIT,'')
SET @CRITERIO=ISNULL(:CRITERIO,'')

SET @SQL='
SELECT COUNT (dISTINCT( ISNULL(P.idcompania,0) ) )  AS TotalResgistros  
  
  FROM 
  
    <#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES PO 
	JOIN <#SESSION.DB/>.DBO.PROSPECTOS P ON P.IDORIGEN = PO.IDORIGEN 
	JOIN  <#SESSION.DB/>.DBO.PROSPECTOS_FASES F WITH(NOLOCK) ON P.IDFASE = F.IDFASE 
	LEFT JOIN <#SESSION.DB/>.DBO.OPORTUNIDADES O ON P.IDPROSPECTO = O.IDPROSPECTO 
    LEFT JOIN <#SESSION.DB/>.DBO.VENTAS V ON O.IDOPORTUNIDAD = V.IDOPORTUNIDAD 
    JOIN  <#SESSION.DB/>.DBO.USUARIOS U ON P.IDUSUARIO = U.IDUSUARIO
	JOIN <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO PS WITH(NOLOCK) ON PS.IDSEGUIMIENTO = P.IDULTIMOSEGUIMIENTO
	JOIN <#SESSION.DB/>.DBO.USUARIOS U1 ON U1.IDUSUARIO = PS.IDUSUARIO
	LEFT  JOIN <#SESSION.DB/>.dbo.COMPANIAS COM WITH(NOLOCK) ON COM.IDCOMPANIA = P.IDCOMPANIA
    LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_INDUSTRIAS EI WITH(NOLOCK) ON EI.IDINDUSTRIA = COM.IDINDUSTRIA
    LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS_GRUPOS CG WITH(NOLOCK) ON CG.IDCOMPANIAGRUPO = COM.IDCOMPANIAGRUPO,
    <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS A 
  WHERE  
    P.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(1000))+' AND P.ESCLIENTE =1 AND 
    P.IDPROSPECTO = A.IDPROSPECTO
	'+@CRITERIO+' '+@CRIT+' '+@CRITARCHIVAR+' '+@F_USUARIO+'
	
  '
 EXEC(@SQL) 

