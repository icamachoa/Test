//[fecha|Text|17/09/2015,session.convertcode|Untyped|103,session.gmt|Untyped|72,session.db|Untyped|SALESUP_DB1]
-- SELECT

DECLARE @GMT int  
DECLARE @HORAREAL datetime
DECLARE @CONTADOR INT 
DECLARE @DIFERENCIA INT 
DECLARE @FECHA VARCHAR(MAX)
DECLARE @FECHADT DATETIME
DECLARE @HOY DATETIME 

 
 
SET @HOY =SALESUP_CT.DBO.GETONLYDATE(GETDATE())
SET @FECHADT= @HOY
SET @FECHA=ISNULL(:FECHA, '')


IF(@FECHA !='')
  SET @FECHADT=CONVERT(DATETIME, @FECHA, <#SESSION.CONVERTCODE/>) 
 
SET @GMT = CAST('<#SESSION.GMT/>' AS INT )
SET @HORAREAL =  SALESUP_CT.dbo.[obtieneFechaRealGMT]( @GMT, GETDATE())

SELECT CONVERT(NVARCHAR(5),@HORAREAL, 108) AS HORATOTAL, DATEPART(HH, @HORAREAL) AS HORA,DATEPART(N, @HORAREAL) AS MINUTOS, CASE WHEN @FECHADT=@HOY THEN 1 ELSE 0 END  AS FECHAHOY


