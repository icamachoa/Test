//[aidseccion|Integer,]

--select
declare @aIDSECCION int
set @aIDSECCION=ISNULL(:aIDSECCION,0)
SELECT *, @aIDSECCION as aIDSECCION FROM V_SUCESOS_SECCIONES ORDER BY IDSECCION