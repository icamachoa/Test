//[session.db|Untyped,session.idusuario|Untyped,]
--SELECT
DECLARE @TABLA TABLE( NoCerrar varchar(1), TipoSuceso int ,Icono varchar(64), Titulo varchar(1028), Id int, Mensaje varchar(1028), Normal  varchar(21), Fecha varchar(32), TipoAlerta int)

INSERT INTO @TABLA ( NoCerrar, TipoSuceso, Icono , Titulo , Id, Mensaje, Normal, Fecha, TipoAlerta)
SELECT
CASE WHEN t.IDSUCESO IN ( 5, 14, 20, 25, 24, 28, 32, 53, 58, 62, 63 ) THEN '1' ELSE '' END ,
t.IDSUCESO,
CASE SECCION WHEN 4 THEN 'fa-share-square' WHEN 5 THEN 'fa-calendar' WHEN 0 THEN 'fa-bell' ELSE 'fa-user' END as Icono,
SUCESO AS Titulo,IDUSUARIOALERTA AS Id, LEFT(ALERTA,128) AS Mensaje, 'True' as Normal, SALESUP_ct.DBO.FormatoFecha(A.FECHA, 2) AS Fecha
,CASE  WHEN IDMETA IS NULL THEN 1 ELSE 2 END 
FROM
 <#SESSION.DB/>.DBO.USUARIOS_ALERTAS A WITH(NOLOCK)
 JOIN <#SESSION.DB/>.DBO.USUARIOS_SUCESOS S WITH(NOLOCK) ON S.IDSUCESO =  A.IDSUCESO
 JOIN SALESUP_CT.dbo.TIPOS_SUCESOS T WITH(NOLOCK) ON T.IDSUCESO = S.TIPO
 LEFT JOIN <#SESSION.DB/>.DBO.TAREAS TR WITH(NOLOCK) ON TR.IDTAREA = S.IDTAREA
 LEFT JOIN <#SESSION.DB/>.DBO.CITAS C WITH(NOLOCK) ON C.IDCITA = S.IDCITA
WHERE A.IDUSUARIO=<#SESSION.IDUSUARIO> AND A.NOTIFICADO = 0 AND S.IDMETA IS NULL
AND ISNULL(ALERTA, '') !=''

ORDER BY S.FECHAHORA DESC , A.FECHA DESC

UPDATE <#SESSION.DB/>.DBO.USUARIOS_ALERTAS WITH(ROWLOCK) 
SET NOTIFICADO = 1 
WHERE IDUSUARIOALERTA IN (SELECT ID FROM @TABLA WHERE TipoSuceso NOT IN (5, 14, 20, 25, 24, 28, 32, 53, 58, 62, 63) ) 


SELECT * FROM @TABLA
