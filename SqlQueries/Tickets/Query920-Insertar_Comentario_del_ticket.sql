//[r|Integer,c|Integer,idticket|Text,idtc|Integer,link_adjunto|Text,session.idproducto|Untyped,session.idempresa|Untyped,tipousuario|Integer,session.idusuario|Untyped,textrespuesta|Text,ticketnormalizado|Text,idestado|Integer,visto|Integer,]
--INSERT
DECLARE @URL VARCHAR(512), @ARCHIVO VARCHAR(512)
DECLARE @C INT, @IDTC INT, @R INT, @IDTICKET INT
SET @R = CAST(ISNULL(:R,0) AS INT)
SET @C = CAST(ISNULL(:C,0) AS INT)

/*Modificar ticket*/
SELECT @IDTICKET = IDTICKET FROM CONTROL.TICKETS.DBO.TICKETS WHERE TKT = ISNULL(:IDTICKET,'')
/*Modificar ticket*/

IF @C = 0
  SET @C = 1
  
SET @IDTC = CAST(ISNULL(:IDTC,0) AS INT)  
   
SET @ARCHIVO = :link_adjunto

IF @ARCHIVO != ''
BEGIN
  SET @ARCHIVO = REPLACE(@ARCHIVO,char(10),'')
  SET @ARCHIVO = REPLACE(@ARCHIVO,char(9),'')
  SET @ARCHIVO = REPLACE(@ARCHIVO,char(13),'')
 
  EXEC SP_GeneraURL '<#SESSION.IDPRODUCTO/>','<#SESSION.IDEMPRESA/>', @URL OUT
  SET @URL=@URL+'/'+@ARCHIVO
END


IF @IDTC <> 0
BEGIN
   UPDATE CONTROL.TICKETS.DBO.TICKET_COMENTARIOS SET IDCALIFICACION = @C WHERE IDTICKETCOMENTARIO = @IDTC
END

IF @C = 7
BEGIN
   UPDATE CONTROL.TICKETS.DBO.TICKET_COMENTARIOS SET IDCALIFICACION = @C WHERE IDTICKET = @IDTICKET AND IDCALIFICACION IN (2,6)
END

IF @R = 0
   SET @C = 1

INSERT INTO CONTROL.TICKETS.DBO.TICKET_COMENTARIOS (IDTICKET, TIPOUSUARIO, IDUSUARIO, COMENTARIO, ADJUNTO, ADJUNTO_LINK, FECHA,IDCALIFICACION)
VALUES (@IDTICKET,CAST(ISNULL(:TIPOUSUARIO,0) AS INT),<#SESSION.IDUSUARIO/>,:TextRespuesta,ISNULL(:TICKETNORMALIZADO,''),@URL,GETDATE(), @C)

DECLARE @IDRESPONSABLE INT
SELECT @IDRESPONSABLE = IDRESPONSABLE FROM CONTROL.TICKETS.DBO.TICKETS WHERE IDTICKET = @IDTICKET
IF @IDRESPONSABLE = 0
BEGIN
   SELECT TOP 1 @IDRESPONSABLE = IDUSUARIO FROM CONTROL.TICKETS.DBO.TICKET_COMENTARIOS WHERE IDTICKET = @IDTICKET AND TIPOUSUARIO = 2 ORDER BY 1 ASC
   UPDATE CONTROL.TICKETS.DBO.TICKETS SET IDRESPONSABLE = @IDRESPONSABLE WHERE IDTICKET = @IDTICKET
END


UPDATE CONTROL.TICKETS.DBO.TICKETS 
SET IDESTADO = CAST(ISNULL(:IDESTADO,0) AS INT),
TIPOUSUARIO_ULTIMAMODIFICACION = CAST(ISNULL(:TIPOUSUARIO,0) AS INT), 
IDUSUARIO_ULTIMAMODIFICACION = CAST('<#SESSION.IDUSUARIO/>' AS INT),
FECHA_ULTIMAMODIFICACION = GETDATE(),
FECHA_CIERRE = NULL,
VISTO = CAST(ISNULL(:VISTO,0) AS INT),
VISTO_CLIENTE = 1
WHERE IDTICKET = @IDTICKET