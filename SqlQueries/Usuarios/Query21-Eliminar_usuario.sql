//[tkeliminar|Text,tknuevo|Text,session.db|Untyped,session.idusuario|Untyped,session.idempresa|Untyped,]
-- Delete
DECLARE @EXISTE INT
DECLARE @CONTADOR INT


DECLARE @TKELIMINAR VARCHAR(256) 
DECLARE @TKNUEVO VARCHAR(256) 
DECLARE @IDELIMINAR INT
DECLARE @IDNUEVO  INT  

SET @TKELIMINAR =ISNULL(:TKELIMINAR, '') 
SET @TKNUEVO =ISNULL(:TKNUEVO, '') 

SELECT @IDELIMINAR=IDUSUARIO FROM <#SESSION.DB/>.DBO.USUARIOS WHERE TKU=@TKELIMINAR 
SELECT @IDNUEVO =IDUSUARIO FROM <#SESSION.DB/>.DBO.USUARIOS WHERE TKU=@TKNUEVO


-- Seguimiento Y prospectos asignados

  INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO (IDPROSPECTO, IDUSUARIO, COMENTARIO, SISTEMA)
  SELECT IDPROSPECTO, <#SESSION.IDUSUARIO/>, 'Prospecto reasignado por eliminación de integrante.',1 
  FROM <#SESSION.DB/>.DBO.PROSPECTOS WHERE IDUSUARIO =@IDELIMINAR 
----------------------

DECLARE @IDPA INT

DECLARE @TABLATEMP TABLE (ID INT IDENTITY, IDPA INT)
--DECLARE @TO INT, @TOTAL INT
--SET @TO = 1

INSERT INTO @TABLATEMP (IDPA)
SELECT IDPROSPECTO FROM <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS WHERE IDUSUARIO =@IDELIMINAR
DELETE  FROM <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS WHERE IDUSUARIO=@IDELIMINAR

INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS (IDPROSPECTO, IDUSUARIO)
SELECT IDPA, @IDNUEVO  FROM @TABLATEMP
EXCEPT 
SELECT IDPROSPECTO, IDUSUARIO FROM <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS WHERE IDUSUARIO=@IDNUEVO

-- Prospectos
SELECT @CONTADOR = COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS WHERE IDUSUARIO = @IDELIMINAR

UPDATE <#SESSION.DB/>.DBO.PROSPECTOS SET IDUSUARIO = @IDNUEVO, REASIGNADO = 1, 
ULTIMAMODIFICACION = GETDATE() WHERE IDUSUARIO = @IDELIMINAR

IF(@CONTADOR > 0)
BEGIN
	 DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> AND 

IDTABLA = 4
	 INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES (IDEMPRESA, IDTABLA,FECHAHORA) 

VALUES(<#SESSION.IDEMPRESA/>,4,GETDATE())
END 

-- Metas
UPDATE <#SESSION.DB/>.DBO.USUARIOS_METAS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
UPDATE <#SESSION.DB/>.DBO.USUARIOS_METAS SET IDUSUARIO_ASIGNO = @IDNUEVO WHERE IDUSUARIO_ASIGNO = @IDELIMINAR
-- Recordatorios
UPDATE <#SESSION.DB/>.DBO.RECORDATORIOS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
-- Documentos
UPDATE <#SESSION.DB/>.DBO.EMPRESAS_DOCUMENTOS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
-- Autoresponders y emails enviados
UPDATE <#SESSION.DB/>.DBO.USUARIOS_EMAILS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
-- Capacidad de disco
UPDATE <#SESSION.DB/>.DBO.USUARIOS_ARCHIVOS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
-- Plantillas de correos
UPDATE <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
-- Sucesos

SELECT @CONTADOR = COUNT(*) FROM <#SESSION.DB/>.DBO.USUARIOS_SUCESOS WHERE IDUSUARIO = @IDELIMINAR
UPDATE <#SESSION.DB/>.DBO.USUARIOS_SUCESOS SET IDUSUARIO =@IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
--Notificaciones
update <#SESSION.DB/>.DBO.USUARIOS_NOTIFICACIONES  SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR 
--USUARIOS_ALERTAS
update <#SESSION.DB/>.DBO.USUARIOS_ALERTAS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR 

IF(@CONTADOR > 0)
BEGIN
	 DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WITH (ROWLOCK) WHERE IDTABLA = 17 AND 

(IDUSUARIO = @IDELIMINAR OR IDUSUARIO = @IDNUEVO)
	 INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES  WITH (ROWLOCK) (IDTABLA,IDUSUARIO) VALUES 

(17,@IDNUEVO)
END

-- Ventas
UPDATE <#SESSION.DB/>.DBO.VENTAS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
-- Autoresponders creados
UPDATE <#SESSION.DB/>.DBO.AUTORESPONDERS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
-- Redistribucion
UPDATE <#SESSION.DB/>.DBO.EMPRESAS_REDISTRIBUCION_AUTOMATICA SET PROSPECTOS_REASIGNAR_IDUSUARIO = @IDNUEVO WHERE PROSPECTOS_REASIGNAR_IDUSUARIO = @IDELIMINAR
UPDATE <#SESSION.DB/>.DBO.EMPRESAS_REDISTRIBUCION_AUTOMATICA SET OPORTUNIDADES_REASIGNAR_IDUSUARIO = @IDNUEVO WHERE OPORTUNIDADES_REASIGNAR_IDUSUARIO = @IDELIMINAR
-- Oportunidades
UPDATE <#SESSION.DB/>.DBO.OPORTUNIDADES SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR



-- Prospectos seguimientos
SELECT @CONTADOR = COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO WHERE IDUSUARIO = @IDELIMINAR
UPDATE <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO SET IDUSUARIO = @IDNUEVO, ULTIMAMODIFICACION = 
--



GETDATE() WHERE IDUSUARIO = @IDELIMINAR

IF(@CONTADOR > 0)
BEGIN
	 DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WITH (ROWLOCK) WHERE IDTABLA = 5 AND (IDUSUARIO = @IDELIMINAR OR IDUSUARIO = @IDNUEVO)
	 INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES  WITH (ROWLOCK) (IDTABLA,IDUSUARIO) VALUES (5,@IDNUEVO)
END

-- Tipos Sucesos
UPDATE <#SESSION.DB/>.DBO.TIPO_SUCESOS SET IDUSUARIO = @IDNUEVO WHERE IDUSUARIO = @IDELIMINAR
-- Metas personales
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_METAS WHERE IDUSUARIO = @IDELIMINAR
-- Comisiones
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_LINEAS_COMISION WHERE IDUSUARIO = @IDELIMINAR
-- Defaults
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_DEFAULTS WHERE IDUSUARIO=@IDELIMINAR
-- Filtros
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO=@IDELIMINAR
-- Configuracion de correo
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_MAILCONFIG WHERE IDUSUARIO=@IDELIMINAR
-- Distribucion de prospectos
DELETE FROM <#SESSION.DB/>.DBO.EMPRESA_DISTRIBUCION_PROSPECTOS WHERE IDUSUARIO=@IDELIMINAR
-- Importacion
DELETE FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO=@IDELIMINAR
-- Importacion Parametros
DELETE FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION_PARAMETROS WHERE IDUSUARIO=@IDELIMINAR
-- Usuarios tokens
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_TOKENS WHERE IDUSUARIO=@IDELIMINAR
-- Usuarios columnas
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS_COLUMNAS WHERE IDUSUARIO=@IDELIMINAR
-- Usuarios
DELETE FROM <#SESSION.DB/>.DBO.USUARIOS WHERE IDUSUARIO=@IDELIMINAR
--Eliminar de Usuarios_CT
DELETE FROM SALESUP_CT.DBO.USUARIOS WHERE IDUSUARIO=@IDELIMINAR
DELETE FROM CONTROL.CONTROL.DBO.USUARIOS WHERE IDUSUARIO=@IDELIMINAR

DELETE FROM <#SESSION.DB/>.DBO.MODIFICACIONES WITH (ROWLOCK) WHERE IDTABLA = 1 AND (IDUSUARIO = @IDELIMINAR OR IDUSUARIO = @IDNUEVO) 
INSERT INTO <#SESSION.DB/>.DBO.MODIFICACIONES WITH (ROWLOCK) (IDTABLA,IDUSUARIO)  

VALUES(1,@IDNUEVO)

IF @IDELIMINAR IS NOT NULL
BEGIN 
 INSERT INTO <#SESSION.DB/>.DBO.ELIMINACIONES (IDTABLA,IDNUEVO,IDELIMINADO,TIPO,IDEMPRESA,FECHAHORA) 
 VALUES(1,@IDNUEVO,@IDELIMINAR,1,<#SESSION.IDEMPRESA/>,GETDATE())
END


