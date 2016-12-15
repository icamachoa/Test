//[idpantalla|Integer,session.db|Untyped,session.idusuario|Untyped,session.idempresa|Untyped,]
--SELECT
DECLARE @IDPANTALLA INT
SET @IDPANTALLA=isnull(:IDPANTALLA,0)
select count(a.total2) as total2 , @idpantalla as idpantalla  from (
SELECT count(L.IDLINEA_PRODUCTO) as total2,@IDPANTALLA as IDPANTALLA
FROM <#SESSION.DB/>.DBO.ObtieneUsuariosAutorizadosModulos (<#SESSION.IDUSUARIO/>,@IDPANTALLA,0) UL,
<#SESSION.DB/>.DBO.EMPRESAS_LINEAS_PRODUCTO L,<#SESSION.DB/>.DBO.USUARIOS_GRUPOS G, <#SESSION.DB/>.DBO.USUARIOS U 
WHERE UL.ID=U.IDUSUARIO AND L.IDEMPRESA=<#SESSION.IDEMPRESA/> AND L.IDEMPRESA=G.IDEMPRESA AND U.IDGRUPO = G.IDUSUARIOGRUPO
GROUP BY L.IDLINEA_PRODUCTO, L.LINEA_PRODUCTO,L.IDEMPRESA) a
