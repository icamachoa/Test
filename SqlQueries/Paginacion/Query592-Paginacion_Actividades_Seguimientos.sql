//[session.convertcode|Untyped,fecha_hasta|Text,fecha_desde|Text,session.db|Untyped,idusuario|Integer,]
--SELECT 
/*PROTEGIDO*/

DECLARE @FECHA_INICIAL varchar(max), @FECHA_FINAL varchar(max)
DECLARE @CONVERTCODE INT, @IDUSUARIO INT

SET @CONVERTCODE = <#SESSION.CONVERTCODE/>

SET @FECHA_FINAL = ISNULL(:FECHA_HASTA,'')
SET @FECHA_INICIAL= ISNULL(:FECHA_DESDE,'')
SET @IDUSUARIO = ISNULL(:IDUSUARIO,0)

SELECT count(*) AS TOTALN, @FECHA_FINAL AS FECHA_HASTA, @FECHA_INICIAL AS FECHA_DESDE, @IDUSUARIO AS IDUSUARIO
FROM 
<#SESSION.DB/>.dbo.PROSPECTOS P
  JOIN <#SESSION.DB/>.dbo.PROSPECTOS_SEGUIMIENTO PSEG ON P.IDULTIMOSEGUIMIENTO = PSEG.IDSEGUIMIENTO
  LEFT JOIN <#SESSION.DB/>.dbo.PROSPECTOS_ASIGNADOS PA ON P.IDPROSPECTO = PA.IDPROSPECTO
  LEFT JOIN <#SESSION.DB/>.dbo.PROSPECTOS_FASES F ON  P.IDFASE=F.IDFASE 
  LEFT JOIN <#SESSION.DB/>.dbo.OPORTUNIDADES O ON O.IDPROSPECTO = P.IDPROSPECTO,
<#SESSION.DB/>.dbo.USUARIOS U
WHERE 
PA.IDUSUARIO= @IDUSUARIO AND P.IDUSUARIO = U.IDUSUARIO AND PA.IDUSUARIO=U.IDUSUARIO

AND 
 SISTEMA = 0 AND 
 ( 
   (PA.IDUSUARIO = O.IDUSUARIO AND <#SESSION.DB/>.dbo.GETONLYDATE(P.FECHA_ULTIMOSEGUIMIENTO) = <#SESSION.DB/>.dbo.GETONLYDATE(O.FECHA_ULTIMOSEGUIMIENTO) AND <#SESSION.DB/>.dbo.GETONLYDATE(P.FECHA_ULTIMOSEGUIMIENTO) BETWEEN CONVERT(DATETIME,@FECHA_INICIAL,@CONVERTCODE) AND CONVERT(DATETIME,@FECHA_FINAL,@CONVERTCODE))  OR
   (O.GANADA IS NULL AND ESCLIENTE = 0 AND ESOPORTUNIDAD = 0 AND <#SESSION.DB/>.dbo.GETONLYDATE(P.FECHA_ULTIMOSEGUIMIENTO) BETWEEN CONVERT(DATETIME,@FECHA_INICIAL,@CONVERTCODE) AND CONVERT(DATETIME,@FECHA_FINAL,@CONVERTCODE))  OR
   (PA.IDUSUARIO = O.IDUSUARIO AND  GANADA = 0 AND PERDIDA = 0 AND <#SESSION.DB/>.dbo.GETONLYDATE(O.FECHA_ULTIMOSEGUIMIENTO) BETWEEN CONVERT(DATETIME,@FECHA_INICIAL,@CONVERTCODE) AND CONVERT(DATETIME,@FECHA_FINAL,@CONVERTCODE))   
 )

    