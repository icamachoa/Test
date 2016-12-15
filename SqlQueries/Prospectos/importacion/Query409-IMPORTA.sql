//[session.db|Untyped,session.idempresa|Untyped,qry|Untyped,qryupdate|Untyped,cols_update|Untyped,qryupdate2|Untyped,qryupdatecrit|Untyped,idusuario|Untyped,session.idusuario|Untyped,titulo|Untyped,val_etiquetas|Untyped,id1|Untyped,]
--UPDATE

  UPDATE <#SESSION.DB/>.DBO.PROSPECTOS  WITH(ROWLOCK) SET IDPROSPECTO_ID1 = NULL, IDPROSPECTO_ID2 = NULL 
  WHERE IDEMPRESA = <#SESSION.IDEMPRESA/>   AND (IDPROSPECTO_ID1 IS NOT NULL  OR IDPROSPECTO_ID2 IS NOT NULL)

  <#QRY/>
  IF '<#QRYUPDATE/>' != ''
  EXEC ('<#QRYUPDATE/> <#COLS_UPDATE/> <#QRYUPDATE2/> <#QRYUPDATECRIT/>')
  INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO (IDPROSPECTO, IDUSUARIO, FECHAHORA, COMENTARIO, SISTEMA)
  SELECT IDPROSPECTO, <#IDUSUARIO/>, GETDATE(), 'Importado manualmente de un archivo externo.', 1 FROM <#SESSION.DB/>.DBO.PROSPECTOS  WITH(NOLOCK)  WHERE IDPROSPECTO_ID2 = 666 AND IDUSUARIO = <#IDUSUARIO/>
 -- DELETE FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> 

 

  
  
--update
 DECLARE @TIPO INT
 SET @TIPO = <#TITULO/>
 DECLARE @LISTA VARCHAR(128)
 SET @LISTA = '<#val_etiquetas/>'
 DECLARE @IDELEMENTO INT
 
 DECLARE @TABLATEMP TABLE (ID INT IDENTITY,IDELEMENTO int)
DECLARE @TO INT, @TOTAL INT
SET @TO = 1

INSERT INTO @TABLATEMP (IDELEMENTO)
SELECT CAST(SplitValue as int) from  <#SESSION.DB/>.DBO.Split(@LISTA, ',');

SELECT @TOTAL = COUNT(*)  FROM @TABLATEMP

WHILE @TO <= @TOTAL
BEGIN
	SELECT @IDELEMENTO = IDELEMENTO FROM @TABLATEMP WHERE ID = @TO
	DELETE FROM <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS WITH(ROWLOCK) WHERE IDETIQUETA = @IDELEMENTO AND IDPROSPECTO IN 
   (SELECT IDPROSPECTO FROM <#SESSION.DB/>.DBO.PROSPECTOS  WITH(NOLOCK) WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> AND IDPROSPECTO_ID2 = 666)
   --IF (SELECT COUNT(*) FROM PROSPECTOS_ETIQUETAS WHERE IDPROSPECTO = <#ID1/> AND IDETIQUETA = @IDELEMENTO)= 0  
   INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_ETIQUETAS WITH(ROWLOCK) (IDPROSPECTO, IDETIQUETA) --VALUES (<#ID1/>,@IDELEMENTO)
   SELECT IDPROSPECTO, @IDELEMENTO FROM <#SESSION.DB/>.DBO.PROSPECTOS WITH(NOLOCK) WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> AND IDPROSPECTO_ID2 = 666
	SET @TO = @TO + 1
END


  if (@TIPO = 1)
  BEGIN
    UPDATE <#SESSION.DB/>.DBO.PROSPECTOS  WITH(ROWLOCK) SET ESCLIENTE = 1, IMPORTADODESDE = 2 WHERE IDPROSPECTO_ID2 = 666 AND IDEMPRESA = <#SESSION.IDEMPRESA/>
  END
  ELSE
  BEGIN
	UPDATE <#SESSION.DB/>.DBO.PROSPECTOS  WITH(ROWLOCK)  SET IMPORTADODESDE = 1 WHERE IDPROSPECTO_ID2 = 666 AND IDEMPRESA = <#SESSION.IDEMPRESA/>
  END
  
  /*SE INSERTA EL REGISTRO DE USUARIO IMPORTACION*/
  
  DECLARE @IDUSUARIO_DESTINO INT
  DECLARE @TOTAL_REGISTROS INT
  DECLARE @FECHA_INSERCCION DATETIME
  
  SET @IDUSUARIO_DESTINO = CAST('<#IDUSUARIO/>' AS INT)
  
  SELECT TOP 1 @FECHA_INSERCCION = FECHAHORA FROM <#SESSION.DB/>.DBO.PROSPECTOS  WITH(NOLOCK) WHERE IDPROSPECTO_ID2 = 666 AND IDEMPRESA = <#SESSION.IDEMPRESA/> ORDER BY 1 DESC
  SELECT @TOTAL_REGISTROS = COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS  WITH(NOLOCK) WHERE IDPROSPECTO_ID2 = 666 AND IDEMPRESA = <#SESSION.IDEMPRESA/> 
  
  DECLARE @TABLAUSUARIOSIMPORTADOS TABLE (ID INT IDENTITY, IDPROSPECTO INT)
  DECLARE @TO2 INT
  DECLARE @TOTAL2 INT
  DECLARE @IDPROSPECTO INT
   
  SET @TO2 = 1

  INSERT INTO @TABLAUSUARIOSIMPORTADOS (IDPROSPECTO)
  SELECT IDPROSPECTO FROM <#SESSION.DB/>.DBO.PROSPECTOS WITH(NOLOCK) WHERE IDPROSPECTO_ID2 = 666 AND IDEMPRESA = <#SESSION.IDEMPRESA/>

  SELECT @TOTAL2 = COUNT(*)  FROM @TABLAUSUARIOSIMPORTADOS

  WHILE @TO2 <= @TOTAL2
  BEGIN
	SELECT @IDPROSPECTO = IDPROSPECTO FROM @TABLAUSUARIOSIMPORTADOS WHERE ID = @TO2
	EXEC <#SESSION.DB/>.dbo.SP_ACTUALIZA_AUTO_UUID @IDPROSPECTO, 1, <#SESSION.IDEMPRESA/>
	SET @TO2 = @TO2 + 1
  END
  
  UPDATE <#SESSION.DB/>.DBO.PROSPECTOS WITH(ROWLOCK)  SET IDPROSPECTO_ID2 = NULL WHERE IDPROSPECTO_ID2 = 666 AND IDEMPRESA = <#SESSION.IDEMPRESA/>
  
  IF(@FECHA_INSERCCION IS NOT NULL)
  BEGIN
  	   INSERT INTO <#SESSION.DB/>.DBO.USUARIOS_IMPORTACION  WITH(ROWLOCK) (IDUSUARIO,IDUSUARIO_DESTINO,FECHA,TIPO,TOTAL_REGISTROS) VALUES(<#SESSION.IDUSUARIO/>,@IDUSUARIO_DESTINO,@FECHA_INSERCCION,@TIPO,@TOTAL_REGISTROS)
  END
  /*TERMINA INSERCCION DEL REGISTRO DE USUARIO IMPORTACION*/ 
 
 /*ACTUALIZACION DE METAS*/
 EXEC <#SESSION.DB/>.DBO.SP_ACTUALIZA_METAS 1,@IDUSUARIO_DESTINO 
 /*TERMINA ACTUALIZA METAS*/