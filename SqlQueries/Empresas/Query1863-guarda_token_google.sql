//[session.idusuario|Untyped,body|Text,]
--update
IF (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG  WHERE IDUSUARIO = <#SESSION.IDUSUARIO/>) = 0
  INSERT INTO <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG (IDUSUARIO, TIPO, INBOX_HABILITADO, INBOX_TIPO)  VALUES (<#SESSION.IDUSUARIO/>, 1, 1, 1)

UPDATE <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG SET GMAILTOKEN = :BODY WHERE IDUSUARIO = <#SESSION.IDUSUARIO/>