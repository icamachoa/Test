//[session.idempresa|Untyped,tk|Text,session.db|Untyped,]
--DELETE 

DECLARE @IDEMPRESA INT 
DECLARE @IDCOMISION INT 
DECLARE @INDICE INT 
DECLARE @SQLTEXT VARCHAR(MAX) 
DECLARE @CAMPO VARCHAR(100) 
DECLARE @TK VARCHAR(256) 


SET @IDEMPRESA=<#SESSION.IDEMPRESA/>
SET @IDCOMISION=0 
SET @TK=ISNULL(:TK, '')
IF(@TK!='')  BEGIN SELECT @IDCOMISION=IDPRODUCTO_COMISION FROM <#SESSION.DB/>.DBO.PRODUCTOS_COMISIONES WHERE IDEMPRESA=@IDEMPRESA AND TKCOMISION=@TK END  

 


SET @SQLTEXT=''
SELECT @INDICE=INDICE FROM <#SESSION.DB/>.DBO.PRODUCTOS_COMISIONES WHERE 
IDEMPRESA=@IDEMPRESA AND IDPRODUCTO_COMISION=@IDCOMISION

SET @CAMPO='COMISION'+CAST(@INDICE AS VARCHAR(10))
SET @SQLTEXT= 'UPDATE <#SESSION.DB/>.DBO.PRODUCTOS 
SET '+@CAMPO+'=0'
+' WHERE IDEMPRESA='+CAST(@IDEMPRESA AS VARCHAR(MAX))
EXEC (@SQLTEXT)


DELETE <#SESSION.DB/>.DBO.PRODUCTOS_COMISIONES WHERE IDEMPRESA=@IDEMPRESA AND IDPRODUCTO_COMISION=@IDCOMISION
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_COLUMNAS WITH(ROWLOCK) WHERE IDCOMISION = @IDCOMISION