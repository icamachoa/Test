//[]
SELECT 'CS-'+cast(IDCampo as varchar(max))as Id, Campo, ID AS Nombre,
CASE WHEN (IDCAMPO = 4) OR (IDCAMPO = 18) OR (IDCAMPO = 19) OR (IDCAMPO = 20) OR (IDCAMPO = 21) OR (IDCAMPO = 22) OR(IDCAMPO= 5) OR (IDCAMPO=29) OR (IDCAMPO=30) THEN '1' END EsSelect,
CASE WHEN (IDCAMPO = 6) THEN '1' END as EsCorreo,
CASE WHEN (IDCAMPO = 17) THEN '1' END AS EsTextArea,
CASE WHEN NOT( (IDCAMPO = 4) OR (IDCAMPO = 6) OR (IDCAMPO = 18) OR (IDCAMPO = 19) OR (IDCAMPO = 20) OR (IDCAMPO = 21) OR (IDCAMPO = 22) OR (IDCAMPO=17) OR(IDCAMPO= 5) OR (IDCAMPO=29) OR (IDCAMPO=30)) THEN '1' END AS EsInput
FROM SALESUP_CT.DBO.CAMPOS WHERE FCONTACTO = 1
