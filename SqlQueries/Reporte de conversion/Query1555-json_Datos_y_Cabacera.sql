//[session.idempresa|Untyped,session.idusuario|Untyped,reporteconfig|Text,session.convertcode|Untyped,anio|Integer,fecha_inicio|Text,fecha_fin|Text,tipodatos|Integer,session.db|Untyped,]
--SELECT 

/*PROTEGIDO*/
DECLARE @SESSION_IDEMPRESA INT
DECLARE @SESSION_IDUSUARIO INT
DECLARE @IDREPORTECONFIG INT
DECLARE @PERIODO INT
DECLARE @FECHA_INICIO DATETIME
DECLARE @FECHA_FIN DATETIME
DECLARE @TIPO_REPORTE INT
DECLARE @ANIO INT
DECLARE @CONVERTCODE INT 
DECLARE @FINICIO VARCHAR (128)
DECLARE @FFIN VARCHAR (128)
DECLARE @TIPODATOS INT 



SET @SESSION_IDEMPRESA=CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @SESSION_IDUSUARIO=CAST('<#SESSION.IDUSUARIO/>' AS INT)
 IF(:REPORTECONFIG = 'null') 
 	SET @IDREPORTECONFIG=0 
 ELSE 
 	  SET @IDREPORTECONFIG= CAST(:REPORTECONFIG AS INT) 

SET @CONVERTCODE ='<#SESSION.CONVERTCODE/>'

SET @ANIO =  :ANIO 
SET @FINICIO=:FECHA_INICIO
SET @FFIN= :FECHA_FIN
SET @TIPODATOS=:TIPODATOS

IF(@ANIO > 0)
BEGIN
	 SET @FECHA_INICIO= CONVERT(DATETIME,'01/01/'+CAST(@ANIO AS VARCHAR),103)
   	 SET @FECHA_FIN=DATEADD(SS,-1,CONVERT(DATETIME,CONVERT(VARCHAR(10),CONVERT(DATETIME,'31/12/'+CAST(@ANIO AS VARCHAR),103)+1,103),103))
END
ELSE
BEGIN
	 SET @FECHA_INICIO= CONVERT(DATETIME,@FINICIO,@CONVERTCODE)
   	 SET @FECHA_FIN=DATEADD(SS,-1,CONVERT(DATETIME,CONVERT(VARCHAR(10),CONVERT(DATETIME,@FFIN,@CONVERTCODE)+1,@CONVERTCODE),@CONVERTCODE))
END

SET @TIPO_REPORTE = CAST(@TIPODATOS AS INT) /* 0 CABECERA, 1 DATOS, 2 TOTALES */
IF(@IDREPORTECONFIG>0)
  BEGIN
   BEGIN TRY
	EXEC  <#SESSION.DB/>.DBO.SP_REPORTE_EMBUDO_Y_CONVERSIONES @SESSION_IDEMPRESA,@SESSION_IDUSUARIO, @IDREPORTECONFIG, @FECHA_INICIO,@FECHA_FIN,@TIPO_REPORTE
   END TRY
   BEGIN CATCH
     SELECT 0 AS EXISTE
   END CATCH	
  END	
ELSE
  SELECT 0 AS EXISTE
	
