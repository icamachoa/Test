//[session.idusuario|Untyped,idseleccionado|Text,tipoidseleccionado|Text,session.db|Untyped,session.idempresa|Untyped,session.idgrupo|Untyped,]
--SELECT 
DECLARE @IDSELECCIONADO INT
DECLARE @TIPOIDSELECCIONADO INT
DECLARE @IDUSUARIO INT
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @IDSELECCIONADO = CAST(ISNULL(:IdSeleccionado,'') AS INT)
SET @TIPOIDSELECCIONADO = CAST(ISNULL(:TipoIdSeleccionado,'') AS INT)

IF (@TIPOIDSELECCIONADO=1)
 BEGIN
  --SELECT X.ID, X.TITLE FROM (
   SELECT US.IDUSUARIO as id, US.NOMBRE+' '+US.APELLIDOS as title from <#SESSION.DB/>.dbo.USUARIOS US where us.idusuario=@idusuario 
   UNION
   SELECT US.IDUSUARIO as id, US.NOMBRE+' '+US.APELLIDOS as title from <#SESSION.DB/>.dbo.USUARIOS US where US.IDEMPRESA = <#SESSION.IDEMPRESA/>  AND (US.nivel=1 OR (US.NIVEL=2 AND US.IDGRUPO=<#SESSION.IDGRUPO/>)) AND US.ACTIVO=1 AND US.IDUSUARIO!=@IDUSUARIO
   UNION
   SELECT US.IDUSUARIO as id, US.NOMBRE+' '+US.APELLIDOS  as title  FROM <#SESSION.DB/>.dbo.USUARIOS US, <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS PA WHERE US.IDEMPRESA = <#SESSION.IDEMPRESA/>  AND US.IDUSUARIO=PA.IDUSUARIO AND PA.IDPROSPECTO=@IDSELECCIONADO AND US.ACTIVO=1 AND US.IDUSUARIO!=@IDUSUARIO
  --) X
  -- GROUP BY X.ID, X.TITLE 
 END
ELSE
 IF (@TIPOIDSELECCIONADO=2 OR @TIPOIDSELECCIONADO=0)
  BEGIN
   SELECT US.IDUSUARIO as id, US.NOMBRE+' '+US.APELLIDOS  as title FROM <#SESSION.DB/>.dbo.USUARIOS US WHERE US.IDEMPRESA = <#SESSION.IDEMPRESA/>  AND US.ACTIVO=1
  END
 ELSE
   SELECT US.IDUSUARIO as id, US.NOMBRE+' '+US.APELLIDOS as title from <#SESSION.DB/>.dbo.USUARIOS US where us.idusuario=@idusuario