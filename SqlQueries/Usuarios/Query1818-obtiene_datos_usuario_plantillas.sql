//[session.idusuario|Untyped,session.db|Untyped,]
-- SELECT 

DECLARE @IDUSUARIO INT

SET @IDUSUARIO = <#SESSION.IDUSUARIO/>

SELECT ISNULL(U.NOMBRE,'')+' '+ISNULL(U.APELLIDOS,'') AS EJECUTIVO, U.INICIALES, U.EMAIL AS EJECUTIVOCORREO, U.USUARIOTELEFONO AS EJECUTIVOTELEFONO, U.USUARIOMOVIL AS EJECUTIVOMOVIL, E.COMPANIA AS EJECUTIVOEMPRESA, U.USUARIOPUESTO AS EJECUTIVOPUESTO, 
'https://s3-us-west-2.amazonaws.com/usrlogos/logos/logo'+CAST(U.IDEMPRESA AS VARCHAR(12))+'.png' AS LOGO
FROM <#SESSION.DB/>.DBO.USUARIOS U, <#SESSION.DB/>.DBO.EMPRESAS E
WHERE U.IDEMPRESA = E.IDEMPRESA AND U.IDUSUARIO = @IDUSUARIO