//[session.idusuario|Untyped,idu|Text,fechaactual|Text,r|Integer,session.idempresa|Untyped,00|Text,session.db|Untyped,condicioncobrospendientes|Text,]
--SELECT 
/*PROTEGIDO*/
DECLARE @SQL VARCHAR(MAX)
DECLARE @CONDICIONCOBROSPENDIENTES VARCHAR(MAX)
DECLARE @CERO VARCHAR(1000)
SET @CONDICIONCOBROSPENDIENTES=ISNULL(:CONDICIONCOBROSPENDIENTES,'')
SET @CERO = '00:00'
SET @SQL ='
DECLARE @MESACTUAL VARCHAR(MAX), @IDUSUARIO VARCHAR(MAX)
DECLARE @FECHA DATETIME, @FINICIO DATETIME, @FFIN DATETIME, @HOY DATETIME, @HOYREAL DATETIME
DECLARE @RANGO INT, @IDEMPRESA INT, @SESSIONIDUSUARIO INT

SET @SESSIONIDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDUSUARIO = '''+ISNULL(:IDU,'')+'''
SET @MESACTUAL = '''+ISNULL(:FechaActual,'')+'''
SET @RANGO = '+CAST(ISNULL(:R,0) AS VARCHAR(1000))+'
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>

IF @MESACTUAL != ''''
BEGIN
	SET @FECHA = CONVERT(DATETIME, @MESACTUAL, 103 )
	SET @FINICIO = SALESUP_CT.dbo.RangoFecha(0, 5, @FECHA)
	SET @FFIN = SALESUP_CT.dbo.RangoFecha(1, 5, @FECHA)
	SET @FINICIO = DATEADD(dd, -6, @FINICIO)
	SET @FFIN = DATEADD(dd, 6, @FFIN)
END
ELSE
BEGIN
	SET @FINICIO = SALESUP_CT.dbo.RangoFecha(0, @RANGO, NULL)
	SET @FFIN = SALESUP_CT.dbo.RangoFecha(1, @RANGO, NULL)
END

SET @HOY = GETDATE()
SET @HOYREAL = SALESUP_CT.DBO.GETONLYDATE(GETDATE())
IF MONTH(@HOY) != MONTH(@FINICIO)
   SET @HOY = @FFIN


SELECT 
   ''1'' as CobrosPendientes, 4 AS Tipo, ''#dc0f24'' as color, ''#ffffff'' as textColor, ''CV''+CAST(VC.IDVENTACOBRO AS VARCHAR(MAX)) AS id, ''Cobro vencido'' as title, 
  ''Pointer CobrosPendientes'' AS className, SALESUP_CT.DBO.Fecha(VC.FECHAHORA) as start, ''true'' as allDay, 
  CASE WHEN SALESUP_CT.dbo.ObtieneHora(VC.FECHAHORA) = '''+@CERO+''' THEN ''-'' ELSE SALESUP_CT.dbo.ObtieneHora(VC.FECHAHORA) END AS Hora, 
  CONVERT(VARCHAR(10), VC.FECHAHORA,103) as Fecha,
  O.CONCEPTO AS Concepto, VC.NOPARCIALIDAD AS NoParcialidad, V.NOPARCIALIDADES AS Parcialidades, VC.Monto,
  P.NOMBRE + '' ''+ ISNULL(P.APELLIDOS,'''') AS Prospecto, 
  U.NOMBRE + '' ''+ U.APELLIDOS AS Responsable, U.INICIALES AS Para, U.NOMBRE + '' ''+ U.APELLIDOS AS NomPara,
  CASE WHEN ISNULL(P.IDCOMPANIA,0)=0 THEN P.EMPRESA ELSE COM.EMPRESA END AS Empresa, 
  ''Por cobrar'' as Estado, O.IDOPORTUNIDAD as ido, V.IDVENTA AS Idv, V.IDVENTA AS IdVenta, V.Tkv,
  COM.TkCom, P.Tkp, P.IdProspecto, O.IdOportunidad, O.Tko, CASE P.EsCliente WHEN 1 THEN ''1'' ELSE '''' END AS EsCliente,
  1 AS Vencido,'''' AS Acciones, CONVERT(FLOAT, VC.FECHAHORA) AS DTF
  
FROM 
<#SESSION.DB/>.DBO.VENTAS_COBROS VC WITH(NOLOCK),
<#SESSION.DB/>.DBO.VENTAS V WITH(NOLOCK),
<#SESSION.DB/>.DBO.OPORTUNIDADES O WITH(NOLOCK), 
<#SESSION.DB/>.DBO.PROSPECTOS P WITH(NOLOCK) LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS COM ON COM.IDCOMPANIA = P.IDCOMPANIA ,
<#SESSION.DB/>.DBO.USUARIOS U WITH(NOLOCK),
<#SESSION.DB/>.dbo.ObtieneUsuariosAutorizadosModulos (@SESSIONIDUSUARIO,3,0) UP
WHERE 
  	  P.IDEMPRESA = @IDEMPRESA 
  AND U.IDEMPRESA = P.IDEMPRESA 
  AND VC.IDVENTA = V.IDVENTA 
  AND V.IDOPORTUNIDAD = O.IDOPORTUNIDAD
  AND O.IDPROSPECTO = P.IDPROSPECTO 
  AND P.IDUSUARIO = U.IDUSUARIO
  AND VC.PAGADO = 0 
  AND  UP.ID = U.IDUSUARIO
  AND VC.FECHAHORA <= @HOYREAL
 '+@CONDICIONCOBROSPENDIENTES+'
  ORDER BY VC.fechahora 
  '
  EXEC (@SQL)
 

