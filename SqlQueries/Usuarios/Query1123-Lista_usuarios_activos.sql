//[session.db|Untyped,session.idempresa|Untyped,]
SELECT U.IDUSUARIO AS IdUsuario, U.EMAIL AS Correo, (U.NOMBRE + ISNULL(' '+U.APELLIDOS,'')+  ' (' + LTRIM(RTRIM(U.INICIALES)) +')') AS Usuario
FROM <#SESSION.DB/>.DBO.USUARIOS U
WHERE ACTIVO = 1 AND IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
ORDER BY U.NOMBRE