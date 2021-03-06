//[db|Text,idusuario|Text,predeterminado|Text,idusuariocorreo|Text,]
--select
 
  DECLARE @SQL VARCHAR(MAX)


  SET @SQL = ' DECLARE @TMP TABLE (aIDEMAIL INT) INSERT INTO @TMP (aIDEMAIL) SELECT TOP 50 E.IDEMAIL FROM  '+ :DB + '.dbo.USUARIOS_EMAILS E WITH (NOLOCK) WHERE E.IDUSUARIO = '+ :IDUSUARIO +' AND E.ESTADO = 0 AND E.ERRORES < 3   '
  IF ( :PREDETERMINADO = '1')
    SET @SQL = @SQL + ' AND ISNULL(E.IDUSUARIOCORREO, ' + :IDUSUARIOCORREO + ') = '+ :IDUSUARIOCORREO
  ELSE
    SET @SQL = @SQL + ' AND E.IDUSUARIOCORREO = '+ :IDUSUARIOCORREO
  SET @SQL = @SQL + ' ORDER BY E.IDEMAIL; '
  
  SET @SQL = @SQL + ' UPDATE  '+ :DB + '.dbo.USUARIOS_EMAILS   WITH (ROWLOCK) SET ESTADO = 2 WHERE IDEMAIL IN (SELECT aIDEMAIL FROM @TMP) '
  SET @SQL = @SQL + ' SELECT U.TKU, I.EMAILID, U.IDUSUARIO, U.NOMBRE, U.APELLIDOS, E.IDEMAIL, DESTINATARIO, E.CC, E.BCC, E.ASUNTO, E.CUERPO, LTRIM(RTRIM(CAST(ANEXOS AS VARCHAR(MAX)))) AS ANEXOS  FROM  @TMP  T, '+ :DB + '.dbo.USUARIOS_EMAILS E  WITH (NOLOCK) LEFT JOIN '+ :DB + '.dbo.USUARIOS_INBOX I  WITH (NOLOCK)  ON I.IDINBOX = E.IDINBOX, '+ :DB + '.dbo.USUARIOS U WITH(NOLOCK) WHERE E.IDEMAIL = T.aIDEMAIL AND  U.IDUSUARIO = E.IDUSUARIO AND U.IDUSUARIO = '+ :IDUSUARIO +' '
 EXEC (@SQL)