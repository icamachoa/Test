//[session.iddistribuidor|Untyped,]
--IF '<#SESSION.IDDISTRIBUIDOR/>' = '0'
SELECT 1 AS ESVENDEDOR
--ELSE
-- SELECT  ESVENDEDOR FROM CONTROL.DISTRIBUIDORES.DBO.DISTRIBUIDORES WHERE IDDISTRIBUIDOR = CAST('<#SESSION.IDDISTRIBUIDOR/>' AS INT) AND ESVENDEDOR = 1
 