//[session.idempresa|Untyped,session.idusuario|Untyped,idtabla|Integer,permisomodulo|Integer,descartado|Integer,p|Integer,b|Text,session.db|Untyped,spos|Integer,]
--select

/* @IDTABLA ES EL ID DE LA TABLA QUE SE TOMA DE LA VISTA SALESUP_CT.DBO.V_TABLAS
   4 -PROSPECTOS, 15 OPORTUNIDADES, 16 VENTAS
   
   @PERMISOMODULO ES EL ID DEL PERMISOS QUE SE TOMA DE LA VISTA SALESUP_DB.DBO.V_MODULOS_PERMISOS
   1-PROSPECTO, 2-OPORTUNIDADES, 3- VENTAS Y 4-CLIENTES
   
   @TIPO, 0 ES DATOS, 1 ES PAGINACION
  
   @HOWMANY ES CUANTOS REGISTROS SE REGRESAN DEL TOTAL DE LA CONSULTA
   @PAGE ES LA PAGINA QUE INTERESA 
   PARA LA PAGINACION ESTOS VALORES DEBEN SER 1 AMBOS.
   
   @DESCARTADO   
     0- PROSPECTOS, CLIENTES U OPORTUNIDADES DESCARTADAS
   	 1- PROSPECTOS, CLIENTES U OPORTUNIDADES DESCARTADAS
*/


DECLARE @IDEMPRESA INT, @IDUSUARIO INT
DECLARE @DESCARTADOS INT, @IDTABLA INT, @PERMISOMODULO INT
DECLARE @TIPO INT, @HOWMANY INT, @PAGE INT, @START INT
DECLARE @TEXTO VARCHAR(256)

SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @IDUSUARIO = CAST('<#SESSION.IDUSUARIO/>' AS INT)

SET @IDTABLA = ISNULL(:IDTABLA,0)
SET @PERMISOMODULO = ISNULL(:PERMISOMODULO,0) 
SET @DESCARTADOS = ISNULL(:DESCARTADO,0)

SET @PAGE = ISNULL(:P,0)
SET @START = ISNULL(:SPOS,0)
SET @TEXTO = :B

SET @HOWMANY = 5
IF @START > 0 BEGIN SET @HOWMANY = 20 END
SET @TIPO = 0

EXEC <#SESSION.DB/>.DBO.SP_BUSQUEDA_EN_BASE @IDTABLA, @PERMISOMODULO, @IDUSUARIO, @IDEMPRESA, @TEXTO, @DESCARTADOS , @TIPO, @HOWMANY, @PAGE
