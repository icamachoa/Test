//[session.db|Untyped,idventa|Integer,idventacobro|Integer,session.convertcode|Untyped,]
--select
DECLARE @MONTOFALTANTE FLOAT
DECLARE @COMISIONFALTANTE FLOAT
DECLARE @PAGOSFALTANTES INT
DECLARE @TIPOCOMISION INT
DECLARE @IDVENTA INT
DECLARE @IDVENTACOBRO INT
SET @IDVENTACOBRO=ISNULL(:IDVENTACOBRO,0)
SET @IDVENTA=ISNULL(:IDVENTA,0)
SELECT @TIPOCOMISION=ISNULL(TIPOCOMISION,0) FROM <#SESSION.DB/>.dbo.VENTAS  WHERE IDVENTA=@IDVENTA
SELECT @MONTOFALTANTE=SUM(MONTO),@COMISIONFALTANTE=SUM(COMISION) FROM <#SESSION.DB/>.dbo.VENTAS_COBROS WHERE IDVENTA=@IDVENTA AND PAGADO=0
SELECT @PAGOSFALTANTES=COUNT(*) FROM <#SESSION.DB/>.dbo.VENTAS_COBROS WHERE IDVENTA=@IDVENTA AND PAGADO=0 AND IDVENTACOBRO!=@IDVENTACOBRO
SELECT convert(varchar(10),fechahora,<#session.convertcode/>) as fechahora,*,@MONTOFALTANTE AS PORPAGAR, @PAGOSFALTANTES PAGOSFALTANTES,@TIPOCOMISION AS TIPOCOMISION, @COMISIONFALTANTE AS COMISIONFALTANTE 
	   FROM <#SESSION.DB/>.dbo.VENTAS_COBROS WHERE IDVENTACOBRO=@IDVENTACOBRO AND IDVENTA=@IDVENTA