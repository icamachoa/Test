//[session.idempresa|Untyped,idcertezas_grupo|Text,descripciones_grupo|Text,session.db|Untyped,]
--update

DECLARE @IDCERTEZAS VARCHAR(MAX), @DESCRIPCIONES VARCHAR(MAX)
DECLARE @IDEMPRESA INT
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDCERTEZAS = ISNULL(:idcertezas_grupo,'') 
SET @DESCRIPCIONES = ISNULL(:descripciones_grupo,'')  

UPDATE EC SET EC.DESCRIPCION = DE.SplitValue
FROM <#SESSION.DB/>.DBO.SPLIT(@IDCERTEZAS, '|') ID,  <#SESSION.DB/>.DBO.SPLIT(@DESCRIPCIONES, '|') DE, <#SESSION.DB/>.DBO.EMPRESAS_CERTEZAS EC
WHERE ID.OCCURENCEID = DE.OCCURENCEID AND EC.IDEMPRESA = @IDEMPRESA AND EC.TK = ID.SplitValue


DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WITH (ROWLOCK) WHERE IDTABLA = 21 AND IDEMPRESA = <#SESSION.IDEMPRESA/>
INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES  WITH (ROWLOCK) (IDTABLA,IDEMPRESA)   VALUES (21,<#SESSION.IDEMPRESA/>)