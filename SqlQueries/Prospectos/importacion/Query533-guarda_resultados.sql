//[session.db|Untyped,session.idusuario|Untyped,crit_duplicidad|Text,qryupdatecrit|Text,duplicidad|Text,]
--update 
DECLARE @SQL VARCHAR(MAX)
DECLARE @CRIT VARCHAR(MAX)
SET @CRIT = ISNULL( :QRYUPDATECRIT , '')
DECLARE @CRIT_DUPLICIDAD VARCHAR(MAX)
SET @CRIT_DUPLICIDAD = ISNULL( :CRIT_DUPLICIDAD , '')

SET @SQL = '
  UPDATE <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION SET RESULTADOTIPO = 1  
  WHERE IDUSUARIO = <#SESSION.IDUSUARIO/>  

  IF (''' + @CRIT + ''' != '''') AND (''' + ISNULL( :DUPLICIDAD , '1') + ''' = ''1'')
  UPDATE <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION SET RESULTADOTIPO = 2 
  FROM <#SESSION.DB/>.DBO.PROSPECTOS P, <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION I 
  WHERE RESULTADOTIPO != 1 and I.IDUSUARIO = <#SESSION.IDUSUARIO/> ' + @CRIT

  EXEC (@SQL)