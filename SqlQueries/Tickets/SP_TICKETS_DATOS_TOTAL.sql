//[filtroproducto|Text,filtroestado|Text,filtrousuario|Text,session.idusuario|Untyped,session.idproducto|Untyped,estatus|Text,]
--select
DECLARE @SQL VARCHAR(MAX) 
DECLARE @FILTROESTADO VARCHAR(MAX)
DECLARE @IDUSUARIO INT
DECLARE @IDPRODUCTO INT
DECLARE @ESTATUS INT

SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDPRODUCTO = <#SESSION.IDPRODUCTO/>
SET @ESTATUS =  ISNULL(:ESTATUS,'') 

SET @FILTROESTADO = ''

IF @ESTATUS != 0 
BEGIN
	SET @FILTROESTADO = 'AND (T.IDESTADO = '+CAST(@ESTATUS AS VARCHAR)+')'
END

SET @SQL = '
  SELECT COUNT(*) AS TOTALN 
  FROM CONTROL.TICKETS.DBO.TICKETS T, CONTROL.TICKETS.DBO.V_DEPARTAMENTOS VD, CONTROL.TICKETS.DBO.V_ESTADOS VE
  WHERE T.IDDEPARTAMENTO=VD.IDDEPARTAMENTO AND T.IDESTADO=VE.IDESTADO AND IDUSUARIO='+CAST(@IDUSUARIO AS VARCHAR)+'
 AND IDPRODUCTO='+CAST(@IDPRODUCTO AS VARCHAR)+'  ' + @FILTROESTADO 
 EXEC (@SQL)