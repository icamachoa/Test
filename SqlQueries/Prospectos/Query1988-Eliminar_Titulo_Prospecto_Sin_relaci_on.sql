//[session.idempresa|Untyped,tk|Text,session.db|Untyped,]
--DELETE 
DECLARE @IDEMPRESA INT 
DECLARE @TKELIMINAR VARCHAR(256) 
DECLARE @IDTITULO INT 
SET @IDEMPRESA= <#SESSION.IDEMPRESA/>
SET @TKELIMINAR = ISNULL(:TK, '') 
SELECT @IDTITULO=IDTITULO FROM <#SESSION.DB/>.DBO.EMPRESAS_TITULOS WHERE IDEMPRESA=@IDEMPRESA AND TKTI=@TKELIMINAR 
DELETE <#SESSION.DB/>.DBO.EMPRESAS_TITULOS WHERE IDEMPRESA=@IDEMPRESA AND IDTITULO=@IDTITULO 