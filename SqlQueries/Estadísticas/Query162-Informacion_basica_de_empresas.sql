//[session.db|Untyped,idprospecto|Integer,]
--select
DECLARE @IDPROSPECTO INT

SET @IDPROSPECTO = ISNULL(:IDPROSPECTO,0)

SELECT ISNULL(P.DIRECCION1,'') + ' ' + ISNULL(P.DIRECCION2,'') + ' ' + ISNULL(CIUDAD,'')+ ', ' + ISNULL(ESTADO,'') + ' '+ ISNULL(P.IDPAIS,'')  AS DIRECCION,PS.COMENTARIO, P.NOMBRE+ ' ' +P.APELLIDOS AS NOMBRE,(<#SESSION.DB/>.DBO.TIEMPO_TXT (PS.FECHAHORA,GETDATE())) AS ULTIMO_CONTACTO_TIEMPO 
FROM <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO PS, <#SESSION.DB/>.DBO.PROSPECTOS P 
LEFT JOIN <#SESSION.DB/>.DBO.ESTADOS ES ON ES.IDESTADO = P.IDESTADO AND ES.IDPAIS = P.IDPAIS
WHERE PS.IDSEGUIMIENTO = P.IDULTIMOSEGUIMIENTO AND P.IDPROSPECTO = @IDPROSPECTO