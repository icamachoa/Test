//[session.db|Untyped,session.idusuario|Untyped,]
DECLARE @COLS INT
DECLARE @ROWS INT

SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL60 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 60
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL59 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 59
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL58 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 58
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL57 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 57
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL56 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 56
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL55 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 55
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL54 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 54
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL53 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 53
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL52 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 52
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL51 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 51
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL50 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 50
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL49 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 49
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL48 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 48
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL47 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 47
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL46 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 46
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL45 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 45
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL44 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 44
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL43 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 43
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL43 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 42
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL41 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 41
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL40 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 40
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL39 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 39
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL38 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 38
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL37 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 37
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL36 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 36
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL35 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 35
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL34 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 34
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL33 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 33
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL32 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 32
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL31 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 31
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL30 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 30
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL29 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 29
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL28 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 28
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL27 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 27
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL26 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 26
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL25 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 25
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL24 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 24
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL23 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 23
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL22 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 22
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL21 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 21
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL20 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 20
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL19 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 19
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL18 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 18
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL17 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 17
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL16 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 16
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL15 != '')
IF @COLS IS NULL AND @ROWS > 0  SET @COLS = 15
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL14 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 14
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL13 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 13
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL12 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 12
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL11 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 11
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL10 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 10
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL9 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 9
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL8 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 8
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL7 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 7
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL6 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 6
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL5 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 5
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL4 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 4
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL3 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 3
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL2 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 2
SET @ROWS = (SELECT COUNT(*) FROM <#SESSION.DB/>.DBO.PROSPECTOS_IMPORTACION WHERE IDUSUARIO = <#SESSION.IDUSUARIO/> AND  COL1 != '')
IF @COLS IS NULL AND @ROWS > 0   SET @COLS = 1
IF @COLS IS NULL SET @COLS = 0

SELECT @COLS AS COLS