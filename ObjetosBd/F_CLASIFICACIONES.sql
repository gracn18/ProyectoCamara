create or replace FUNCTION F_CLASIFICACIONES 
(
  vsecuencia IN number,
  vregistro  IN NUMBER
) RETURN CLOB AS 


cursor cuclasif is 
	SELECT wmsys.wm_concat(clasificacion) 
	FROM   ( 

			 SELECT segmento || familia ||clase clasificacion
			 
				  FROM   rp_clasificacion_exp c 
				  WHERE  c.id_experiencia	=vsecuencia 
				  AND    c.registro			= vregistro 
				  AND    c.inscripcion		=f_ultima_inscripcion(vregistro)
			);
										  
 
 resTexto clob;
 restring varchar2(32767);
 
 
BEGIN

	DBMS_LOB.CREATETEMPORARY(resTexto,true);
		
	open  cuclasif;
	fetch cuclasif into restring;
	close cuclasif;
	
	
	 dbms_lob.append(resTexto, regexp_replace(restring,'[[:space:]]',' '));

	
	return resTexto;
	
END F_CLASIFICACIONES;
  
