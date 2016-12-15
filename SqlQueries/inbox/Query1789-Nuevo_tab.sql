//[session.idusuario|Untyped,tab|Text,icono|Text,session.db|Untyped,]
--SELECT
/*protegido*/
DECLARE @IDUSUARIO INT, @ORDEN INT, @IDTAB INT
DECLARE @TAB VARCHAR(MAX), @ICONO VARCHAR(MAX)

SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

SET @TAB = ISNULL(:TAB,'')
SET @ICONO = ISNULL(:ICONO,'')

SELECT TOP 1 @ORDEN = ISNULL(ORDEN,0) + 1 FROM <#SESSION.DB/>.dbo.USUARIOS_INBOX_TABS WHERE IDUSUARIO = @IDUSUARIO ORDER BY 1 DESC

INSERT INTO <#SESSION.DB/>.dbo.USUARIOS_INBOX_TABS
	( IDUSUARIO,  TAB,  ICONO,  ORDEN)
VALUES 
	(@IDUSUARIO, @TAB, @ICONO, @ORDEN)

SELECT top 1 idTabInbox, Tab, Icono, noLeidos, total, Orden, ISNULL(tab_default,0) AS tabDefault, CASE WHEN ISNULL(tab_default,0) = 0 THEN '1' ELSE '' END AS pEliminar, 1 as nuevo FROM <#SESSION.DB/>.dbo.USUARIOS_INBOX_TABS WHERE IDUSUARIO = @IDUSUARIO ORDER BY 1 DESC 



