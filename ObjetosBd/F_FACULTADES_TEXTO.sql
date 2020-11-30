create or replace FUNCTION F_FACULTADES_TEXTO 
(
  VREGISTRO  IN VARCHAR2
  ,VMATRICULA IN VARCHAR2 
, VCAMARA IN VARCHAR2 
, VCERTIFICA IN VARCHAR2 
) RETURN CLOB AS 


cursor cuDatos is select texto from Textos_Para_Certificar where matricula = vmatricula and camara = vcamara and certifica = vcertifica  order by secuencia;


cursor cuDatos2 is select DESCRIPCION from rp_facultad where registro = VREGISTRO and inscripcion  =F_ULTIMA_INSCRIPCION(VREGISTRO)      order by secuencia;


resTexto clob;
 

BEGIN
  DBMS_LOB.CREATETEMPORARY(resTexto,true);
  
  if(VREGISTRO is not null and VMATRICULA is not null  ) then
  
	  for rgDatos in cuDatos loop
	  
			dbms_lob.append(resTexto, regexp_replace(rgDatos.texto,'[[:space:]]',' '));
	  end loop;  
	  
  end if;
  
  if(VREGISTRO is not null and VMATRICULA is null ) then
		for rgDatos in cuDatos2 loop
	  
			
			dbms_lob.append(resTexto, regexp_replace(rgDatos.DESCRIPCION,'[[:space:]]',' '));
	    end loop;  
	  
  end if;
    
  RETURN resTexto;
END F_FACULTADES_TEXTO;