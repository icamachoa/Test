//[session.idusuario|Untyped,idpantalla|Integer,filtroagrupardetalle|Integer,session.db|Untyped,]
--SELECT


DECLARE @IDPANTALLA INT, @IDUSUARIO INT 
DECLARE @FILTROAGRUPARDETALLE INT 

SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDPANTALLA = ISNULL(:idpantalla,0)
SET @FILTROAGRUPARDETALLE= ISNULL(:FILTROAGRUPARDETALLE, 0) 

SELECT U.IDUSUARIO, U.TKU, U.IDGRUPO, U.IDEMPRESA,
case when isnull(U.APELLIDOS,'') = '' then '' else U.APELLIDOS+', ' end +
case when isnull(U.NOMBRE,'') = '' then '' else U.NOMBRE end +
case when isnull(U.INICIALES,'') = '' then '' else '('+U.INICIALES+')' end as   NOMBRE_COMPLETO,NOMBRE, APELLIDOS, @FILTROAGRUPARDETALLE AS FILTRODETALLE, @FILTROAGRUPARDETALLE AS FILTROAGRUPARDETALLE

FROM <#SESSION.DB/>.DBO.USUARIOS U,<#SESSION.DB/>.DBO.ObtieneUsuariosAutorizadosModulos (@IDUSUARIO,@IDPANTALLA,0) M
WHERE U.IDUSUARIO=M.ID ORDER BY NOMBRE_COMPLETO

