//[session.idempresa|Untyped,session.idusuario|Untyped,session.db|Untyped,]
--select
/*PROTEGIDO*/
DECLARE @IDEMPRESA INT, @SIDUSUARIO INT
DECLARE @LISTA TABLE (Id VARCHAR(MAX), Tipo VARCHAR(12), Dato VARCHAR(MAX), Tk VARCHAR(MAX) )
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @SIDUSUARIO = <#SESSION.IDUSUARIO/>

INSERT INTO @LISTA (ID, TIPO, DATO, TK )
SELECT 'U'+CAST(U.IdUsuario AS VARCHAR(MAX)), 'U', U.NOMBRE+ ' ' + ISNULL(U.APELLIDOS,'') , U.Tku
FROM <#SESSION.DB/>.dbo.USUARIOS U 
/*JOIN <#SESSION.DB/>.dbo.ObtieneUsuariosAutorizados(@SIDUSUARIO) UA ON UA.IDUSUARIO = U.IDUSUARIO*/
WHERE U.IDEMPRESA = @IDEMPRESA AND U.ACTIVO = 1
ORDER BY U.NOMBRE

INSERT INTO @LISTA (ID, TIPO, DATO, TK )
SELECT 'G'+CAST(UG.IDUSUARIOGRUPO AS VARCHAR(MAX)), 'G', UG.Grupo , ''
FROM <#SESSION.DB/>.dbo.USUARIOS_GRUPOS UG 
JOIN <#SESSION.DB/>.dbo.USUARIOS U ON U.IDGRUPO = UG.IDUSUARIOGRUPO AND U.IDEMPRESA = UG.IDEMPRESA 
/*JOIN <#SESSION.DB/>.dbo.ObtieneUsuariosAutorizados(@SIDUSUARIO) UA ON UA.IDUSUARIO = U.IDUSUARIO*/
WHERE UG.IDEMPRESA = @IDEMPRESA 
GROUP BY UG.IDUSUARIOGRUPO, UG.GRUPO 
ORDER BY UG.GRUPO

INSERT INTO @LISTA (ID, TIPO, DATO, TK )
SELECT 'A'+CAST(1 AS VARCHAR(MAX)), 'A', 'Usuario Relacionado' , ''


/*INSERT INTO @LISTA (ID, TIPO, DATO, TK )
SELECT 'A'+CAST(2 AS VARCHAR(MAX)), 'A', 'Gerente Relacionado' , ''
INSERT INTO @LISTA (ID, TIPO, DATO, TK )
SELECT 'A'+CAST(3 AS VARCHAR(MAX)), 'A', 'Administradores' , ''
INSERT INTO @LISTA (ID, TIPO, DATO, TK )
SELECT 'A'+CAST(4 AS VARCHAR(MAX)), 'A', 'Contacto relacionado' , ''*/

SELECT * FROM @LISTA