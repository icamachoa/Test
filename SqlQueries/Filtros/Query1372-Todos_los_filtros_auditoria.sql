//[idpantalla|Integer,session.db|Untyped,session.idusuario|Untyped,session.convertcode|Untyped,]
--SELECT
DECLARE @FILTRO1 INT
DECLARE @FILTRO2 INT
DECLARE @FILTRO3 INT
DECLARE @FILTRO_FECHA1 VARCHAR(10)
DECLARE @FILTRO_FECHA2 VARCHAR(10)
DECLARE @IDPANTALLA INT

SET @IDPANTALLA = ISNULL(:IDPANTALLA,0)

IF NOT EXISTS (SELECT TIPO FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=405 AND TIPO = 1)
  SELECT @FILTRO1=-1
ELSE  
  SELECT @FILTRO1=CAST(TEXTO AS INT)  FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=405 AND TIPO =1
  

IF NOT EXISTS (SELECT TIPO FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=405 AND TIPO =2 )
  SELECT @FILTRO2=0, @FILTRO3=0
ELSE  
  SELECT @FILTRO2=CAST(TEXTO AS INT), @FILTRO3=CAST(SQLTXT AS INT)  FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=405 AND TIPO =2

IF NOT EXISTS (SELECT TIPO FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=405 AND TIPO =3 )
  SELECT @FILTRO_FECHA1=CONVERT(VARCHAR(10),DATEADD(mm, DATEDIFF(m,0,getdate() )-0, 0),<#SESSION.CONVERTCODE/>), 
         @FILTRO_FECHA2=CONVERT(VARCHAR(10),GETDATE(),<#SESSION.CONVERTCODE/>)
ELSE  
  SELECT @FILTRO_FECHA1=TEXTO, @FILTRO_FECHA2=SQLTXT  FROM <#SESSION.DB/>.DBO.USUARIOS_FILTROS WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND IDPANTALLA=405 AND TIPO =3


SELECT @IDPANTALLA AS IDPANTALLA, @FILTRO1 AS FILTROTIPO,@FILTRO2 AS FILTROAGRUPAR,@FILTRO3 AS FILTROAGRUPARDETALLE , @FILTRO_FECHA1 AS FECHA_DESDE, @FILTRO_FECHA2 AS FECHA_HASTA   

