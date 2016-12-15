//[session.idempresa|Untyped,session.idusuario|Untyped,idp|Integer,session.db|Untyped,tkp|Text,]
--SELECT

DECLARE @IDUSUARIO INT, @IDEMPRESA INT, @TOTALHOY INT, @TOTALMES INT, @IDPROSPECTO INT, @IDUSUARIOREASIGNACION INT
DECLARE @HOY DATETIME, @FINICIO DATETIME, @FFIN DATETIME
DECLARE @DISTRIBUIDOR VARCHAR(MAX), @Canalizo VARCHAR(MAX), @Contacto VARCHAR(MAX), @Empresa VARCHAR(MAX), @USUARIO VARCHAR(MAX)

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

SET @IDPROSPECTO = CAST(ISNULL(:IDP,0) AS INT)

DECLARE @TKP VARCHAR(64)
SET @TKP = ISNULL(:TKP,'')
IF @TKP != '' BEGIN SET @IDPROSPECTO = CAST(<#SESSION.DB/>.dbo.obtieneIdProspecto(@TKP, @IDEMPRESA) AS VARCHAR(MAX)) END


SET @TOTALHOY = 0 
SET @TOTALMES = 0

SET @HOY = SALESUP_CT.dbo.GetOnlyDate(GetDate())
SET @FINICIO = SALESUP_CT.dbo.RangoFecha(0,5,GetDate())
SET @FFIN = SALESUP_CT.dbo.RangoFecha(1,5,GetDate())

SELECT @IDUSUARIOREASIGNACION = IDUSUARIO_REASIGNACION, @DISTRIBUIDOR = DISTRIBUIDOR
FROM <#SESSION.DB/>.dbo.CANALIZACIONES 
WHERE IDPROSPECTO = @IDPROSPECTO AND IDEMPRESA = @IDEMPRESA

SELECT @Contacto = P.NOMBRE +' '+ ISNULL(P.APELLIDOS, ''), @Empresa = P.Empresa, @Canalizo = P.USRCANALIZO,
@USUARIO = U.NOMBRE + ' '+ISNULL(U.APELLIDOS,'')+ ' ('+LTRIM(RTRIM(U.INICIALES))+')'
FROM <#SESSION.DB/>.dbo.PROSPECTOS P 
LEFT JOIN <#SESSION.DB/>.dbo.USUARIOS U ON U.IDUSUARIO = @IDUSUARIOREASIGNACION
WHERE P.IDPROSPECTO = @IDPROSPECTO AND P.IDEMPRESA = @IDEMPRESA

SELECT @TOTALHOY = COUNT(IDPROSPECTO) FROM <#SESSION.DB/>.dbo.CANALIZACIONES 
WHERE IDEMPRESA = @IDEMPRESA AND IDUSUARIO = @IDUSUARIO AND FECHA > @HOY

SELECT @TOTALMES = COUNT(IDPROSPECTO) FROM <#SESSION.DB/>.dbo.CANALIZACIONES 
WHERE IDEMPRESA = @IDEMPRESA AND IDUSUARIO = @IDUSUARIO AND FECHA >= @FINICIO AND FECHA <= @FFIN

IF @IDUSUARIO != @IDUSUARIOREASIGNACION BEGIN SET @Canalizo = '' END

SELECT @TOTALHOY AS tHoy, @TOTALMES as tMes, @DISTRIBUIDOR AS Canalizado, 
@Canalizo AS Canalizo, @Empresa AS Empresa, @Contacto AS Contacto, @USUARIO AS Reasignado, @IDPROSPECTO AS IDP
