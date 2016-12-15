//[session.idusuario|Untyped,session.db|Untyped,idmoneda|Text,session.idempresa|Untyped,]
--select

DECLARE @IDMONEDA VARCHAR(3)
DECLARE @IDUSUARIO INT
DECLARE @PERMISOCAMBIARMONEDA INT
DECLARE @PERMISOMODIFICAPRECIO INT


SET @IDUSUARIO = '<#SESSION.IDUSUARIO/>'

select @PERMISOMODIFICAPRECIO = ID from <#SESSION.DB/>.dbo.ObtieneUsuariosAutorizadosModulos(@IDUSUARIO, 13, 0)
select @PERMISOCAMBIARMONEDA = ID from <#SESSION.DB/>.dbo.ObtieneUsuariosAutorizadosModulos(@IDUSUARIO, 13, 1)

SET @IDMONEDA = ISNULL(:IDMONEDA, '')

SELECT IDEMPRESAMONEDA, TIPODECAMBIO, @PERMISOCAMBIARMONEDA AS PERMISOCAMBIARMONEDA, @PERMISOMODIFICAPRECIO AS PERMISOMODIFICAPRECIO FROM <#SESSION.DB/>.DBO.MONEDAS WHERE IDEMPRESA=<#SESSION.IDEMPRESA/>  AND IDMONEDA= @IDMONEDA

