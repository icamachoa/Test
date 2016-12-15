//[session.idempresa|Untyped,idusuario|Integer,compartircon|Integer,texto|Text,session.idusuario|Untyped,session.idgrupo|Untyped,session.nivel|Untyped,session.db|Untyped,]
--SELECT 
/*PROTEGIDO*/

DECLARE @IDUSUARIO         INT 
DECLARE @IDEMPRESA         INT 
DECLARE @COMPARTIRCON      VARCHAR(MAX) 
DECLARE @IDGRUPO           INT
DECLARE @TEXTO             VARCHAR(100)
DECLARE @TKU VARCHAR(128)
DECLARE @IDUSUARIOSESSION INT 
DECLARE @IDGRUPOSESSION INT 
DECLARE @NIVEL INT 
DECLARE @CRITCOMPARTIRCON VARCHAR(MAX) 
DECLARE @CRITPOREJECUTIVO VARCHAR(MAX)
DECLARE @CRITTEXTO VARCHAR (MAX)
DECLARE @SQLTEXT VARCHAR(MAX)
DECLARE @CRITERIOAUT VARCHAR(MAX)



SET @IDEMPRESA =<#SESSION.IDEMPRESA/>
SET @IDUSUARIO=ISNULL(:IDUSUARIO, 0) 
SET @COMPARTIRCON=ISNULL(REPLACE(:COMPARTIRCON, -2, ''), '')
SET @TEXTO= ISNULL(:TEXTO, '')
SET @IDUSUARIOSESSION =<#SESSION.IDUSUARIO/>
SET @IDGRUPOSESSION=<#SESSION.IDGRUPO/>
SET @NIVEL =<#SESSION.NIVEL/>

SET @CRITERIOAUT = (CASE
	WHEN @COMPARTIRCON = '' THEN 'AND UP.IDUSUARIO IN(SELECT IDUSUARIO FROM <#SESSION.DB/>.DBO.ObtieneUsuariosAutorizados('+CAST(@IDUSUARIOSESSION AS VARCHAR(MAX))+'))'
	WHEN @COMPARTIRCON != '' THEN ''
END)

SET @CRITCOMPARTIRCON= (CASE WHEN @COMPARTIRCON != '' THEN ' AND UP.COMPARTIRCON='+@COMPARTIRCON ELSE '' END) 
SET @CRITPOREJECUTIVO=(CASE WHEN (@IDUSUARIO > 0) THEN 'AND UP.IDUSUARIO='+CAST(@IDUSUARIO AS VARCHAR(MAX))
							WHEN (@IDUSUARIO='' AND @TEXTO='' AND @COMPARTIRCON='') THEN 'AND UP.IDUSUARIO='+CAST(@IDUSUARIOSESSION AS VARCHAR(MAX))
							ELSE '' END)
				 
SET @CRITTEXTO= (CASE WHEN 	@TEXTO!='' THEN 'AND UP.DESCRIPCION LIKE ''%'+@TEXTO+'%''  ' ELSE '' END)

					

SET @SQLTEXT=''					
	+'SELECT U.TKU,UP.IDPLANTILLA,UP.IDEMPRESA, UP.TK, UP.TKM, LTRIM(RTRIM(DESCRIPCION)) AS DESCRIPCION, U.INICIALES AS NOMBRE, U.NOMBRE+'' ''+U.APELLIDOS AS NOMBRECOMPLETO, 
	   CASE WHEN TIPOCORREO = 1 THEN ''Correo'' ELSE ''SMS'' END AS ELTIPO,UP.TIPOCORREO, UP.TIPOCORREO,
	   CASE WHEN UP.COMPARTIRCON=-1 THEN ''Empresa'' WHEN UP.COMPARTIRCON=0  THEN ''Nadie''	ELSE ''Grupo'' END AS COMPARTIR,
	   CASE WHEN UP.COMPARTIRCON=-1 THEN ''Empresa'' WHEN UP.COMPARTIRCON=0  THEN ''Nadie''	ELSE UG.GRUPO END AS COMP, UG.IDUSUARIOGRUPO, 
	   UP.COMPARTIRCON,
	   replace(up.asunto,''"'',''&quot;'') as asunto, UP.IDPLANTILLA, UP.TK, UP.TKM,
	   UP.IDUSUARIO , UP.CUERPO, U.NIVEL

 FROM <#SESSION.DB/>.DBO.USUARIOS_PLANTILLAS UP
 	  LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS U ON U.IDUSUARIO=UP.IDUSUARIO
	  LEFT JOIN <#SESSION.DB/>.DBO.USUARIOS_GRUPOS UG ON  UP.COMPARTIRCON=UG.IDUSUARIOGRUPO
	 WHERE  UP.IDEMPRESA='+CAST(@IDEMPRESA AS VARCHAR(MAX))+'
	  '+@CRITERIOAUT+'
	  '+@CRITPOREJECUTIVO+'
	  '+@CRITCOMPARTIRCON+'
	  '+@CRITTEXTO+'
	  ORDER BY LTRIM(RTRIM(DESCRIPCION)) ASC'
	  
EXEC(@SQLTEXT)   