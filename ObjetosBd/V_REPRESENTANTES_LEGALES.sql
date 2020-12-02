create or replace view V_REPRESENTANTES_LEGALES as
SELECT 
tipo_identificacion tipoidentificacion, --se debe homologar 
nro_identificacion identificacion,
nombre_representante,
F_PARTIR_NOMBRES2(nombre_representante,3) ape1,
F_PARTIR_NOMBRES2(nombre_representante,4) ape2,
F_PARTIR_NOMBRES2(nombre_representante,1) nom1,
F_PARTIR_NOMBRES2(nombre_representante,2) nom2,
tr.NOMBRE_TIPO_REPRES cargo,
r.matricula,
r.camara,
null registro
FROM REPRESENTANTES_LEGALES r, TIPOS_REPRESENTANTES tr
WHERE 
 tr.TIPO_REPRESENTANTE=r.TIPO_REPRESENTANTE
 and r.estado = 0
-- AND r.MATRICULA=:p_matricula
--AND r.camara=:p_camara;
union 
SELECT 
tipo_identificacion tipoidentificacion, --se debe homologar 
nro_identificacion identificacion,
nombre_representante,
F_PARTIR_NOMBRES2(nombre_representante,3) ape1,
F_PARTIR_NOMBRES2(nombre_representante,4) ape2,
F_PARTIR_NOMBRES2(nombre_representante,1) nom1,
F_PARTIR_NOMBRES2(nombre_representante,2) nom2,
'REPRESENANTE LEGAL' cargo,
null matricula,
null camara,
registro
FROM RP_REPRESENTANTE b
where  b.inscripcion =F_ULTIMA_INSCRIPCION(b.registro);