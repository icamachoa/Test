//[jsoncobros|Text,]
-- SELECT
DECLARE @TABLATEMP TABLE (ID INT IDENTITY,bd VARCHAR(512), NOPARCIALIDAD VARCHAR(500),FECHAHORA DATETIME, MONTO FLOAT, COMISION FLOAT, PAGADO INT, IDVENTA INT, IDVENTA_LOCAL INT, IDVENTACOBRO_LOCAL INT)
DECLARE @TBLVENTACOBROS TABLE (ID INT IDENTITY,IDVENTACOBRO INT, IDVENTACOBRO_LOCAL INT,IDVENTA INT, IDVENTA_LOCAL INT)

DECLARE @TO INT, @TOTAL INT, @CONTEO INT

DECLARE @EXECSQL nvarchar(500)
DECLARE @NOPARCIALIDAD INT
DECLARE @FECHAHORA DATETIME
DECLARE @MONTO FLOAT
DECLARE @COMISION FLOAT
DECLARE @PAGADO FLOAT
DECLARE @IDVENTA INT
DECLARE @BD VARCHAR(512)
DECLARE @IDVENTA_LOCAL INT
DECLARE @IDVENTACOBRO_LOCAL INT

SET @TO = 1


INSERT INTO @TABLATEMP (bd, NOPARCIALIDAD,FECHAHORA, MONTO, COMISION, PAGADO, IDVENTA, IDVENTA_LOCAL, IDVENTACOBRO_LOCAL)
Select
       max(case when NAME='bd' then STRINGVALUE else '' end) as bd,
       max(case when NAME='noparcialidad' then STRINGVALUE else '' end) as noparcialidad,
       max(case when NAME='fechahora' then STRINGVALUE else '' end) as fechahora,
       max(case when NAME='monto' then STRINGVALUE else '' end) as monto,
       max(case when NAME='comision' then STRINGVALUE else '' end) as comision,
       max(case when NAME='pagado' then STRINGVALUE else '' end) as pagado,
   	   max(case when NAME='idventa' then STRINGVALUE  else '' end) as idventa,
       max(case when NAME='idventa_local' then  STRINGVALUE  else '' end) as idventa_local,
       max(case when NAME='idventacobro_local' then STRINGVALUE else '' end) as idventacobro_local
from SALESUP_CT.dbo.parseJSON(:JSONCOBROS)
WHERE parent_id IS NOT NULL
group by PARENT_ID

SELECT @TOTAL = COUNT(*) FROM @TABLATEMP WHERE bd != ''

WHILE @TO <= @TOTAL
BEGIN
	SELECT @BD = bd, @NOPARCIALIDAD = NOPARCIALIDAD, @FECHAHORA = FECHAHORA,@MONTO = MONTO, @COMISION = COMISION, @PAGADO = PAGADO, @IDVENTA = IDVENTA, 
	@IDVENTA_LOCAL = IDVENTA_LOCAL, @IDVENTACOBRO_LOCAL = IDVENTACOBRO_LOCAL 
	FROM @TABLATEMP WHERE ID = @TO
	
	SET @EXECSQL = 'EXEC ' + @BD + '.DBO.SP_INSERTA_VENTAS_COBROS_MV ' + CAST(@NOPARCIALIDAD AS VARCHAR(12)) + ', ' 
	SET @EXECSQL = @EXECSQL + '''' + CAST(@FECHAHORA AS VARCHAR(512)) + ''', ' + CAST(@MONTO AS VARCHAR(12)) + ', ' 
	SET @EXECSQL = @EXECSQL + CAST(@COMISION AS VARCHAR(12)) + ', ' + CAST(@PAGADO AS VARCHAR(12)) + ', '+ CAST(@IDVENTA AS VARCHAR(12)) + ', ' 
	SET @EXECSQL = @EXECSQL + CAST(@IDVENTACOBRO_LOCAL AS VARCHAR(12)) + ', ' + CAST(@IDVENTA_LOCAL AS VARCHAR(12)) + ' '
 	
 	INSERT INTO @TBLVENTACOBROS (IDVENTACOBRO, IDVENTACOBRO_LOCAL, IDVENTA, IDVENTA_LOCAL)
 	EXEC(@EXECSQL)
	SET @TO = @TO + 1
END

SELECT * FROM @TBLVENTACOBROS