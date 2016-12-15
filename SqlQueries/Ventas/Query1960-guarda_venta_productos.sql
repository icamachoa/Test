//[idoportunidad|Integer,session.db|Untyped,ventaid|Integer,monedas|Integer,session.idempresa|Untyped,]
--insert

DECLARE @IDVENTA INT
DECLARE @IDOPORTUNIDAD INT
DECLARE @IDMONEDA INT
DECLARE @IDEMPRESA INT
DECLARE @IDMONEDADEFAULT INT

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)

SELECT @IDMONEDADEFAULT = IDEMPRESAMONEDA FROM <#SESSION.DB/>.dbo.MONEDAS WHERE IDEMPRESA = @IDEMPRESA AND PORDEFECTO = 1

SET @IDVENTA= ISNULL(:VENTAID, 0)
SET @IDOPORTUNIDAD = ISNULL(:IDOPORTUNIDAD, 0)
SET @IDMONEDA = ISNULL(:MONEDAS, 0)
IF (@IDVENTA>0)
   BEGIN
   		INSERT INTO <#SESSION.DB/>.DBO.VENTAS_PRODUCTOS (IDVENTA,IDPRODUCTO,CANTIDAD,PRECIO,INDICEPRECIOLISTA,IDEMPRESAMONEDA,TIPOCAMBIO,SUBTOTAL,DESCUENTO,TOTAL,IMPUESTO1,IMPUESTO2,IMPUESTO3,IMPUESTO4,IMPUESTO5,IMPUESTO6,IMPUESTO7, IMPUESTO8,IMPUESTO9,IMPUESTO10,
			   		COMISION1,COMISION2,COMISION3,COMISION4,COMISION5,COMISION6,COMISION7,COMISION8,COMISION9,COMISION10,IDEMPRESAMONEDADEFAULT)
		SELECT @IDVENTA,IDPRODUCTO,CANTIDAD,PRECIO,INDICEPRECIOLISTA,@IDMONEDA,TIPOCAMBIO,SUBTOTAL,DESCUENTO,TOTAL,IMPUESTO1,IMPUESTO2,IMPUESTO3,IMPUESTO4,IMPUESTO5,IMPUESTO6,IMPUESTO7, IMPUESTO8,IMPUESTO9,IMPUESTO10,
		       COMISION1,COMISION2,COMISION3,COMISION4,COMISION5,COMISION6,COMISION7,COMISION8,COMISION9,COMISION10,@IDMONEDADEFAULT FROM <#SESSION.DB/>.DBO.OPORTUNIDADES_PRODUCTOS WHERE IDOPORTUNIDAD=@IDOPORTUNIDAD
END
