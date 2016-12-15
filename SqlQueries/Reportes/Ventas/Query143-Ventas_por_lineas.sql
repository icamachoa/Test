//[session.idusuario|Untyped,session.idempresa|Untyped,elanio|Integer,session.db|Untyped,filtro_grupo|Text,]
--SELECT 
/*PROTEGIDO*/

DECLARE @IDUSUARIO INT 
DECLARE @IDEMPRESA INT 
DECLARE @ELANIO INT
DECLARE @SQLTEXT VARCHAR(MAX) 
DECLARE @SESSIONDB VARCHAR(128)
DECLARE @FILTRO_GRUPO VARCHAR(MAX) 

SET @IDUSUARIO= <#SESSION.IDUSUARIO/> 
SET @IDEMPRESA=<#SESSION.IDEMPRESA/>
SET @ELANIO=ISNULL(:ELANIO, 0)
SET @SESSIONDB='<#SESSION.DB/>' 
SET @FILTRO_GRUPO=:FILTRO_GRUPO  
SELECT  @FILTRO_GRUPO= CASE WHEN  @FILTRO_GRUPO IS NULL THEN '' ELSE ' AND '+@FILTRO_GRUPO END
   
SET   @SQLTEXT='     
    SELECT L.IDLINEA_PRODUCTO, L.LINEA_PRODUCTO, 
      SUM (CASE WHEN MONTH(V.FECHAHORA)=1 THEN V.MONTO ELSE 0 END) AS MONTO_ENE,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=2 THEN V.MONTO ELSE 0 END) AS MONTO_FEB,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=3 THEN V.MONTO ELSE 0 END) AS MONTO_MAR,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=4 THEN V.MONTO ELSE 0 END) AS MONTO_ABR,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=5 THEN V.MONTO ELSE 0 END) AS MONTO_MAY,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=6 THEN V.MONTO ELSE 0 END) AS MONTO_JUN,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=7 THEN V.MONTO ELSE 0 END) AS MONTO_JUL,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=8 THEN V.MONTO ELSE 0 END) AS MONTO_AGO,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=9 THEN V.MONTO ELSE 0 END) AS MONTO_SEP,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=10 THEN V.MONTO ELSE 0 END) AS MONTO_OCT,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=11 THEN V.MONTO ELSE 0 END) AS MONTO_NOV,
      SUM (CASE WHEN MONTH(V.FECHAHORA)=12 THEN V.MONTO ELSE 0 END) AS MONTO_DIC,
      SUM (V.MONTO) AS MONTO_TOTAL
    
    FROM  '+@SESSIONDB+'.DBO.ObtieneUsuariosAutorizadosModulos('+CAST(@IDUSUARIO AS VARCHAR(1000))+',8,0) UL,
	      '+@SESSIONDB+'.DBO.EMPRESAS_LINEAS_PRODUCTO L,  
	      '+@SESSIONDB+'.DBO.USUARIOS U,  
	      '+@SESSIONDB+'.DBO.PROSPECTOS P,
	      '+@SESSIONDB+'.DBO.OPORTUNIDADES O,  
	      '+@SESSIONDB+'.DBO.VENTAS V
    
    WHERE 
	   UL.ID=U.IDUSUARIO 
	   AND L.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(1000))+' 
	   AND L.IDEMPRESA = U.IDEMPRESA 
	   AND L.IDLINEA_PRODUCTO = O.IDLINEA_PRODUCTO 
	   AND U.IDUSUARIO = v.IDUSUARIO  
	   AND P.IDPROSPECTO = O.IDPROSPECTO 
	   AND O.IDOPORTUNIDAD = V.IDOPORTUNIDAD 
	   AND YEAR (V.FECHAHORA) ='+CAST(@ELANIO AS VARCHAR(1000))+' 
	   AND O.GANADA != 0
	   '+@FILTRO_GRUPO+'

    GROUP BY L.IDLINEA_PRODUCTO, L.LINEA_PRODUCTO
    ORDER BY MONTO_TOTAL DESC'
	
	EXEC (@SQLTEXT)