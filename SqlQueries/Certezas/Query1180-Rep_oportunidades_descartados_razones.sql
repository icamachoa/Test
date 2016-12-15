//[eltipo|Integer,agrupar|Integer,fechadesde|Text,fechahasta|Text,session.db|Untyped,session.idusuario|Untyped,session.idempresa|Untyped,session.convertcode|Untyped,]
-- SELECT 

DECLARE @ELTIPO INT = ISNULL(:ELTIPO,0)
DECLARE @ELFILTRO INT =ISNULL(:AGRUPAR,0)
DECLARE @AIDCRIT VARCHAR(MAX) = ''
DECLARE @FECHADESDE VARCHAR(128) = ISNULL(:FECHADESDE,'')
DECLARE @FECHAHASTA VARCHAR(128) = ISNULL(:FECHAHASTA,'')
DECLARE @AIDCRIT_AGRUPAR VARCHAR(MAX) = ''
DECLARE @ACRIT VARCHAR(MAX) = ''
DECLARE @SQLTXT VARCHAR(MAX) = ''

SELECT @AIDCRIT = (CASE
	WHEN @ELFILTRO = 0 THEN '99999999'
	WHEN @ELFILTRO = 1 THEN 'U.IDGRUPO'
	WHEN @ELFILTRO = 2 THEN 'U.IDUSUARIO'
	WHEN @ELFILTRO = 3 THEN 'F.IDLINEA_PRODUCTO'
	WHEN @ELFILTRO = 4 THEN 'P.IDORIGEN'
	WHEN @ELFILTRO = 5 THEN 'P.IDPAIS'
	WHEN @ELFILTRO = 6 THEN 'E.IDESTADO' END
)

SELECT @ACRIT = (CASE
	WHEN @ELFILTRO = 0 THEN 'RAZONPERDIDA'
	WHEN @ELFILTRO = 1 THEN 'GRUPO'
	WHEN @ELFILTRO = 2 THEN 'u.NOmbre +'' ''+ u.apellidos'
	WHEN @ELFILTRO = 3 THEN 'F.LINEA_PRODUCTO'
	WHEN @ELFILTRO = 4 THEN 'PO.ORIGEN'
	WHEN @ELFILTRO = 5 THEN 'PA.PAIS'
	WHEN @ELFILTRO = 6 THEN 'ESTADO' END
)

SELECT @AIDCRIT_AGRUPAR = (CASE
	WHEN @ELFILTRO = 0 THEN 'R.IDRAZONPERDIDA'
	WHEN @ELFILTRO = 1 THEN 'U.IDGRUPO'
	WHEN @ELFILTRO = 2 THEN 'U.IDUSUARIO'
	WHEN @ELFILTRO = 3 THEN 'F.IDLINEA_PRODUCTO'
	WHEN @ELFILTRO = 4 THEN 'P.IDORIGEN'
	WHEN @ELFILTRO = 5 THEN 'P.IDPAIS'
	WHEN @ELFILTRO = 6 THEN 'E.IDESTADO' END
)

IF @ELTIPO = 2
BEGIN
	SET @SQLTXT = 'SELECT COUNT(*) AS PERDIDAS, '+@AIDCRIT+' AS IDCRIT, '+@ACRIT+' AS CRIT, ISNULL(R.IDRAZONPERDIDA, 0) AS IDRAZONPERDIDA,ISNULL(RAZONPERDIDA, ''Otro'') AS RAZONPERDIDA
	FROM 
	
	 <#SESSION.DB/>.DBO.ObtieneUsuariosAutorizadosModulos (<#SESSION.IDUSUARIO/>,8,0) UL,<#SESSION.DB/>.DBO.PROSPECTOS P 
	 LEFT JOIN <#SESSION.DB/>.DBO.OPORTUNIDADES O  ON P.IDPROSPECTO = O.IDPROSPECTO
	 LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_LINEAS_PRODUCTO F ON  O.IDLINEA_PRODUCTO = F.IDLINEA_PRODUCTO
	 JOIN <#SESSION.DB/>.DBO.USUARIOS U ON U.IDUSUARIO = P.IDUSUARIO
	 JOIN <#SESSION.DB/>.DBO.USUARIOS_GRUPOS G ON U.IDGRUPO = G.IDUSUARIOGRUPO
	 JOIN <#SESSION.DB/>.DBO.PAISES PA on PA.IDPAIS = p.IDPAIS 
	 JOIN <#SESSION.DB/>.DBO.ESTADOS E on E.IDESTADO = p.IDESTADO AND E.IDPAIS = P.IDPAIS
	 JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES PO on PO.IDORIGEN = p.IDORIGEN 
	 LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_RAZONES_PERDIDA R ON P.IDRAZONPERDIDA = R.IDRAZONPERDIDA AND P.IDEMPRESA = R.IDEMPRESA
	   WHERE P.IDEMPRESA = <#SESSION.IDEMPRESA/> AND DESCARTADO = 1 
     			 AND <#SESSION.DB/>.dbo.GetOnlyDate(DESCARTADOFECHA) BETWEEN 
				  CONVERT(DATETIME,'''+@FECHADESDE+''',<#SESSION.CONVERTCODE/>) AND 
				  CONVERT(DATETIME,'''+@FECHAHASTA+''',<#SESSION.CONVERTCODE/>) AND
				  UL.ID=P.IDUSUARIO
	   GROUP BY '+@AIDCRIT_AGRUPAR+', '+@ACRIT+', R.IDRAZONPERDIDA, RAZONPERDIDA
	 ORDER BY
	   3, PERDIDAS'
	  EXEC(@SQLTXT)
END
ELSE
BEGIN
	SET @SQLTXT = 'SELECT COUNT(*) AS PERDIDAS, '+@AIDCRIT+' AS IDCRIT, LTRIM('+@ACRIT+') AS CRIT, ISNULL(R.IDRAZONPERDIDA, 0) AS IDRAZONPERDIDA,ISNULL(RAZONPERDIDA, ''Otro'') AS RAZONPERDIDA
	FROM 
	 <#SESSION.DB/>.DBO.ObtieneUsuariosAutorizadosModulos (<#SESSION.IDUSUARIO/>,8,0) UL,<#SESSION.DB/>.DBO.PROSPECTOS P 
	 JOIN <#SESSION.DB/>.DBO.OPORTUNIDADES O  ON P.IDPROSPECTO = O.IDPROSPECTO
	 JOIN <#SESSION.DB/>.DBO.EMPRESAS_LINEAS_PRODUCTO F ON  O.IDLINEA_PRODUCTO = F.IDLINEA_PRODUCTO
	 JOIN <#SESSION.DB/>.DBO.USUARIOS U ON U.IDUSUARIO = O.IDUSUARIO
	 JOIN <#SESSION.DB/>.DBO.USUARIOS_GRUPOS G ON U.IDGRUPO = G.IDUSUARIOGRUPO
	 JOIN <#SESSION.DB/>.DBO.PAISES PA on PA.IDPAIS = p.IDPAIS 
	 JOIN <#SESSION.DB/>.DBO.ESTADOS E on E.IDESTADO = p.IDESTADO AND E.IDPAIS = P.IDPAIS
	 JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES PO on PO.IDORIGEN = p.IDORIGEN 
	 
	 LEFT JOIN <#SESSION.DB/>.DBO.EMPRESAS_RAZONES_PERDIDA R ON O.IDRAZONPERDIDA = R.IDRAZONPERDIDA AND F.IDEMPRESA = R.IDEMPRESA
   
   WHERE F.IDEMPRESA = <#SESSION.IDEMPRESA/> AND PERDIDA = 1 
     	     AND <#SESSION.DB/>.dbo.GetOnlyDate(PERDIDA_FECHA) BETWEEN 
			  CONVERT(DATETIME,'''+@FECHADESDE+''',<#SESSION.CONVERTCODE/>) AND 
			  CONVERT(DATETIME,'''+@FECHAHASTA+''',<#SESSION.CONVERTCODE/>) AND
			  UL.ID=O.IDUSUARIO
   GROUP BY '+@AIDCRIT_AGRUPAR+', '+@ACRIT+', R.IDRAZONPERDIDA, RAZONPERDIDA, U.IDUSUARIO
 ORDER BY
   3, PERDIDAS'
   EXEC(@SQLTXT)
END