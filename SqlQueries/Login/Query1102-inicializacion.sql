//[sp_host|Untyped,session.servidor|Untyped,session.link|Untyped,v|Text,f|Text,r1|Text,r2|Text,ini|Text,inicializacion|Text,]
--select
DECLARE @ACCION INT
DECLARE @SP_HOST VARCHAR(100)
DECLARE @URLACCION VARCHAR(100)
DECLARE @SERVER VARCHAR(100)
DECLARE @HOST VARCHAR(100)
SET @SP_HOST='<#SP_HOST/>'
SET @SERVER='<#SESSION.SERVIDOR/>'
SET @URLACCION='<#SESSION.LINK/>'
SET @HOST=SUBSTRING(@SP_HOST,0,CHARINDEX('.salesup.com.mx',@SP_HOST))

IF (@SERVER=@HOST)
 SET @ACCION=0
ELSE 
 SET @ACCION=1

SELECT @ACCION AS ACCION, @URLACCION AS URLACCION,@SERVER, :V AS V, :F AS F, :R1 as R1, :R2 as R2, :INI AS INI, :INICIALIZACION  aS INICIALIZACION