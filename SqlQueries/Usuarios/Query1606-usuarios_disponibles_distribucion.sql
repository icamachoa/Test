//[tipo|Integer,session.db|Untyped,session.idempresa|Untyped,]
DECLARE @TIPO_DISTRIBUCION INT

SET @TIPO_DISTRIBUCION = CAST(ISNULL(:TIPO,0) AS INT)

SELECT *, (APELLIDOS + ', ' + NOMBRE + ' (' + INICIALES +')') as usuarios, tku
FROM <#SESSION.DB/>.DBO.USUARIOS
WHERE ACTIVO = 1 AND IDEMPRESA=<#SESSION.IDEMPRESA/>
AND IDUSUARIO NOT IN (SELECT IDUSUARIO FROM <#SESSION.DB/>.DBO.EMPRESA_DISTRIBUCION_PROSPECTOS WHERE IDEMPRESA=<#SESSION.IDEMPRESA/> AND TIPO_DISTRIBUCION = @TIPO_DISTRIBUCION)