//[session.db|Untyped,nombrecategoria|Integer,idseguimiento|Integer,]
--UPDATE
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @NOMBRECATEGORIA INT
DECLARE @IDSEGUIMIENTO INT
SET @NOMBRECATEGORIA= :NOMBRECATEGORIA
SET @IDSEGUIMIENTO=ISNULL(:IDSEGUIMIENTO,0)
UPDATE <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO SET IDSEGUIMIENTOCATEGORIA=@NOMBRECATEGORIA WHERE IDSEGUIMIENTO=@IDSEGUIMIENTO