//[session.db|Untyped,session.idempresa|Untyped,tkcg|Text,grupo|Text,]
--UPDATE
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @TKCG VARCHAR(256) 
DECLARE @IDEMPRESA INT 
DECLARE @COMPANIA_NOMBRE VARCHAR(MAX) 

SET @TKCG=ISNULL(:TKCG, '') 
SET @IDEMPRESA=<#SESSION.IDEMPRESA/>
SET @COMPANIA_NOMBRE = ISNULL(:GRUPO, '') 

UPDATE  <#SESSION.DB/>.DBO.COMPANIAS_GRUPOS SET COMPANIAGRUPO =@COMPANIA_NOMBRE WHERE IDEMPRESA = @IDEMPRESA and TKCG=@TKCG