//[token|Text,]

DECLARE @TOKEN UNIQUEIDENTIFIER

SET @TOKEN = :TOKEN

SELECT I.IDEMPRESA,I.SERVIDOR, I.ULTIMA_SINCRONIZACION_EXT,  CAST(GETDATE() AS FLOAT) AS AHORA, CONFIGURACION_LOCAL
FROM CONTROL.CONTROL.DBO.INTEGRACIONES I WHERE I.TOKEN = @TOKEN AND ACTIVA=1


