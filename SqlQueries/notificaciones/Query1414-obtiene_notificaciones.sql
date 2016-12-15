//[session.db|Untyped,session.idempresa|Untyped,session.idusuario|Untyped,idseccion|Integer,]
SELECT S.MODULO,S.IDSUCESO, SUCESO, NIVELMINIMO, EXPLICACION,
ISNULL(UC.NOTIFICA_EMAIL, 0) AS NOTIFICA_EMAIL, ISNULL(UC.NOTIFICA_SMS, 0) AS NOTIFICA_SMS,
ISNULL(UC.NOTIFICA_ALERTA, 0) AS NOTIFICA_ALERTA, ISNULL(UC.NOTIFICA_PUSH, 0) AS NOTIFICA_PUSH,
ISNULL(SUCESOMOVIL, 0) AS sUCESOMOVIL, ISNULL(NOTIFICAR, 0) AS NOTIFICAR
FROM 
SALESUP_CT.dbo.TIPOS_SUCESOS S 
LEFT JOIN SALESUP_CT.dbo.NOTIFICACIONES N ON  N.IDSUCESO = S.IDSUCESO 
LEFT JOIN <#SESSION.DB/>.dbo.EMPRESAS_NOTIFICACION_CONFIG EC ON EC.IDNOTIFICACION = N.IDNOTIFICACION  AND  EC.IDEMPRESA = <#SESSION.IDEMPRESA/> 
LEFT JOIN <#SESSION.DB/>.dbo.USUARIOS_NOTIFICACION_CONFIG UC ON EC.IDEMPRESANOTIFICACION = UC.IDEMPRESANOTIFICACION AND  UC.IDUSUARIO = <#SESSION.IDUSUARIO/>
WHERE S.SECCION = :IDSECCION  AND S.NOTIFICA = 1
GROUP BY S.MODULO,S.IDSUCESO, SUCESO, NIVELMINIMO, EXPLICACION,UC.NOTIFICA_EMAIL,UC.NOTIFICA_SMS,UC.NOTIFICA_ALERTA,UC.NOTIFICA_PUSH,SUCESOMOVIL,NOTIFICAR
ORDER BY SUCESO