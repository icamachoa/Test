//[tk|Text,session.db|Untyped,]
--SELECT
DECLARE @TK VARCHAR(64)
DECLARE @IDPERSONAS VARCHAR(MAX)
DECLARE @IDGRUPOS VARCHAR(MAX)
DECLARE @IDPERSONASF VARCHAR(MAX)
DECLARE @IDGRUPOSF VARCHAR(MAX)
SET @TK= dbo.ValidaToken(:TK)

SELECT @IDPERSONAS=ISNULL(idpersonas,''),@IDGRUPOS=ISNULL(idgrupos,'') FROM <#SESSION.DB/>.dbo.EMPRESAS_LINKEXTERNO WHERE TK=@tk
SELECT @IDPERSONASF=(CASE WHEN @IDPERSONASF IS NOT NULL THEN @IDPERSONASF+',' ELSE '' END)+'U'+SplitValue FROM <#SESSION.DB/>.dbo.Split(@IDPERSONAS,',') WHERE SplitValue >0
SELECT @IDGRUPOSF=(CASE WHEN @IDGRUPOSF IS NOT NULL THEN @IDGRUPOSF+',' ELSE '' END)+'G'+SplitValue FROM <#SESSION.DB/>.dbo.Split(@IDGRUPOS,',') WHERE SplitValue >0
SELECT ISNULL(@IDPERSONASF,'') AS LTIDUSUARIOS,ISNULL(@IDGRUPOSF,'') AS LTIDGRUPOS, (CASE WHEN @IDPERSONASF IS NOT NULL THEN @IDPERSONASF+(CASE WHEN @IDGRUPOSF IS NOT NULL THEN ',' ELSE '' END) ELSE '' END)+ISNULL(@IDGRUPOSF,'') AS PARAQUIEN