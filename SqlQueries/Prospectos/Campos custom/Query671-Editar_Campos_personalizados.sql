//[idcampo|Integer,opcionesvalores|Text,descripcion|Text,nombrecampo|Text,session.idempresa|Untyped,eliminaropcion|Integer,nuevoidopcion|Integer,viejoidopcion|Integer,indice|Integer,restriccion|Integer,veren|Integer,tambienen|Integer,generaranteriores|Integer,empiezaen|Integer,tipo|Integer,session.db|Untyped,]
--update
/*PROTEGIDO*/
DECLARE @OPCIONESVALORES VARCHAR(8000), @DESCRIPCION VARCHAR(128), @CAMPO VARCHAR(128), @VALIDACION VARCHAR(1024)
DECLARE @OBLIGATORIO INT, @INDICE INT, @NCARACTERES INT, @IDEMPRESA INT, @IDCAMPO INT, @ELIMINAROPCION INT, @NUEVOIDOPCION INT, @VIEJOIDOPCION INT
DECLARE @VEREN INT, @COMPARTIR INT, @GenerarAnteriores INT, @EmpiezaEn INT, @TipoCampo int
DECLARE @SQLUPDATE VARCHAR(MAX)

SET @IDCAMPO = :IDCAMPO
SET @NCARACTERES = ISNULL(:TAMANIO,0) 
SET @OPCIONESVALORES = :OPCIONESVALORES
SET @DESCRIPCION = :DESCRIPCION
SET @CAMPO = :NOMBRECAMPO
SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @ELIMINAROPCION = ISNULL(:ELIMINAROPCION,0)
SET @NUEVOIDOPCION = ISNULL(:NUEVOIDOPCION,0)
SET @VIEJOIDOPCION = ISNULL(:VIEJOIDOPCION,0)
SET @INDICE = ISNULL(:INDICE,0)
SET @OBLIGATORIO = ISNULL(:Restriccion,0)
SET @VEREN = ISNULL(:VerEn,0)
SET @COMPARTIR = ISNULL(:TambienEn,0)
SET @GenerarAnteriores = ISNULL(:GenerarAnteriores,0)
SET @EmpiezaEn = ISNULL(:EmpiezaEn,0)
SET @TipoCampo = ISNULL(:tipo,0)

UPDATE <#SESSION.DB/>.DBO.EMPRESAS_CAMPOS
SET NOMBRE_CAMPO = @CAMPO,
DESCRIPCION = @DESCRIPCION,
LLAVE = @OBLIGATORIO,
VALIDACION = @VALIDACION,
LARGO = @NCARACTERES,
TIPO = @VEREN, 
CONSECUTIVO = @EmpiezaEn,
COMPARTIR = @COMPARTIR
WHERE IDEMPRESA = @IDEMPRESA
AND IDCAMPO = @IDCAMPO

IF @INDICE >= 21
BEGIN
	 IF @OPCIONESVALORES <> ''
	   INSERT INTO <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES (IDCAMPO, OPCION)
	   SELECT @IDCAMPO, SplitValue FROM <#SESSION.DB/>.dbo.Split(@OPCIONESVALORES,'|') 				   
END

IF @ELIMINAROPCION = 1
BEGIN
	 IF @INDICE > 0
	 BEGIN
	 	  SET @SQLUPDATE = 'UPDATE <#SESSION.DB/>.dbo.PROSPECTOS SET CAMPO'+CAST(@INDICE AS VARCHAR(MAX))+' = '+CAST(@NUEVOIDOPCION AS VARCHAR(MAX))+', ULTIMAMODIFICACION = GETDATE() WHERE CAMPO'+CAST(@INDICE AS VARCHAR(MAX))+' = '+CAST(@@VIEJOIDOPCION AS VARCHAR(MAX))
		  EXEC (@SQLUPDATE) 
	 END
	
	DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WHERE IDEMPRESA = @IDEMPRESA AND IDTABLA = 4
	INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES (IDEMPRESA, IDTABLA,FECHAHORA) VALUES(@IDEMPRESA,4,GETDATE())
	 
 	DELETE FROM <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES WHERE IDOPCION = @VIEJOIDOPCION
	INSERT INTO  <#SESSION.DB/>.dbo.ELIMINACIONES WITH(ROWLOCK)  (IDTABLA,IDELIMINADO,TIPO,IDEMPRESA,FECHAHORA) VALUES (23,@VIEJOIDOPCION,1,@IDEMPRESA,GETDATE())
END

IF @TipoCampo = 6 AND @GenerarAnteriores = 1
BEGIN
	 DECLARE @QRY VARCHAR(MAX)
	 SET @QRY = ''
	 SET @QRY = @QRY + ' DECLARE @MAX INT'
	 SET @QRY = @QRY + ' DECLARE @TABLA TABLE( ID INT, NUMERO INT IDENTITY(' + CAST(@EmpiezaEn AS VARCHAR(MAX)) + ',1))'
	 SET @QRY = @QRY + ' INSERT INTO @TABLA (ID)'
	 IF @VEREN IN (1,3)
	 BEGIN
	 	  SET @QRY = @QRY + ' SELECT P.IDPROSPECTO FROM <#SESSION.DB/>.dbo.PROSPECTOS P WHERE P.IDEMPRESA = ' + CAST(@IDEMPRESA AS VARCHAR(MAX)) + ' ORDER BY P.FECHACONTACTO'

		  SET @QRY = @QRY + ' UPDATE P SET CAMPO33 = TB.NUMERO '
		  SET @QRY = @QRY + ' FROM <#SESSION.DB/>.dbo.PROSPECTOS P '
		  SET @QRY = @QRY + ' JOIN @TABLA TB ON TB.ID = P.IDPROSPECTO  '
		  SET @QRY = @QRY + ' WHERE P.IDEMPRESA = ' + CAST(@IDEMPRESA AS VARCHAR(MAX))
	 END
	 IF @VEREN IN (2,4)
	 BEGIN
	 	  SET @QRY = @QRY + ' SELECT O.IDOPORTUNIDAD FROM <#SESSION.DB/>.dbo.OPORTUNIDADES O JOIN <#SESSION.DB/>.dbo.PROSPECTOS P ON P.IDPROSPECTO = O.IDPROSPECTO WHERE P.IDEMPRESA = ' + CAST(@IDEMPRESA AS VARCHAR(MAX)) + ' ORDER BY O.IDOPORTUNIDAD'

		  SET @QRY = @QRY + ' UPDATE O SET O.CAMPO33 = TB.NUMERO   '
		  SET @QRY = @QRY + ' FROM <#SESSION.DB/>.dbo.OPORTUNIDADES O '
		  SET @QRY = @QRY + ' JOIN <#SESSION.DB/>.dbo.PROSPECTOS P ON P.IDPROSPECTO = O.IDPROSPECTO '
		  SET @QRY = @QRY + ' JOIN @TABLA TB ON TB.ID = O.IDOPORTUNIDAD'
		  SET @QRY = @QRY + ' WHERE P.IDEMPRESA = ' + CAST(@IDEMPRESA AS VARCHAR(MAX))
	 END
	 SET @QRY = @QRY + ' SELECT @MAX = MAX(NUMERO)+1 FROM @TABLA'
	 SET @QRY = @QRY + ' UPDATE <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS SET CONSECUTIVO = @MAX WHERE IDCAMPO = ' + CAST(@IDCAMPO AS VARCHAR(MAX)) 
	 SET @QRY = @QRY + ''
	 EXEC(@QRY)
END





