//[tkcom|Text,session.idempresa|Untyped,session.idusuario|Untyped,session.nivel|Untyped,session.idgrupo|Untyped,session.db|Untyped,f_usuario|Text,crit|Text,]
--select

DECLARE @IDEMPRESA INT , @IDUSUARIO INT, @NIVELUSUARIO INT, @IDGRUPO INT,@IDCOMPANIA INT
DECLARE @TkCom VARCHAR(64)
DECLARE @F_USUARIO VARCHAR(MAX)
DECLARE @SQL VARCHAR(MAX)
DECLARE @CRIT VARCHAR(MAX)
SET @TkCom = dbo.ValidaToken(isnull(:TKCOM,''))
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @NIVELUSUARIO = CAST('<#SESSION.NIVEL/>' AS INT)
SET @IDGRUPO = CAST('<#SESSION.IDGRUPO/>' AS INT)
SET @F_USUARIO = ISNULL(:F_USUARIO,'')
SET @CRIT = ISNULL(:CRIT, '')

SET @IDCOMPANIA = 0
IF @TkCom != ''
BEGIN
	 SELECT @IDCOMPANIA = IDCOMPANIA FROM <#SESSION.DB/>.dbo.COMPANIAS WHERE TKCOM = @TkCom
END

/*  OR @NIVELUSUARIO <= 2 OR @NIVELUSUARIO = 1 AND (@NIVELUSUARIO = 2 AND @IDGRUPO = U.IDGRUPO) */
SET @SQL='
SELECT /*TOP 50*/
  1 AS R,
  V.TKV AS Tkv, O.TKO AS Tko,
  SALESUP_CT.dbo.VerLtArchivos(P.IDPROSPECTO, P.NARCHIVOS, O.IDOPORTUNIDAD, O.NARCHIVOS)  AS VerArchivos,
  P.IdProspecto, V.IdVenta, V.IdOportunidad,
  ISNULL(PA.IDUSUARIO, 0) AS asignado,
  CASE WHEN V.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' OR  P.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' OR PA.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' THEN ''true'' ELSE '''' END AS tOportunidad,
  CASE WHEN V.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' OR  P.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' OR PA.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' OR '+CAST(@NIVELUSUARIO AS VARCHAR(1000))+' <= 2 THEN ''true'' ELSE '''' END AS tEtiquetar,
  CASE WHEN V.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' OR  P.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' OR '+CAST(@NIVELUSUARIO AS VARCHAR(1000))+' <= 2 OR '+CAST(@IDGRUPO AS VARCHAR(1000))+' = U.IDGRUPO THEN ''true'' ELSE '''' END AS tCancelar,
  LTRIM(RTRIM(P.NOMBRE))+'' ''+ISNULL(LTRIM(RTRIM(P.APELLIDOS)),'''') AS NombreCliente, O.Concepto, 
  V.Anticipos_Monto AS AnticiposMonto, V.Anticipos_Comision AS AnticiposComision,  CAST(Referencia AS VARCHAR(MAX)) AS Referencia,
  CASE WHEN ISNULL(ANTICIPOS_MONTO, 0) != 0 THEN ANTICIPOS_COMISION/ANTICIPOS_MONTO ELSE 0 END AS PorcentajeComision,
  V.SALDO_MONTO AS SaldoMonto, V.MONTO as Monto, GANADA_FECHA AS GanadaFecha, 
  /*CONVERT(VARCHAR(10),V.FechaHora,103) AS FechaHora,*/
  /*CONVERT(VARCHAR(10),V.FECHAHORA,103) AS PagadaFechaFechaHora,*/
  
  CONVERT(VARCHAR(10),V.FECHAHORA,103) AS Pagada_Fecha,
  
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
  CP25.OPCION AS cp25
  
FROM 
<#SESSION.DB/>.DBO.VENTAS V, <#SESSION.DB/>.DBO.OPORTUNIDADES O, 
<#SESSION.DB/>.DBO.PROSPECTOS P 
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP21 ON CP21.IDOPCION = P.CAMPO21
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP22 ON CP22.IDOPCION = P.CAMPO22
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP23 ON CP23.IDOPCION = P.CAMPO23
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP24 ON CP24.IDOPCION = P.CAMPO24
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES CP25 ON CP25.IDOPCION = P.CAMPO25
LEFT JOIN <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS PA ON PA.IDUSUARIO = '+CAST(@IDUSUARIO AS VARCHAR(1000))+' AND P.IDPROSPECTO = PA.IDPROSPECTO, 
<#SESSION.DB/>.DBO.OPORTUNIDADES_FASES F,
<#SESSION.DB/>.DBO.USUARIOS U, <#SESSION.DB/>.DBO.EMPRESAS_LINEAS_PRODUCTO LP, 
<#SESSION.DB/>.DBO.PROSPECTOS_ORIGENES PO

WHERE
  V.IDOPORTUNIDAD = O.IDOPORTUNIDAD AND
  O.IDPROSPECTO = P.IDPROSPECTO AND
  P.DESCARTADO = 0 AND v.IDUSUARIO = U.IDUSUARIO AND   
  O.IDFASE = F.IDFASE AND
  O.IDLINEA_PRODUCTO = LP.IDLINEA_PRODUCTO AND P.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(1000))+'
  AND P.IDORIGEN = PO.IDORIGEN AND P.IDCOMPANIA = '+CAST(@IDCOMPANIA AS VARCHAR(1000))+'
  '+@F_USUARIO+'
  '+@CRIT+'
ORDER BY V.FECHAHORA DESC
'
EXEC (@SQL)



