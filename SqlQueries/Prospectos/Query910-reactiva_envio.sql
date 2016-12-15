//[session.idempresa|Untyped,session.idusuario|Untyped,session.db|Untyped,idprospecto|Integer,tkp|Text,]
--UPDATE
/*PROTEGIDO*/
DECLARE @IDUSUARIO INT
DECLARE @IDPROSPECTO INT
DECLARE @TKP VARCHAR(MAX)
DECLARE @IDEMPRESA INT

SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDPROSPECTO = :IDPROSPECTO
SET @TKP = ISNULL(:TKP,'')

IF @TKP != '' BEGIN SET @IDPROSPECTO = <#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) END


UPDATE <#SESSION.DB/>.dbo.PROSPECTOS SET RECIBIRCORREOS = 3 WHERE IDPROSPECTO = @IDPROSPECTO

INSERT INTO <#SESSION.DB/>.dbo.PROSPECTOS_SEGUIMIENTO (IDPROSPECTO, IDUSUARIO, COMENTARIO) 
VALUES (@IDPROSPECTO, @IDUSUARIO, 'Se ha reactivado la suscripción de correos automáticos.')