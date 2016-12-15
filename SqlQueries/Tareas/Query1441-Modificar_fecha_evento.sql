//[session.idusuario|Untyped,id|Integer,editarfechatarea|Integer,tipoevento|Integer,dias|Integer,horas|Integer,minutos|Integer,session.convertcode|Untyped,session.db|Untyped,]
--update
/*PROTEGIDO*/
DECLARE @SESSIONIDUSUARIO INT, @IDEVENTO INT, @TIPOEVENTO INT, @DIAS INT, @HORAS INT, @MINUTOS INT, @CONVERTCODE INT, @TIPOSUCESO INT, @IDPROSPECTO INT, @ModificarFecha INT
DECLARE @IDTAREA INT, @MASTIEMPO INT, @IDTAREASEGUIMIENTO INT
DECLARE @FECHAINICIO DATETIME , @FECHAFIN DATETIME, @NUEVAFECHAINICIO DATETIME, @NUEVAFECHAFIN DATETIME, @FECHAVENCIMIENTO DATETIME
DECLARE @COMENTARIOEVENTO VARCHAR(MAX)

SET @SESSIONIDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)
SET @IDEVENTO = ISNULL(:id,0)
SET @ModificarFecha = ISNULL(:EditarFechaTarea,0)
SET @TIPOEVENTO = ISNULL(:TipoEvento,0) 
SET @DIAS = ISNULL(:Dias,0) 
SET @HORAS = ISNULL(:Horas,0)
SET @MINUTOS = ISNULL(:Minutos,0) 
SET @CONVERTCODE = CAST('<#SESSION.CONVERTCODE/>' AS INT)
SET @TIPOSUCESO = 0
SET @COMENTARIOEVENTO = ''

/* RECORDATORIOS */
IF @TIPOEVENTO = 1 
BEGIN
	SELECT @FECHAFIN = FECHAHORA FROM <#SESSION.DB/>.dbo.RECORDATORIOS WHERE IDRECORDATORIO = @IDEVENTO
	SET @NUEVAFECHAFIN = DATEADD (dd , @DIAS , @FECHAFIN )
	SET @NUEVAFECHAFIN = DATEADD (hh , @HORAS , @NUEVAFECHAFIN )
	SET @NUEVAFECHAFIN = DATEADD (mi , @MINUTOS , @NUEVAFECHAFIN )
	UPDATE <#SESSION.DB/>.dbo.RECORDATORIOS SET FECHAHORA = @NUEVAFECHAFIN WHERE IDRECORDATORIO = @IDEVENTO 
END

/* CITAS */
IF @TIPOEVENTO = 2
BEGIN
	SELECT @FECHAINICIO = FECHA_INICIO , @FECHAFIN = FECHA_FIN FROM <#SESSION.DB/>.dbo.CITAS WHERE IDCITA = @IDEVENTO
	SET @NUEVAFECHAINICIO = DATEADD (dd , @DIAS , @FECHAINICIO )
	SET @NUEVAFECHAINICIO = DATEADD (hh , @HORAS , @NUEVAFECHAINICIO )
	SET @NUEVAFECHAINICIO = DATEADD (mi , @MINUTOS , @NUEVAFECHAINICIO )
	
	SET @NUEVAFECHAFIN = DATEADD (dd , @DIAS , @FECHAFIN )
	SET @NUEVAFECHAFIN = DATEADD (hh , @HORAS , @NUEVAFECHAFIN )
	SET @NUEVAFECHAFIN = DATEADD (mi , @MINUTOS , @NUEVAFECHAFIN )	
	SET @TIPOSUCESO = 26
	SET @COMENTARIOEVENTO = 'Fecha de la cita modificada'
	UPDATE <#SESSION.DB/>.dbo.CITAS SET FECHA_INICIO = @NUEVAFECHAINICIO, FECHA_FIN = @NUEVAFECHAFIN WHERE IDCITA = @IDEVENTO
END

/* TAREAS */
IF @TIPOEVENTO = 3
BEGIN
	SELECT @IDTAREA = IDTAREA, @FECHAFIN = FECHA_VENCIMIENTO, 
	@MASTIEMPO = ISNULL(MASTIEMPO,0), @IDPROSPECTO = IDPROSPECTO 
	FROM <#SESSION.DB/>.dbo.TAREAS WHERE IDTAREA = @IDEVENTO
	
	SET @NUEVAFECHAFIN = DATEADD (dd , @DIAS , @FECHAFIN )
	SET @NUEVAFECHAFIN = DATEADD (hh , @HORAS , @NUEVAFECHAFIN )
	SET @NUEVAFECHAFIN = DATEADD (mi , @MINUTOS , @NUEVAFECHAFIN )
	
	IF @ModificarFecha = 1
	BEGIN
		 /*Fecha modificada por iniciador*/
		 SET @TIPOSUCESO = 45
		 SET @COMENTARIOEVENTO = 'La fecha de vencimiento se ha modificado, fecha anterior '+SALESUP_CT.dbo.FechaFormato(@FECHAFIN,2) 
		 INSERT INTO <#SESSION.DB/>.dbo.TAREAS_SEGUIMIENTO (IDUSUARIO, FECHAHORA, COMENTARIO, IDTAREA)
		 VALUES (@SESSIONIDUSUARIO, GETDATE(), @COMENTARIOEVENTO, @IDTAREA)
		 
		 SET @MASTIEMPO = @MASTIEMPO + 1

		 SELECT TOP 1 @IDTAREASEGUIMIENTO = IDTAREASEGUIMIENTO 
		 FROM <#SESSION.DB/>.dbo.TAREAS_SEGUIMIENTO 
		 WHERE IDTAREA = @IDTAREA ORDER BY 1 DESC

		 UPDATE <#SESSION.DB/>.dbo.TAREAS 
		 SET IDTAREASEGUIMIENTO = @IDTAREASEGUIMIENTO,
		 MASTIEMPO = @MASTIEMPO, FECHA_VENCIMIENTO = @NUEVAFECHAFIN, IDESTADO = 1
		 WHERE IDTAREA = @IDTAREA
		 
	END
	ELSE
	BEGIN
		 /*Fecha solicitada por responsable*/
		 
		 SET @TIPOSUCESO = 33
		 SET @COMENTARIOEVENTO = 'Se ha solicitado una modificación de fecha de vencimiento, fecha propuesta - '+SALESUP_CT.dbo.FechaFormato(@NUEVAFECHAFIN,2) 
		 INSERT INTO <#SESSION.DB/>.dbo.TAREAS_SEGUIMIENTO (IDUSUARIO, FECHAHORA, COMENTARIO, IDTAREA)
		 VALUES (@SESSIONIDUSUARIO, GETDATE(), @COMENTARIOEVENTO, @IDTAREA)
	
		 SELECT TOP 1 @IDTAREASEGUIMIENTO = IDTAREASEGUIMIENTO 
		 FROM <#SESSION.DB/>.dbo.TAREAS_SEGUIMIENTO 
		 WHERE IDTAREA = @IDTAREA ORDER BY 1 DESC
	
		 UPDATE <#SESSION.DB/>.dbo.TAREAS SET IDTAREASEGUIMIENTO = @IDTAREASEGUIMIENTO, 
		 FECHA_PROPUESTA = @NUEVAFECHAFIN, IDESTADO = 6
		 WHERE IDTAREA = @IDTAREA

	END
	
END

/*Genera suceso*/
IF @TIPOSUCESO > 0 
BEGIN	
	EXEC <#SESSION.DB/>.dbo.SP_INGRESA_SUCESOS_PROSPECTOS @SESSIONIDUSUARIO, @TIPOSUCESO, @IDPROSPECTO, @CONVERTCODE, @COMENTARIOEVENTO, @IDEVENTO
END
