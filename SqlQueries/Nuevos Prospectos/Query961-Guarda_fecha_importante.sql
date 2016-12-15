//[plantilla|Text,accion|Integer,idfecharecordar|Integer,tipocco|Integer,tipocc|Integer,tipopara|Integer,para|Text,cc|Text,cco|Text,session.db|Untyped,ocasion|Text,dia|Integer,mes|Integer,ano|Integer,tkfi|Text,]
-- INSERT
DECLARE @CC VARCHAR(255)
DECLARE @CCO VARCHAR(255)
DECLARE @PARA VARCHAR(255)
DECLARE @TIPOPARA INT
DECLARE @TIPOCC INT
DECLARE @TIPOCCO INT
DECLARE @IDFECHARECORDAR INT
DECLARE @ACCION INT
DECLARE @PLANTILLA VARCHAR(MAX)
SET @PLANTILLA=ISNULL(:PLANTILLA,'')
SET @ACCION=ISNULL(:ACCION,0)
SET @IDFECHARECORDAR=0
SET @TIPOCCO=ISNULL(:TIPOCCO,0)
SET @TIPOCC=ISNULL(:TIPOCC,0)
SET @TIPOPARA=ISNULL(:TIPOPARA,0)



DECLARE @TKFI VARCHAR(64)
SET @TKFI = ISNULL(:TKFI,'')
IF @TKFI != '' BEGIN SELECT @IDFECHARECORDAR = IDFECHARECORDAR FROM <#SESSION.DB/>.dbo.FECHAS_IMPORTANTES WHERE TKFI = @TKFI END




IF(CAST(@TIPOPARA AS INT)=3)
BEGIN
	 SET @PARA = ISNULL(:PARA,'')
END
ELSE
BEGIN
	 SET @PARA = ''
END
IF(CAST(@TIPOCC AS INT)=3)
BEGIN
	 SET @CC = ISNULL(:CC,'')
END
ELSE
BEGIN
	 SET @CC = ''
END
IF(CAST(@TIPOCCO AS INT)=3)
BEGIN
	 SET @CCO = ISNULL(:CCO,'')
END
ELSE
BEGIN
	 SET @CCO = ''
END

UPDATE <#SESSION.DB/>.DBO.FECHAS_IMPORTANTES SET
	IDACCION = @ACCION,
	OCASION = ISNULL(:OCASION,''),
	DIA = ISNULL(:DIA,0),
	MES = ISNULL(:MES,0),
	ANIO = ISNULL(:ANO,0),
	IDPLANTILLA = CAST(@PLANTILLA AS INT),
	PARA = @PARA,
	CC = @CC,
	CCO = @CCO,
	TIPOPARA = CAST(@TIPOPARA AS INT),
	TIPOCC = CAST(@TIPOCC AS INT),
	TIPOCCO = CAST(@TIPOCCO AS INT)
WHERE IDFECHARECORDAR = CAST(@IDFECHARECORDAR AS INT)