//[tkproducto|Text,tkmarca|Text,tklinea|Text,banidproducto|Integer,session.idempresa|Untyped,codigo|Text,nombre|Text,preciominimo|Numeric,precio1|Numeric,precio2|Numeric,precio3|Numeric,precio4|Numeric,precio5|Numeric,precio6|Numeric,precio7|Numeric,precio8|Numeric,precio9|Numeric,precio10|Numeric,costo|Numeric,unidad|Text,existencia|Numeric,imagen1|Text,montobase|Text,img_default|Text,descorta|Text,desc_extendida1|Text,desc_extendida2|Text,comision1|Numeric,comision2|Numeric,comision3|Numeric,comision4|Numeric,comision5|Numeric,comision6|Numeric,comision7|Numeric,comision8|Numeric,comision9|Numeric,comision10|Numeric,impuesto1|Numeric,impuesto2|Numeric,impuesto3|Numeric,impuesto4|Numeric,impuesto5|Numeric,impuesto6|Numeric,impuesto7|Numeric,impuesto8|Numeric,impuesto9|Numeric,impuesto10|Numeric,descripcotizacion|Text,session.db|Untyped,]
--INSERT

/*PROTEGIDO*/

DECLARE  @BANIDPRODUCTO  INT 
DECLARE  @IDEMPRESA INT 
DECLARE  @CODIGO VARCHAR(32) 
DECLARE  @NOMBRE VARCHAR(256)
DECLARE  @IDMARCA INT  
DECLARE  @IDLINEA_PRODUCTO  INT
DECLARE  @PRECIO_MIN MONEY 
DECLARE  @PRECIO1 MONEY 
DECLARE  @PRECIO2 MONEY 
DECLARE  @PRECIO3 MONEY 
DECLARE  @PRECIO4 MONEY 
DECLARE  @PRECIO5 MONEY 
DECLARE  @PRECIO6 MONEY 
DECLARE  @PRECIO7 MONEY 
DECLARE  @PRECIO8 MONEY 
DECLARE  @PRECIO9 MONEY 
DECLARE  @PRECIO10 MONEY 
DECLARE  @COSTO   MONEY 
DECLARE  @UNIDAD VARCHAR(128)  
DECLARE  @EXISITENCIA FLOAT 

DECLARE  @IMAGEN1 VARCHAR(MAX) 
DECLARE  @MONTOBASE VARCHAR(512)
DECLARE  @IMG_DEFAULT VARCHAR(MAX)
DECLARE  @DESCORTA VARCHAR(512)
DECLARE  @DESC_EXTENDIDA1 VARCHAR(MAX)
DECLARE  @DESC_EXTENDIDA2  VARCHAR(MAX)


DECLARE @COMISION1 FLOAT
DECLARE @COMISION2 FLOAT
DECLARE @COMISION3 FLOAT 
DECLARE @COMISION4 FLOAT 
DECLARE @COMISION5 FLOAT 
DECLARE @COMISION6 FLOAT 
DECLARE @COMISION7 FLOAT 
DECLARE @COMISION8 FLOAT 
DECLARE @COMISION9 FLOAT
DECLARE @COMISION10 FLOAT 

DECLARE @IMPUESTO1 FLOAT 
DECLARE @IMPUESTO2 FLOAT 
DECLARE @IMPUESTO3 FLOAT 
DECLARE @IMPUESTO4 FLOAT 
DECLARE @IMPUESTO5 FLOAT 
DECLARE @IMPUESTO6 FLOAT 
DECLARE @IMPUESTO7 FLOAT 
DECLARE @IMPUESTO8 FLOAT 
DECLARE @IMPUESTO9 FLOAT 
DECLARE @IMPUESTO10 FLOAT 
DECLARE @DESCRIPCION_COTIZACION VARCHAR(MAX)

--CAMBIOS DE TKS 
DECLARE @TKPRODUCTO VARCHAR(256) 
DECLARE @TKMARCA VARCHAR(256) 
DECLARE @TKLINEA VARCHAR(256) 

SET @TKPRODUCTO= ISNULL(:TKPRODUCTO, '') 
SET @TKMARCA= ISNULL(:TKMARCA, '') 
SET @TKLINEA= ISNULL(:TKLINEA, '') 




SET    @BANIDPRODUCTO= ISNULL(:BANIDPRODUCTO, 0)
SET	   @IDEMPRESA='<#SESSION.IDEMPRESA/>'
SET    @CODIGO=ISNULL(:CODIGO, '')  
SET    @NOMBRE =ISNULL(:NOMBRE, '')
SET    @PRECIO_MIN=ISNULL(:PRECIOMINIMO, 0) 
SET    @PRECIO1=ISNULL(:PRECIO1, 0) 
SET    @PRECIO2=ISNULL(:PRECIO2, 0)
SET    @PRECIO3=ISNULL(:PRECIO3, 0)
SET    @PRECIO4=ISNULL(:PRECIO4, 0)
SET    @PRECIO5=ISNULL(:PRECIO5, 0)
SET    @PRECIO6=ISNULL(:PRECIO6, 0)
SET    @PRECIO7=ISNULL(:PRECIO7, 0)
SET    @PRECIO8=ISNULL(:PRECIO8, 0)
SET    @PRECIO9=ISNULL(:PRECIO9, 0)
SET    @PRECIO10=ISNULL(:PRECIO10, 0)
SET    @COSTO=ISNULL(:COSTO, 0) 
SET    @UNIDAD =ISNULL(:UNIDAD, '')
SET    @EXISITENCIA=ISNULL(:EXISTENCIA, 0) 

SET	   @IMAGEN1 =ISNULL(:IMAGEN1, '')
SET    @MONTOBASE=ISNULL(:MONTOBASE, '')
SET    @IMG_DEFAULT = ISNULL(:IMG_DEFAULT, '')
SET    @DESCORTA=ISNULL(:DESCORTA, '')
SET    @DESC_EXTENDIDA1=ISNULL(:DESC_EXTENDIDA1, '')
SET    @DESC_EXTENDIDA2=ISNULL(:DESC_EXTENDIDA2, '')


SET @COMISION1=ISNULL(:COMISION1, 0)/100
SET @COMISION2=ISNULL(:COMISION2, 0)/100
SET @COMISION3=ISNULL(:COMISION3, 0)/100
SET @COMISION4=ISNULL(:COMISION4, 0)/100
SET @COMISION5=ISNULL(:COMISION5, 0)/100
SET @COMISION6=ISNULL(:COMISION6, 0)/100
SET @COMISION7=ISNULL(:COMISION7, 0)/100 
SET @COMISION8=ISNULL(:COMISION8, 0)/100
SET @COMISION9=ISNULL(:COMISION9, 0)/100
SET @COMISION10=ISNULL(:COMISION10, 0)/100

 
SET @IMPUESTO1=ISNULL(:IMPUESTO1, 0)/100 
SET @IMPUESTO2=ISNULL(:IMPUESTO2, 0)/100 
SET @IMPUESTO3=ISNULL(:IMPUESTO3, 0)/100 
SET @IMPUESTO4=ISNULL(:IMPUESTO4, 0)/100 
SET @IMPUESTO5=ISNULL(:IMPUESTO5, 0)/100 
SET @IMPUESTO6=ISNULL(:IMPUESTO6, 0)/100 
SET @IMPUESTO7=ISNULL(:IMPUESTO7, 0)/100 
SET @IMPUESTO8=ISNULL(:IMPUESTO8, 0)/100 
SET @IMPUESTO9=ISNULL(:IMPUESTO9, 0)/100
SET @IMPUESTO10=ISNULL(:IMPUESTO10, 0)/100
SET @DESCRIPCION_COTIZACION=ISNULL(:DESCRIPCOTIZACION, '') 

SELECT @IDMARCA=IDMARCA FROM <#SESSION.DB/>.DBO.MARCAS WHERE  IDEMPRESA= @IDEMPRESA AND  TK =@TKMARCA
SELECT @IDLINEA_PRODUCTO =IDLINEA_PRODUCTO FROM <#SESSION.DB/>.DBO.EMPRESAS_LINEAS_PRODUCTO WHERE IDEMPRESA= @IDEMPRESA AND TK = @TKLINEA



IF(@BANIDPRODUCTO=0)
BEGIN
INSERT INTO <#SESSION.DB>.DBO.PRODUCTOS (IDEMPRESA, CODIGO, NOMBRE, IDMARCA, IDLINEA_PRODUCTO, PRECIO_MIN, PRECIO1, PRECIO2, PRECIO3,PRECIO4,PRECIO5, PRECIO6,PRECIO7,PRECIO8,PRECIO9,PRECIO10, COSTO, 
	                                     UNIDAD, EXISTENCIA, STATUS, IMAGENES,MONTO_BASE, IMG_DEFAULT, DESCRIPCION_CORTA, DESCRIPCION_EXTENDIDA1, DESCRIPCION_EXTENDIDA2, COMISION1, COMISION2,COMISION3, COMISION4,
										 COMISION5, COMISION6, COMISION7,COMISION8, COMISION9, COMISION10, IMPUESTO1, IMPUESTO2, IMPUESTO3,IMPUESTO4,IMPUESTO5,IMPUESTO6, IMPUESTO7, IMPUESTO8,IMPUESTO9,IMPUESTO10, 
										 DESCRIPCION_COTIZACION) 
						                 VALUES (@IDEMPRESA,@CODIGO, @NOMBRE, @IDMARCA, @IDLINEA_PRODUCTO, @PRECIO_MIN, @PRECIO1, @PRECIO2, @PRECIO3, @PRECIO4, @PRECIO5, @PRECIO6,@PRECIO7, @PRECIO8, @PRECIO9, 
										 @PRECIO10, @COSTO, @UNIDAD, @EXISITENCIA, 1, @IMAGEN1,@MONTOBASE, @IMG_DEFAULT, @DESCORTA, @DESC_EXTENDIDA1, @DESC_EXTENDIDA2, @COMISION1, @COMISION2, @COMISION3, @COMISION4, 
										 @COMISION5, @COMISION6, @COMISION7, @COMISION8, @COMISION9, @COMISION10, @IMPUESTO1, @IMPUESTO2,@IMPUESTO3,@IMPUESTO4,@IMPUESTO5,@IMPUESTO6,@IMPUESTO7,@IMPUESTO8,@IMPUESTO9,@IMPUESTO10,
										 @DESCRIPCION_COTIZACION)
										 
END 
ELSE 
BEGIN 
UPDATE <#SESSION.DB>.DBO.PRODUCTOS
SET  IDEMPRESA=@IDEMPRESA, 
	 CODIGO=@CODIGO, 
	 NOMBRE=@NOMBRE, 
	 IDMARCA=@IDMARCA, 
	 IDLINEA_PRODUCTO=@IDLINEA_PRODUCTO, 
	 PRECIO_MIN=@PRECIO_MIN, 
	 PRECIO1=@PRECIO1, 
	 PRECIO2=@PRECIO2, 
	 PRECIO3=@PRECIO3,
	 PRECIO4=@PRECIO4,
	 PRECIO5=@PRECIO5, 
	 PRECIO6=@PRECIO6,
	 PRECIO7=@PRECIO7,
	 PRECIO8=@PRECIO8,
	 PRECIO9=@PRECIO9,
	 PRECIO10=@PRECIO10, 
	 COSTO=@COSTO, 
	 UNIDAD=@UNIDAD, 
	 EXISTENCIA=@EXISITENCIA, 
	 IMAGENES=@IMAGEN1, 
 	 MONTO_BASE=@MONTOBASE,
	 IMG_DEFAULT=@IMG_DEFAULT,
	 DESCRIPCION_CORTA=@DESCORTA, 
	 DESCRIPCION_EXTENDIDA1=@DESC_EXTENDIDA1, 
	 DESCRIPCION_EXTENDIDA2=@DESC_EXTENDIDA2, 
	 COMISION1=@COMISION1, 
	 COMISION2=@COMISION2, 
	 COMISION3=@COMISION3, 
	 COMISION4=@COMISION4, 
	 COMISION5=@COMISION5, 
	 COMISION6=@COMISION6, 
	 COMISION7=@COMISION7, 
	 COMISION8=@COMISION8, 
	 COMISION9=@COMISION9, 
	 COMISION10=@COMISION10, 
	 IMPUESTO1=@IMPUESTO1, 
	 IMPUESTO2=@IMPUESTO2,
	 IMPUESTO3=@IMPUESTO3,
	 IMPUESTO4=@IMPUESTO4,
	 IMPUESTO5=@IMPUESTO5,
	 IMPUESTO6=@IMPUESTO6,
	 IMPUESTO7=@IMPUESTO7,
	 IMPUESTO8=@IMPUESTO8,
	 IMPUESTO9=@IMPUESTO9,
	 IMPUESTO10=@IMPUESTO10, 
	 DESCRIPCION_COTIZACION=@DESCRIPCION_COTIZACION	  	 
WHERE TK=@TKPRODUCTO AND IDEMPRESA= @IDEMPRESA
END 



