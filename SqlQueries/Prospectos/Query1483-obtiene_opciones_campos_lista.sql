//[session.db|Untyped,session.idempresa|Untyped,indice|Integer,]
-- select
/*PROTEGIDO*/
DECLARE @IDCAMPO INT

SELECT @IDCAMPO = IDCAMPO FROM <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS WHERE IDEMPRESA = <#SESSION.IDEMPRESA/> AND INDICE = ISNULL(:INDICE,0)

SELECT * FROM <#SESSION.DB/>.dbo.EMPRESAS_CAMPOS_OPCIONES WHERE IDCAMPO = @IDCAMPO ORDER BY OPCION