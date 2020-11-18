create or replace FUNCTION F_FACULTADES_TEXTO 
(
  VMATRICULA IN VARCHAR2 
, VCAMARA IN VARCHAR2 
, VCERTIFICA IN VARCHAR2 
) RETURN CLOB AS 


cursor cuDatos is select texto from Textos_Para_Certificar where matricula = vmatricula and camara = vcamara and certifica = vcertifica  order by secuencia;

 resTexto clob;
 

BEGIN
	DBMS_LOB.CREATETEMPORARY(resTexto,true);
  for rgDatos in cuDatos loop
        dbms_lob.append(resTexto, rgDatos.texto);
  end loop;
    
  RETURN resTexto;
END F_FACULTADES_TEXTO;