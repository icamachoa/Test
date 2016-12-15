//[session.idempresa|Untyped,session.db|Untyped,]
--select
/*PROTEGIDO*/
DECLARE @IDEMPRESA INT, @SIDUSUARIO INT
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SELECT 1 as tipo,U.idUsuario, LTRIM(RTRIM(U.NOMBRE)) + ' ' + ISNULL(LTRIM(RTRIM(U.APELLIDOS)),'') AS contacto, LTRIM(RTRIM(UPPER(U.Iniciales))) AS iniciales, LOWER(U.Email) AS correo
FROM <#SESSION.DB/>.dbo.USUARIOS U 
WHERE U.IDEMPRESA = @IDEMPRESA AND U.ACTIVO = 1
ORDER BY U.NOMBRE
