//[session.nivel|Untyped,session.idempresa|Untyped,session.idgrupo|Untyped,ventaid|Text,par|Text,fecha|Text,session.convertcode|Untyped,comision|Text,pago|Text,pagado|Text,referenciaventa|Text,idoportunidad|Text,concepto|Text,session.db|Untyped,]
--INSERt
DECLARE @ESCANALIZADO INT
DECLARE @IDVENTA INT
DECLARE @PAR INT
DECLARE @FECHA DATETIME
DECLARE @COMISION MONEY
DECLARE @PAGO MONEY
DECLARE @PAGADO INT
DECLARE @REFERENCIAVENTA VARCHAR(MAX)
DECLARE @IDGRUPO INT
DECLARE @AUDITADO INT
DECLARE @IDEMPRESA INT
DECLARE @NIVEL INT
DECLARE @CONCEPTO VARCHAR(128)
DECLARE @CAMBIOLOCAL INT
DECLARE @P VARCHAR(MAX)
DECLARE @FECHAHOY DATETIME

SET @ESCANALIZADO=0
SET @NIVEL=<#SESSION.NIVEL/>
SET @IDEMPRESA=<#SESSION.IDEMPRESA/>
SET @AUDITADO=1
SET @IDGRUPO=<#SESSION.IDGRUPO/>
SET @IDVENTA=CAST(ISNULL(:VENTAID,'') AS INT)
SET @PAR=CAST(ISNULL(:PAR,'') AS INT)
SET @FECHA=CONVERT(DATETIME,ISNULL(:FECHA,''),<#SESSION.CONVERTCODE/>)
SET @COMISION=CAST(CAST(ISNULL(:COMISION,'') AS FLOAT) AS MONEY)
SET @PAGO=CAST(CAST(ISNULL(:PAGO,'') AS FLOAT) AS MONEY)
SET @PAGADO=CAST(ISNULL(:PAGADO,'') AS INT)
SET @REFERENCIAVENTA=CAST(:REFERENCIAVENTA AS VARCHAR(MAX))
DECLARE @idoportunidad  INT
SET @idoportunidad  = CAST(ISNULL(:IDOPORTUNIDAD,'') AS INT)

SET @CONCEPTO = ISNULL(:CONCEPTO,'')

SELECT @AUDITADO=(CASE WHEN AUDITADO=0 THEN 1 WHEN (@NIVEL=1 AND @PAGADO=1) THEN 1 ELSE 0 END) FROM  <#SESSION.DB/>.DBO.USUARIOS_GRUPOS WHERE IDUSUARIOGRUPO=@IDGRUPO AND IDEMPRESA=@IDEMPRESA

  INSERT INTO <#SESSION.DB/>.DBO.VENTAS_COBROS WITH(ROWLOCK) (IDVENTA,NOPARCIALIDAD,FECHAHORA,MONTO,COMISION,PAGADO,REFERENCIA,AUDITADO)
  VALUES (@IDVENTA,@PAR,@FECHA,@PAGO,@COMISION, @PAGADO,@REFERENCIAVENTA,@AUDITADO)
  
  SELECT @CAMBIOLOCAL = 1 FROM <#SESSION.DB/>.DBO.OPORTUNIDADES O, <#SESSION.DB/>.DBO.PROSPECTOS P 
	 WHERE O.IDOPORTUNIDAD = @IDOPORTUNIDAD AND O.IDPROSPECTO = P.IDPROSPECTO AND O.TKOM IS NOT NULL AND P.TKPM IS NOT NULL
	 
  UPDATE <#SESSION.DB/>.DBO.OPORTUNIDADES WITH(ROWLOCK) SET CONCEPTO = @CONCEPTO, CAMBIOLOCAL=@CAMBIOLOCAL WHERE IDOPORTUNIDAD = @IDOPORTUNIDAD
  UPDATE <#SESSION.DB/>.DBO.VENTAS WITH(ROWLOCK) SET CAMBIOLOCAL=@CAMBIOLOCAL WHERE IDVENTA = @IDVENTA
  
DECLARE @IDPROSPECTO INT
SELECT @IDPROSPECTO=IDPROSPECTO FROM <#SESSION.DB/>.DBO.OPORTUNIDADES WITH(NOLOCK) WHERE IDOPORTUNIDAD = @idoportunidad

EXEC <#SESSION.DB/>.DBO.SP_CONVERTIR_A_CLIENTE @IDPROSPECTO,@IDOPORTUNIDAD,@IDEMPRESA

SET @FECHAHOY = GETDATE()
SET @P = CAST(@IDPROSPECTO AS VARCHAR(MAX))
EXEC <#SESSION.DB/>.DBO.SP_UPDATE_PROSPECTOS_ASIGNADOS @P,@FECHAHOY,1
		   


