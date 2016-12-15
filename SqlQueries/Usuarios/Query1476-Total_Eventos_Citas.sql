//[session.idusuario|Untyped,idu|Text,fechaactual|Text,session.gmt|Untyped,r|Text,session.idempresa|Untyped,condicioncitas|Text,session.db|Untyped,]

--SELECT 

DECLARE @GMT INT, @SESSIONIDUSUARIO INT, @TO INT, @N INT, @IDCITA INT, @CONPROSPECTOS INT, @IDEMPRESA INT
DECLARE @MESACTUAL VARCHAR(MAX), @IDUSUARIO VARCHAR(MAX), @INVITADOS VARCHAR(MAX), @CONTACTOS VARCHAR(MAX), @IdsProspectos VARCHAR(MAX), @TksProspectos VARCHAR(MAX)
DECLARE @TB TABLE(N INT IDENTITY, IDCITA INT, Tipo VARCHAR(MAX), Color VARCHAR(MAX), id VARCHAR(MAX), title VARCHAR(MAX), className VARCHAR(MAX),
start DATETIME, [end] DATETIME, StrFecha VARCHAR(MAX), Lugar VARCHAR(MAX), hInicio VARCHAR(MAX), hFin VARCHAR(MAX), 
ConQuien VARCHAR(MAX), IdCompania VARCHAR(MAX), Empresa VARCHAR(MAX), Invitados VARCHAR(MAX), Idu VARCHAR(MAX),  MismoDia VARCHAR(1), FechaInicio VARCHAR(MAX), HoraInicio VARCHAR(10), FechaFin VARCHAR(MAX), 
HoraFin VARCHAR(10), DTF FLOAT, ConProspecto INT, Contactos VARCHAR(MAX), IdsProspectos VARCHAR(MAX), TksProspectos VARCHAR(MAX))
DECLARE @RANGO INT
DECLARE @SQL VARCHAR(MAX)
DECLARE @CONDICIONCITAS VARCHAR(MAX)

SET @SESSIONIDUSUARIO = <#SESSION.IDUSUARIO/>
SET @IDUSUARIO = ISNULL(:IDU,'') 
SET @MESACTUAL = ISNULL(:FechaActual,'')
SET @GMT = CAST('<#SESSION.GMT/>' AS INT )
SET @RANGO = CAST(ISNULL(:R,'') AS INT)
SET @IDEMPRESA = CAST('<#SESSION.IDEMPRESA/>' AS INT)
SET @CONDICIONCITAS= ISNULL(:CONDICIONCITAS,'')

SET @SQL ='
DECLARE @TO INT, @N INT
DECLARE @GMT INT
DECLARE @FECHA DATETIME, @FINICIO DATETIME, @FFIN DATETIME
DECLARE @IDUSUARIO VARCHAR(MAX)
DECLARE @IDEMPRESA INT
SET @GMT = '+CAST(@GMT AS VARCHAR(1000))+'
SET @IDUSUARIO = '''+@IDUSUARIO+'''
SET @IDEMPRESA = '+cast(@IDEMPRESA as varchar(1000))+'

IF '''+@MESACTUAL+''' != ''''
BEGIN
	SET @FECHA = CONVERT(DATETIME, '''+@MESACTUAL+''', 103 )
	SET @FINICIO = SALESUP_CT.dbo.RangoFecha(0, 5, @FECHA)
	SET @FFIN = SALESUP_CT.dbo.RangoFecha(1, 5, @FECHA)
END
ELSE
BEGIN
	SET @FINICIO = SALESUP_CT.dbo.RangoFecha(0, '+CAST(@RANGO AS VARCHAR(1000))+', NULL)
	SET @FFIN = SALESUP_CT.dbo.RangoFecha(1, '+CAST(@RANGO AS VARCHAR(1000))+', NULL)
END

SET @TO = 0
SET @N = 1


SELECT COUNT(*) AS Registros 
FROM <#SESSION.DB/>.dbo.CITAS C
JOIN <#SESSION.DB/>.dbo.CITAS_INVITADOS CI ON CI.IDPERSONA IN (SELECT SPLITVALUE FROM SALESUP_CT.DBO.SPLIT('''+CAST(@IDUSUARIO AS VARCHAR(1000))+''', '','') ) AND C.IDCITA = CI.IDCITA
JOIN <#SESSION.DB/>.dbo.USUARIOS U ON U.IDUSUARIO = CI.IDPERSONA
LEFT JOIN <#SESSION.DB/>.dbo.PROSPECTOS P ON P.IDPROSPECTO = CI.IDPERSONA
LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS COM ON COM.IDCOMPANIA = P.IDCOMPANIA
JOIN <#SESSION.DB/>.dbo.ObtieneUsuariosAutorizadosModulos (<#SESSION.IDUSUARIO/>,5,0) UP ON U.IDUSUARIO = UP.ID
WHERE 
U.IDEMPRESA = '+CAST(@IDEMPRESA AS VARCHAR(1000))+' AND C.ACTIVO = 1 '+@CONDICIONCITAS+'
'
EXEC (@SQL)
