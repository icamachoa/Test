//[idseleccionado|Text,tipoidseleccionado|Text,session.db|Untyped,session.idempresa|Untyped,session.idusuario|Untyped,]
--SELECT
DECLARE @IDPERSONAS VARCHAR(MAX)
DECLARE @TIPOSPERSONAS VARCHAR(MAX)
DECLARE @TABLAPERSONAS AS TABLE (ID INT, IDPERSONA INT, PERSONA VARCHAR(1000), TIPOPERSONA INT)
SET @IDPERSONAS=ISNULL(:IdSeleccionado,'')
SET @TIPOSPERSONAS=ISNULL(:TipoIdSeleccionado,'')

INSERT INTO @TABLAPERSONAS (ID,IDPERSONA,PERSONA,TIPOPERSONA)
SELECT
P.OCCURENCEID AS ID, 
(
	CASE WHEN T.SPLITVALUE=0 
		THEN '0' 
		ELSE 
			CASE WHEN ISNUMERIC(P.SPLITVALUE)= 1 
				THEN P.SPLITVALUE
				ELSE <#SESSION.DB/>.dbo.obtieneIdProspecto(P.SPLITVALUE, <#SESSION.IDEMPRESA/> ) 
			END
	END
) IDPERSONA, 
(CASE WHEN T.SPLITVALUE=0 THEN P.SPLITVALUE ELSE '' END) PERSONA,
T.SPLITVALUE AS TIPOPERSONA
FROM dbo.Split(@IDPERSONAS,',') P, dbo.Split(@TIPOSPERSONAS,',') T  
WHERE P.OCCURENCEID=T.OCCURENCEID 

--select * from @TABLAPERSONAS
IF (LEN(RTRIM(LTRIM(@IDPERSONAS)))>0)
BEGIN
  SELECT 
   2 AS LE,'Colaboradores' as make,U.IDUSUARIO AS Id,    
			'' AS Titulo , LTRIM(RTRIM(U.NOMBRE)) AS Nombre ,    
			dbo.NomalizaCadena(LTRIM(RTRIM(U.NOMBRE))) AS NomNorma,    
			ISNULL(LTRIM(RTRIM(U.APELLIDOS)),'') AS Apellido ,    
			dbo.NomalizaCadena(ISNULL(LTRIM(RTRIM(U.APELLIDOS)),'''')) AS ApeNorma,    
			'' AS Empresa, U.EMAIL AS Correo, '''' AS Sexo,    
			'' + '' AS Telefono, '' AS Movil,    
			'' AS Region,    
			0 EsCliente , LTRIM(RTRIM(U.INICIALES)) AS Iniciales,'' AS direccion1,'' AS direccion2  

   from <#SESSION.DB/>.dbo.USUARIOS U where  U.IDEMPRESA=<#SESSION.IDEMPRESA/> 
   /*AND U.IDUSUARIO IN (SELECT ID from <#SESSION.DB/>.dbo.ObtieneUsuariosAutorizadosModulos(<#SESSION.IDUSUARIO/>,5,0))  */  
   UNION
   SELECT 1 AS LE,'Contactos' as make, P.IDPROSPECTO AS Id, 
		ISNULL(P.TITULO+' ','') AS Titulo , LTRIM(RTRIM(P.NOMBRE)) AS Nombre , 
		dbo.NomalizaCadena(LTRIM(RTRIM(P.NOMBRE))) AS NomNorma, 
		ISNULL(LTRIM(RTRIM(P.APELLIDOS)),'') AS Apellido , 
		dbo.NomalizaCadena(ISNULL(LTRIM(RTRIM(P.APELLIDOS)),'')) AS ApeNorma, 
		P.EMPRESA AS Empresa, P.CORREO AS Correo, P.SEXO AS Sexo, 
		ISNULL(P.TELEFONO,'') + ISNULL(', '+P.TELEFONO2,'') AS Telefono, ISNULL(P.MOVIL,'') AS Movil, 
		ISNULL(E.ESTADO+', ','')+ ISNULL(PAI.PAIS,'') AS Region, 
		P.ESCLIENTE AS EsCliente , LTRIM(RTRIM(U.INICIALES)) AS Iniciales,
		<#SESSION.DB/>.DBO.FormatoDireccion((P.DIRECCION1+' '+P.DIRECCION2+', '+P.CIUDAD+', '+P.IDESTADO+', '+P.CODIGOPOSTAL )) AS direccion1,
  	    <#SESSION.DB/>.DBO.FormatoDireccion((C.DIRECCION1+' '+C.DIRECCION2+', '+C.CIUDAD+', '+C.IDESTADO+', '+C.CODIGOPOSTAL )) AS direccion2 
	 FROM  <#SESSION.DB/>.DBO.PROSPECTOS_ASIGNADOS PA, <#SESSION.DB/>.dbo.PROSPECTOS P 
	    LEFT JOIN <#SESSION.DB/>.dbo.COMPANIAS C ON C.IDCOMPANIA=P.IDCOMPANIA 
		LEFT JOIN <#SESSION.DB/>.dbo.PAISES PAI ON PAI.IDPAIS=P.IDPAIS 
		LEFT JOIN <#SESSION.DB/>.dbo.ESTADOS E ON PAI.IDPAIS=E.IDPAIS AND E.IDESTADO=P.IDESTADO 
		LEFT JOIN <#SESSION.DB/>.dbo.USUARIOS U ON U.IDUSUARIO = P.IDUSUARIO 
	  WHERE P.IDEMPRESA = <#SESSION.IDEMPRESA/> AND P.DESCARTADO = 0 AND P.IDPROSPECTO=PA.IDPROSPECTO AND P.IDPROSPECTO IN (SELECT IDPERSONA FROM @TABLAPERSONAS WHERE TIPOPERSONA=1) 
 
   ORDER BY LE DESC
END
ELSE
BEGIN
SELECT 
   2 AS LE,'Colaboradores' as make,U.IDUSUARIO AS Id,    
			'' AS Titulo , LTRIM(RTRIM(U.NOMBRE)) AS Nombre ,    
			dbo.NomalizaCadena(LTRIM(RTRIM(U.NOMBRE))) AS NomNorma,    
			ISNULL(LTRIM(RTRIM(U.APELLIDOS)),'') AS Apellido ,    
			dbo.NomalizaCadena(ISNULL(LTRIM(RTRIM(U.APELLIDOS)),'''')) AS ApeNorma,    
			'' AS Empresa, U.EMAIL AS Correo, '''' AS Sexo,    
			'' + '' AS Telefono, '' AS Movil,    
			'' AS Region,    
			0 EsCliente , LTRIM(RTRIM(U.INICIALES)) AS Iniciales,'' AS direccion1,'' AS direccion2  

from <#SESSION.DB/>.dbo.USUARIOS U where U.IDEMPRESA=<#SESSION.IDEMPRESA/> 
/*AND U.IDUSUARIO IN (SELECT ID from <#SESSION.DB/>.dbo.ObtieneUsuariosAutorizadosModulos(<#SESSION.IDUSUARIO/>,5,0)) */
ORDER BY U.NOMBRE, U.APELLIDOS ASC
END