//[session.idproducto|Untyped,ordenayuda|Integer,]
--SELECT
DECLARE @ORDENAYUDA INT
SET @ORDENAYUDA=ISNULL(:ORDENAYUDA,0)
SELECT A.*, C.CATEGORIA , (SELECT MAX(ORDENAYUDA) FROM CONTROL.DISTRIBUIDORES.dbo.AYUDA WHERE IDPRODUCTO = <#SESSION.IDPRODUCTO/>) AS ULTIMO 
FROM CONTROL.DISTRIBUIDORES.dbo.AYUDA A
LEFT JOIN AYUDA_CATEGORIAS C ON A.IDAYUDACAT = C.IDAYUDACAT
WHERE ORDENAYUDA = @ORDENAYUDA