//[session.idempresa|Untyped,idventana|Integer,session.db|Untyped,]
-- SELECT
/*PROTEGIDO*/

DECLARE @IDEMPRESA INT = <#SESSION.IDEMPRESA/>
DECLARE @IDVENTANA INT = ISNULL(:IDVENTANA,1)

select
CASE WHEN TIPO = 1 OR TIPO = 3 THEN 'unicos' ELSE '' END AS TIPO,
CASE 
WHEN NOMBRECAMPO = 'Correo' THEN 'Email' 
WHEN NOMBRECAMPO = 'Tel�fono 1' THEN 'Tel�fono'
WHEN NOMBRECAMPO = 'M�vil' THEN 'Tel�fono m�vil'
WHEN NOMBRECAMPO = '# Empleados' THEN 'N�mero empleados'
WHEN NOMBRECAMPO = 'Calle' THEN 'Direcci�n 1'
WHEN NOMBRECAMPO = 'Colonia' THEN 'Direcci�n 2'
WHEN NOMBRECAMPO = 'CP' THEN 'C�digo Postal'
WHEN NOMBRECAMPO = 'Comentario' THEN 'Comentarios'
WHEN NOMBRECAMPO = 'Estado' THEN 'Regi�n'
 
ELSE NOMBRECAMPO END AS NOMBRECAMPO
from <#SESSION.DB/>.DBO.empresas_campos_configuracion where idempresa = @IDEMPRESA and idventana = @IDVENTANA order by campo