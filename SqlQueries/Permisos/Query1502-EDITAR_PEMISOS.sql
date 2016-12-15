//[idmodulo|Integer,tku|Text,session.db|Untyped,]
--SELECT
/*PROTEGIDO*/
DECLARE @TKU VARCHAR(MAX)
DECLARE @IDMODULO INT
DECLARE @IDUSUARIO INT
DECLARE @IDPERSONAS VARCHAR(MAX)
DECLARE @IDGRUPOS VARCHAR(MAX)
DECLARE @IDPERSONASF VARCHAR(MAX)
DECLARE @IDGRUPOSF VARCHAR(MAX)
DECLARE @PERMISOSEXTRA VARCHAR(MAX)
SET @IDMODULO=CAST(:IDMODULO AS INT)
SET @TKU= dbo.ValidaToken(:TKU)


SELECT @IDUSUARIO=IDUSUARIO FROM <#SESSION.DB/>.dbo.USUARIOS WHERE TKU=@TKU
IF ((@IDMODULO>=1 AND @IDMODULO<=4) OR @IDMODULO=8 )
 BEGIN
  IF @IDMODULO=8
    DELETE FROM <#SESSION.DB/>.dbo.USUARIOS_FILTROS WHERE IDUSUARIO=@IDUSUARIO AND IDPANTALLA IN (10,25,9,14,15,400,16,405)
  ELSE
    DELETE FROM <#SESSION.DB/>.dbo.USUARIOS_FILTROS WHERE IDUSUARIO=@IDUSUARIO AND IDPANTALLA=@IDMODULO
 END

SELECT @IDPERSONAS=ISNULL(idpersonas,''),@IDGRUPOS=ISNULL(idgrupos,''), @PERMISOSEXTRA = PERMISOSEXTRA FROM <#SESSION.DB/>.dbo.PERMISOS_MODULOS WHERE idusuario=@IDUSUARIO AND idmodulo=@IDMODULO
SELECT @IDPERSONASF=(CASE WHEN @IDPERSONASF IS NOT NULL THEN @IDPERSONASF+',' ELSE '' END)+'U'+SplitValue FROM <#SESSION.DB/>.dbo.Split(@IDPERSONAS,',') WHERE SplitValue >0
SELECT @IDGRUPOSF=(CASE WHEN @IDGRUPOSF IS NOT NULL THEN @IDGRUPOSF+',' ELSE '' END)+'G'+SplitValue FROM <#SESSION.DB/>.dbo.Split(@IDGRUPOS,',') WHERE SplitValue >0
SELECT ISNULL(@PERMISOSEXTRA,'') AS PERMISOSEXTRA,ISNULL(@IDPERSONASF,'') AS LTIDUSUARIOS,ISNULL(@IDGRUPOSF,'') AS LTIDGRUPOS, (CASE WHEN @IDPERSONASF IS NOT NULL THEN @IDPERSONASF+(CASE WHEN @IDGRUPOSF IS NOT NULL THEN ',' ELSE '' END) ELSE '' END)+ISNULL(@IDGRUPOSF,'') AS PARAQUIEN