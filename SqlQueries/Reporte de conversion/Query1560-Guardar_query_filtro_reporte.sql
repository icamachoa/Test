//[irepa|Integer,c|Integer,t|Integer,o|Integer,d|Text,v|Text,session.db|Untyped,]
-- INSERT

DECLARE @IDREPORTEPASO INT, @CATEGORIA INT, @TIPO INT, @OPERADOR INT
DECLARE @DESCRIPCION VARCHAR(MAX), @VALOR VARCHAR(MAX), @SQL VARCHAR(MAX), @CONDICION VARCHAR(MAX)

SET @IDREPORTEPASO = ISNULL(:iRePa,0)
SET @CATEGORIA = ISNULL(:C,0)
SET @TIPO = ISNULL(:T,0)
SET @OPERADOR = ISNULL(:O,0)
SET @DESCRIPCION = :D
SET @VALOR = :V
SET @SQL = ''
SET @CONDICION = ''

IF @VALOR IS NULL BEGIN SET @VALOR = '' END

DECLARE @NAT INT
SELECT @NAT = NATURALEZA FROM <#SESSION.DB/>.dbo.REPORTE_PASOS WHERE IDREPORTEPASO =  @IDREPORTEPASO
SELECT  
  @CONDICION = CASE WHEN  (@NAT = 1) OR (@NAT = 2 AND CONDICIONTRANSACCIONES IS NULL) THEN  CONDICION ELSE CONDICIONTRANSACCIONES END 
FROM 
  SALESUP_CT.dbo.TIPOS_FILTROS WHERE CATE = @CATEGORIA AND TIPO = @TIPO

SET @SQL = REPLACE(@CONDICION,'[VALOR]', @VALOR)

IF @SQL = '' BEGIN SET @SQL = NULL END
IF @VALOR = '' BEGIN SET @VALOR = NULL END

INSERT INTO <#SESSION.DB/>.dbo.REPORTE_FILTROS
	( IDREPORTEPASO, DESCRIPCION, CATEGORIA, TIPO, VALOR, SQL, OPERADOR)
VALUES 
	( @IDREPORTEPASO, @DESCRIPCION, @CATEGORIA, @TIPO, @VALOR, @SQL, @OPERADOR)


UPDATE Rp SET FROMADICIONAL = TF.FROMADICIONAL,SELECTADICIONAL = tf.SELECTADICIONAL from <#SESSION.DB/>.dbo.REPORTE_PASOS rp, 
<#SESSION.DB/>.dbo.REPORTE_FILTROS rf
, SALESUP_CT.dbo.TIPOS_FILTROS tf
where  rp.IDREPORTEPASO=@idreportepaso and rp.IDREPORTEPASO=rf.IDREPORTEPASO 
and tf.TIPO=rf.TIPO and tf.CATE=rf.CATEGORIA