//[tkca|Text,session.db|Untyped,accion|Integer,]
--update
/*PROTEGIDO*/
/*SEP2015*/
DECLARE @TK VARCHAR(64)
DECLARE @ACCION INT
SET @TK= dbo.ValidaToken(ISNULL(:TKCA,''))
SET @ACCION=ISNULL(:ACCION,0)

UPDATE <#SESSION.DB/>.dbo.CATALOGOS SET STATUS = @ACCION WHERE TKCA = @TK