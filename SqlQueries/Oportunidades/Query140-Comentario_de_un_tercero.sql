//[seguimiento|Text,session.db|Untyped,idoportunidad|Integer,session.idusuario|Untyped,session.convertcode|Untyped,]
--insert
/*PROTEGIDO*/
DECLARE @IDPROSPECTO INT
DECLARE @SEGUIMIENTO VARCHAR(8000)
DECLARE @IDOPORTUNIDAD INT = :IDOPORTUNIDAD

SET @SEGUIMIENTO=CAST(:SEGUIMIENTO AS VARCHAR(8000))

  SELECT @IDPROSPECTO=IDPROSPECTO FROM <#SESSION.DB/>.DBO.OPORTUNIDADES WHERE IDOPORTUNIDAD = @IDOPORTUNIDAD


  INSERT INTO <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO
  (IDPROSPECTO, IDUSUARIO, IDOPORTUNIDAD, COMENTARIO)
  VALUES 
  (@IDPROSPECTO, <#SESSION.IDUSUARIO/>, @IDOPORTUNIDAD, @SEGUIMIENTO)
  
  DECLARE @ID INT
  
  SELECT TOP 1 @ID=IDSEGUIMIENTO FROM <#SESSION.DB/>.DBO.PROSPECTOS_SEGUIMIENTO
  WHERE 
    IDOPORTUNIDAD=@IDOPORTUNIDAD AND IDUSUARIO = <#SESSION.IDUSUARIO/>
  ORDER BY IDSEGUIMIENTO DESC
  
EXEC <#SESSION.DB/>.DBO.SP_INGRESA_SUCESOS_OPORTUNIDADES <#SESSION.IDUSUARIO/>,10,@IDPROSPECTO,@IDOPORTUNIDAD,<#SESSION.CONVERTCODE/>, '',@ID