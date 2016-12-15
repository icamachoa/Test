//[session.idempresa|Untyped,session.idusuario|Untyped,session.idgrupo|Untyped,session.db|Untyped,]
-- select

DECLARE @IDEMPRESA INT
DECLARE @IDUSUARIO INT
DECLARE @IDGRUPO INT

SET @IDEMPRESA = <#SESSION.IDEMPRESA/>
SET @IDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDGRUPO = <#SESSION.IDGRUPO/>

SELECT RC.IDREPORTECONFIG, RC.NOMBRE, RC.AGRUPARPOR, RC.DESISTEMA, VA.AGRUPACION
 FROM <#SESSION.DB/>.DBO.REPORTES_CONFIGURACIONES RC
 LEFT JOIN SALESUP_CT.DBO.V_AGRUPACIONES VA ON VA.IDAGRUPACION = RC.AGRUPARPOR
 WHERE IDEMPRESA = @IDEMPRESA 
 AND 
 (
  RC.IDUSUARIO = @IDUSUARIO OR (RC.IDGRUPOS_COMPARTIDOS = '0' AND RC.IDUSUARIOS_COMPARTIDOS = '0') OR (@IDGRUPO IN (SELECT SPLITVALUE FROM DBO.SPLIT(RC.IDGRUPOS_COMPARTIDOS,','))) OR (@IDUSUARIO IN (SELECT SPLITVALUE FROM DBO.SPLIT(RC.IDUSUARIOS_COMPARTIDOS,',')))
 )
AND RC.IDREPORTE = 2
 ORDER BY RC.DESISTEMA DESC,RC.NOMBRE
