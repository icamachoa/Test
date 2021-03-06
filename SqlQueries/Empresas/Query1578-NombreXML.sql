//[nombrearchivo|Text,descripcion|Text,session.db|Untyped,]
--select
DECLARE @DESCRIPCION VARCHAR(MAX)
DECLARE @NOMBREFILE VARCHAR(MAX)

SET @NOMBREFILE=:NOMBREARCHIVO
SET @DESCRIPCION=:DESCRIPCION

select @NOMBREFILE = <#SESSION.DB/>.dbo.OBTEN_NOMBRE(<#SESSION.DB/>.dbo.PreparaCadena(@NOMBREFILE))
select @DESCRIPCION = <#SESSION.DB/>.dbo.OBTEN_NOMBRE(<#SESSION.DB/>.dbo.PreparaCadena(@DESCRIPCION))

SELECT @NOMBREFILE=<#SESSION.DB/>.DBO.NombreArchivoSugeridoXML (@NOMBREFILE)
SELECT @NOMBREFILE AS Sugerido, @Descripcion as Descripcion
