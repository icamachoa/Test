//[visto|Integer,idticket|Text,session.idusuario|Untyped,session.idempresa|Untyped,]
--UPDATE
/*PROTEGIDO*/
/*SEP2015*/
UPDATE CONTROL.TICKETS.DBO.TICKETS 
SET VISTO_CLIENTE = ISNULL(:VISTO,0)
WHERE TKT = ISNULL(:IDTICKET,'') AND IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDEMPRESA = <#SESSION.IDEMPRESA/>