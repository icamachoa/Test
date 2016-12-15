//[tku|Text,session.db|Untyped,ltmodulos|Integer,ltidusuarios|Text,ltidgrupos|Text,permisosextra|Text,]
--update
/*PROTEGIDO*/

DECLARE @MODULO INT
DECLARE @TKU VARCHAR(MAX)
DECLARE @PERSONAS VARCHAR(MAX)
DECLARE @GRUPOS VARCHAR(MAX)
DECLARE @IDUSUARIO INT
DECLARE @PERMISOSEXTRA VARCHAR(MAX) = :PERMISOSEXTRA
SET @TKU= dbo.ValidaToken(:TKU)

SELECT @IDUSUARIO=IDUSUARIO FROM <#SESSION.DB/>.dbo.USUARIOS WHERE TKU=@TKU
SET @MODULO=CAST(:LtModulos AS INT)
SET @PERSONAS=REPLACE(:LtIdUsuarios,'U','')
SET @GRUPOS=REPLACE(:LtIdGrupos,'G','')

IF ((@MODULO >=1 AND @MODULO <=4) OR @MODULO =8 )
 BEGIN
  IF @MODULO =8
    DELETE FROM <#SESSION.DB/>.dbo.USUARIOS_FILTROS WHERE IDUSUARIO=@IDUSUARIO AND IDPANTALLA IN (10,25,9,14,15,400,16,405)
  ELSE
    DELETE FROM <#SESSION.DB/>.dbo.USUARIOS_FILTROS WHERE IDUSUARIO=@IDUSUARIO AND IDPANTALLA=@MODULO 
 END

DELETE FROM <#SESSION.DB/>.dbo.PERMISOS_MODULOS WHERE IDMODULO=@MODULO AND IDUSUARIO=@IDUSUARIO
INSERT INTO <#SESSION.DB/>.dbo.PERMISOS_MODULOS (IDUSUARIO,IDMODULO,IDPERSONAS,IDGRUPOS,PERMISOSEXTRA)
VALUES(@IDUSUARIO,@MODULO,@PERSONAS,@GRUPOS,@PERMISOSEXTRA)
