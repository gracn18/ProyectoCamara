create or replace FUNCTION F_ULTIMA_INSCRIPCION 
(
  vregistro IN number
) RETURN number AS 


cursor cuins is select Max(inscripcion) inscripcion from rp_inscripcion where registro = vregistro and tipo_inscripcion in(1,2,4,19);

 
 resregistro number;
 
BEGIN
	open cuins;
	fetch cuins into resregistro;
	close cuins;
	
	return resregistro;
	
END F_ULTIMA_INSCRIPCION;