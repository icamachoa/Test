//[condicion|Text,]
--select 
DECLARE @SQL VARCHAR(MAX)
DECLARE @CONDICION VARCHAR(MAX)

SET @CONDICION = dbo.preparaCadena( ISNULL( :CONDICION , ''))

SET @SQL = '

 SELECT * , 
  (PUNTAJE/ CASE VOTOS WHEN 0 THEN 1 ELSE VOTOS END) AS PROMEDIO 
   FROM SALESUP_CT.DBO.RATING_VIDEOS  '+ @CONDICION+'  ORDER BY ORDEN
   
   ' 
   EXEC (@SQL)