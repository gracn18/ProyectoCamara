SELECT
     a.camara,
     a.registro proponente,
     c.nombre nombre_o_razon_social,
     c.primer_apellido ape1,
     c.segundo_apellido ape2,
     c.primer_nombre  nom1,
     c.segundo_nombre nom2,
     d.sigla,
     PKG_CD_JSON.fnHomologaDato('TIPO_IDENTIFICACION',d.tipo_identificacion)  tipoidentificacion,
     d.nro_identificacion identificacion,
     a.nit,
     (select nacionalidad from TB_PAIS where pais = a.pais_origen) nacionalidad,
     a.numero_id_tributaria_pais numidetripaisorigenep,
     PKG_CD_JSON.fnHomologaDato('ORGANIZACION_JURIDICA',a.tipo_juridico) organizacion,
     decode(a.codigo_empresa_tamano,'01','1','02','2','03','3','04','4') tamanoempresa,
     a.fecha_inscripcion fechaultimainscripcion,
     a.fecha_renovacion fechaultimarenovacion,
     e.tipo_documento tipodocperjur,
     e.nro_documento numdocperjur,
     e.fecha_documento fecdocperjur,
     e.expedida origendocperjur,
     e.fecha_personeria fechaconstitucion,
     e.duracion fechavencimiento,
     F_CONSULTADIRECCION(a.registro,1).DIRECCION dircom,
	 F_CONSULTADIRECCION(a.registro,1).ubicacion_empresa ubicom,
	 F_CONSULTADIRECCION(a.registro,1).barrio barriocom,
	 F_CONSULTADIRECCION(a.registro,1).municipio muncom,
	 F_CONSULTADIRECCION(a.registro,1).telefono telcom1,
	 F_CONSULTADIRECCION(a.registro,1).telefono_celular telcom2,
	 F_CONSULTADIRECCION(a.registro,1).telefono3 telcom3,
	 F_CONSULTADIRECCION(a.registro,1).correo_electronico emailcom,
	 F_CONSULTADIRECCION(a.registro,1).id_zona zonacom,
	 F_CONSULTADIRECCION(a.registro,1).ZONA_POSTAL codposcom,

	 F_CONSULTADIRECCION(a.registro,2).DIRECCION dirnot,
	 F_CONSULTADIRECCION(a.registro,2).ubicacion_empresa ubinot,
	 F_CONSULTADIRECCION(a.registro,2).barrio barrionot,
	 F_CONSULTADIRECCION(a.registro,2).municipio munnot,
	 F_CONSULTADIRECCION(a.registro,2).telefono telnot1,
	 F_CONSULTADIRECCION(a.registro,2).telefono_celular telnot2,
	 F_CONSULTADIRECCION(a.registro,2).telefono3 telnot3,
	 F_CONSULTADIRECCION(a.registro,2).correo_electronico emailnot,
	 F_CONSULTADIRECCION(a.registro,2).id_zona zonanot,
	 F_CONSULTADIRECCION(a.registro,2).ZONA_POSTAL codposnot,
	 F_CONSULTADIRECCION(a.registro,2).ID_SEDE_ADMINISTRATIVA tiposede,
	 F_FACULTADES_TEXTO(a.matricula,a.camara,73) facultades


FROM
    rp_proponente A ,  RP_NOMBRE_SM b, nombres_inscritos c , inscritos d, rp_proponente_pj e
    --, rp_direccion f
    WHERE 
      a.registro = b.registro(+)
      and a.estado = 0 -- condicion 1
      and a.matricula is not null --condicion 2
      and c.camara = a.camara
      and c.matricula = a.matricula
      and d.camara = a.camara (+)
      and d.matricula = a.matricula(+)
      and a.registro  = e.registro(+) ;
     