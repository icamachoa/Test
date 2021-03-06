//[idprospecto|Text,idprostrcc|Text,idprostrcco|Text,session.db|Untyped,session.idusuario|Untyped,]
--select
DECLARE @IDPROSPECTOS VARCHAR(8000)
DECLARE @IDPROSPECTOSCC VARCHAR(8000)
DECLARE @IDPROSPECTOSCCO VARCHAR(8000)
SET @IDPROSPECTOS=isnull(:IDPROSPECTO,'')
SET @IDPROSPECTOSCC=ISNULL(:idprostrCC,'')
SET @IDPROSPECTOSCCO=ISNULL(:idprostrCCO,'')

DECLARE @TABLAPROSPECTOS AS TABLE (ID INT IDENTITY, IDPROSPECTO INT, CORREOPROSPECTO VARCHAR(1000), NOMBREPROSPECTO VARCHAR(8000), TAGCORREO AS NOMBREPROSPECTO+ ' ['+CORREOPROSPECTO+']')
DECLARE @TABLAPROSPECTOSCC AS TABLE (ID INT IDENTITY, IDPROSPECTO INT, CORREOPROSPECTO VARCHAR(1000), NOMBREPROSPECTO VARCHAR(8000), TAGCORREO AS NOMBREPROSPECTO+ ' ['+CORREOPROSPECTO+']')
DECLARE @TABLAPROSPECTOSCCO AS TABLE (ID INT IDENTITY, IDPROSPECTO INT, CORREOPROSPECTO VARCHAR(1000), NOMBREPROSPECTO VARCHAR(8000), TAGCORREO AS NOMBREPROSPECTO+ ' ['+CORREOPROSPECTO+']')
DECLARE @PRIMERPROSPECTO VARCHAR(100)
SET @PRIMERPROSPECTO = ''
DECLARE @INFOPROSPECTOS VARCHAR(MAX) 
SET @INFOPROSPECTOS = ''
DECLARE @INFOPROSPECTOSCC VARCHAR(MAX) 
SET @INFOPROSPECTOSCC = ''
DECLARE @INFOPROSPECTOSCCO VARCHAR(MAX) 
SET @INFOPROSPECTOSCCO = ''
DECLARE @INFOTIPSY VARCHAR(MAX)
SET @INFOTIPSY = ''
DECLARE @INFOTIPSYCC VARCHAR(MAX) 
SET @INFOTIPSYCC = ''
DECLARE @INFOTIPSYCCO VARCHAR(MAX) 
SET @INFOTIPSYCCO = ''
DECLARE @CORREOSPROSPECTOS VARCHAR(MAX)
SET @CORREOSPROSPECTOS = ''
DECLARE @CORREOSPROSPECTOSCC VARCHAR(MAX) 
SET @CORREOSPROSPECTOSCC = ''
DECLARE @CORREOSPROSPECTOSCCO VARCHAR(MAX) 
SET @CORREOSPROSPECTOSCCO = ''
DECLARE @TOTAL INT 
SET @TOTAL = 0
DECLARE @TOTALCC INT 
SET @TOTALCC = 0
DECLARE @TOTALCCO INT 
SET @TOTALCCO = 0

INSERT INTO @TABLAPROSPECTOS (IDPROSPECTO,CORREOPROSPECTO,NOMBREPROSPECTO)
select IDPROSPECTO,CORREO,ISNULL(NOMBRE,'')+' '+ISNULL(APELLIDOS,'') 
	from <#SESSION.DB/>.DBO.PROSPECTOS where IDPROSPECTO in (select splitvalue from <#SESSION.DB/>.DBO.Split(@IDPROSPECTOS,',')) and  correo is not null

INSERT INTO @TABLAPROSPECTOSCC (IDPROSPECTO,CORREOPROSPECTO,NOMBREPROSPECTO)
select IDPROSPECTO,CORREO,ISNULL(NOMBRE,'')+' '+ISNULL(APELLIDOS,'') 
	from <#SESSION.DB/>.DBO.PROSPECTOS where IDPROSPECTO in (select splitvalue from <#SESSION.DB/>.DBO.Split(@IDPROSPECTOSCC,',')) and  correo is not null
	 
INSERT INTO @TABLAPROSPECTOSCCO (IDPROSPECTO,CORREOPROSPECTO,NOMBREPROSPECTO)
select IDPROSPECTO,CORREO,ISNULL(NOMBRE,'')+' '+ISNULL(APELLIDOS,'') 
	from <#SESSION.DB/>.DBO.PROSPECTOS where IDPROSPECTO in (select splitvalue from <#SESSION.DB/>.DBO.Split(@IDPROSPECTOSCCO,',')) and  correo is not null
--SELECT * FROM @TABLAPROSPECTOSCCO 
	
SELECT TOP 1 @PRIMERPROSPECTO=IDPROSPECTO FROM @TABLAPROSPECTOS ORDER BY ID ASC
SELECT @TOTAL=COUNT(*) FROM @TABLAPROSPECTOS
SELECT @INFOPROSPECTOS=@INFOPROSPECTOS+TAGCORREO+', ', @INFOTIPSY=@INFOTIPSY+TAGCORREO+',<br /> ',  @CORREOSPROSPECTOS=@CORREOSPROSPECTOS+CORREOPROSPECTO+', ' FROM @TABLAPROSPECTOS
SELECT @INFOPROSPECTOS=SUBSTRING(LTRIM(RTRIM(@INFOPROSPECTOS)),0,LEN(LTRIM(RTRIM(@INFOPROSPECTOS)))),@CORREOSPROSPECTOS=SUBSTRING(LTRIM(RTRIM(@CORREOSPROSPECTOS)),0,LEN(LTRIM(RTRIM(@CORREOSPROSPECTOS))))

SELECT @TOTALCC=COUNT(*) FROM @TABLAPROSPECTOSCC
SELECT @INFOPROSPECTOSCC=@INFOPROSPECTOSCC+TAGCORREO+',', @INFOTIPSYCC=@INFOTIPSYCC+TAGCORREO+',<br /> ', @CORREOSPROSPECTOSCC=@CORREOSPROSPECTOSCC+CORREOPROSPECTO+', '  FROM @TABLAPROSPECTOSCC
SELECT @INFOPROSPECTOSCC=SUBSTRING(LTRIM(RTRIM(@INFOPROSPECTOSCC)),0,LEN(LTRIM(RTRIM(@INFOPROSPECTOSCC))))

SELECT @CORREOSPROSPECTOSCC= CASE WHEN @CORREOSPROSPECTOSCC='' THEN ',' ELSE @CORREOSPROSPECTOSCC END  

SELECT @TOTALCCO=COUNT(*) FROM @TABLAPROSPECTOSCCO
SELECT @INFOPROSPECTOSCCO=@INFOPROSPECTOSCCO+TAGCORREO+',', @INFOTIPSYCCO=@INFOTIPSYCCO+TAGCORREO+',<br /> ', @CORREOSPROSPECTOSCCO=@CORREOSPROSPECTOSCCO+CORREOPROSPECTO+', '  FROM @TABLAPROSPECTOSCCO
SELECT @INFOPROSPECTOSCCO=SUBSTRING(LTRIM(RTRIM(@INFOPROSPECTOSCCO)),0,LEN(LTRIM(RTRIM(@INFOPROSPECTOSCCO))))
   
SELECT @CORREOSPROSPECTOSCCO= CASE WHEN @CORREOSPROSPECTOSCCO='' THEN ',' ELSE @CORREOSPROSPECTOSCCO END  

SELECT TOP 1 @IDPROSPECTOS AS IDPROSPECTO,@PRIMERPROSPECTO AS PRIMERPROSPECTO, @INFOPROSPECTOS AS NOMBRE, (U.NOMBRE + ' ' + U.APELLIDOS) AS AGENTE, MC.EMAIL, U.CORREOSENVIADOS, @TOTAL AS TOTALPROSPECTOS, 
	   	     @INFOPROSPECTOSCC AS NOMBRECC, SUBSTRING(@CORREOSPROSPECTOSCC,1,LEN(@CORREOSPROSPECTOSCC)-1) AS CORREOSPROSPECTOSCC, @TOTALCC AS TOTALPROSPECTOSCC,
			 @INFOPROSPECTOSCCO AS NOMBRECCO, SUBSTRING(@CORREOSPROSPECTOSCCO,1,LEN(@CORREOSPROSPECTOSCCO)-1) AS CORREOSPROSPECTOSCCO, @TOTALCCO AS TOTALPROSPECTOSCCO,@INFOTIPSY AS INFOTIPSY,@INFOTIPSYCC AS INFOTIPSYCC,@INFOTIPSYCCO AS INFOTIPSYCCO,
			 @IDPROSPECTOSCC AS idprostrCC, @IDPROSPECTOSCCO AS idprostrCCO
FROM 
<#SESSION.DB/>.DBO.USUARIOS U,
<#SESSION.DB/>.DBO.USUARIOS_CUENTAS_CORREOS MC
WHERE 
MC.IDUSUARIO=<#SESSION.IDUSUARIO/> AND MC.SMTP_USERNAME IS NOT NULL
AND U.IDUSUARIO=<#SESSION.IDUSUARIO/>



