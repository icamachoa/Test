//[session.idempresa|Untyped,session.idusuario|Untyped,idu|Text,fechaactual|Text,r|Text,session.db|Untyped,condicionrecordatorios|Text,]
--SELECT 
DECLARE @SQL VARCHAR(MAX)
DECLARE @CRIT VARCHAR(MAX) SET @CRIT = ISNULL( :CONDICIONRECORDATORIOS , '')

SET @SQL = '
 DECLARE @MESACTUAL VARCHAR(MAX), @IDUSUARIO VARCHAR(MAX)
 DECLARE @FECHA DATETIME, @FINICIO DATETIME, @FFIN DATETIME
 DECLARE @RANGO INT, @IDEMPRESA INT, @SESSIONIDUSUARIO INT

 SET @IDEMPRESA = CAST(''<#SESSION.IDEMPRESA/>'' AS INT)
 SET @SESSIONIDUSUARIO = CAST(''<#SESSION.IDUSUARIO/>'' AS INT)
 SET @IDUSUARIO = ''' + ISNULL( :IDU , '') + '''
  SET @MESACTUAL = ''' + ISNULL( :FechaActual, '') +'''
 SET @RANGO = CAST(   ''' +  ISNULL(  :R , '') + '''  AS INT)

 IF @MESACTUAL != ''''
 BEGIN
	SET @FECHA = CONVERT(DATETIME, @MESACTUAL, 103 )
	SET @FINICIO = SALESUP_CT.dbo.RangoFecha(0, 5, @FECHA)
	SET @FFIN = SALESUP_CT.dbo.RangoFecha(1, 5, @FECHA)
 END
 ELSE
 BEGIN
	SET @FINICIO = SALESUP_CT.dbo.RangoFecha(0, @RANGO, NULL)
	SET @FFIN = SALESUP_CT.dbo.RangoFecha(1, @RANGO, NULL)
 END

 SELECT COUNT(*) AS Registros
 FROM <#SESSION.DB/>.dbo.RECORDATORIOS R 
 LEFT JOIN <#SESSION.DB/>.dbo.PROSPECTOS P ON P.IDPROSPECTO = R.IDPROSPECTO
 LEFT JOIN <#SESSION.DB/>.dbo.OPORTUNIDADES O ON O.IDOPORTUNIDAD = R.IDOPORTUNIDAD
 JOIN <#SESSION.DB/>.dbo.USUARIOS U ON U.IDUSUARIO = R.IDUSUARIO
 LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS COM ON COM.IDCOMPANIA = P.IDCOMPANIA
 JOIN <#SESSION.DB/>.dbo.ObtieneUsuariosAutorizadosModulos (<#SESSION.IDUSUARIO/>,7,0) UP ON U.IDUSUARIO = UP.ID
 WHERE R.COMPLETADO=0 AND U.IDEMPRESA = @IDEMPRESA 
 ' + @CRIT
EXEC (@SQL)
