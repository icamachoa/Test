//[session.idempresa|Untyped,nombre|Text,idmoneda|Text,indice|Integer,tk|Text,session.db|Untyped,]
-- INSERT

DECLARE @IDEMPRESA INT
DECLARE @NOMBRE VARCHAR(128), @TK VARCHAR(64)
DECLARE @IDMONEDA VARCHAR(3)
DECLARE @INDICE INT
DECLARE @IDCAMPO INT

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @NOMBRE = dbo.preparacadena(ISNULL(:NOMBRE,''))
SET @IDMONEDA = ISNULL(:IDMONEDA,'')
SET @INDICE = CAST(ISNULL(:INDICE,0) AS INT)
SET @TK = dbo.ValidaToken(ISNULL(:TK,''))

SELECT TOP 1 @INDICE=INDICE FROM SALESUP_CT.DBO.V_INDICES WHERE INDICE NOT IN (SELECT INDICE FROM <#SESSION.DB/>.DBO.LISTAS_PRECIO WHERE IDEMPRESA=@IDEMPRESA ) 

IF(@TK = '')
BEGIN
	 INSERT INTO <#SESSION.DB/>.DBO.LISTAS_PRECIO (IDEMPRESA,NOMBRE,IDMONEDA,INDICE) VALUES (@IDEMPRESA,@NOMBRE,@IDMONEDA,@INDICE)
	 
	 SELECT TOP 1 @IDCAMPO = IDLISTA_PRECIO FROM <#SESSION.DB/>.DBO.LISTAS_PRECIO WHERE IDEMPRESA = @IDEMPRESA AND NOMBRE = @NOMBRE AND IDMONEDA = @IDMONEDA AND INDICE = @INDICE ORDER BY 1 DESC 
	 
	 EXEC <#SESSION.DB/>.DBO.SP_AGREGA_COLUMAS_PRODUCTOS @IDEMPRESA,@IDCAMPO,1
END
ELSE
BEGIN
	 UPDATE <#SESSION.DB/>.DBO.LISTAS_PRECIO SET NOMBRE = @NOMBRE, IDMONEDA = @IDMONEDA WHERE IDEMPRESA = @IDEMPRESA AND TK = @TK
END
