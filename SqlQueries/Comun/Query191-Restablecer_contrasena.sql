//[e|Text,]
--select
/*protegido*/
DECLARE @CORREO VARCHAR(MAX)
SET @CORREO = isnull(:E,'')

EXEC CONTROL.CONTROL.DBO.SP_SOLICITUD_RESTABLECER_CONTRASENA @CORREO




