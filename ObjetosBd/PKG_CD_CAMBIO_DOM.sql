CREATE OR REPLACE PACKAGE PKG_CD_CAMBIO_DOM AS 
/* ******************************************************************************************************************
    Definicion : paquete logica de cambio de domicilio a partir de datos cargados en la tabla cd_tabla_datos_json
    Autor : Manuel Palomares Vision Ingenieria
	Fecha : 15/11/2020
*********************************************************************************************************************/

	
 procedure cargaTabla(vproceso number);
 function  fnGetValorCampoTabla(proceso number,idTabla number,campoTabla varchar2,numReg number) return varchar2;
 function  fnGetValorCampoTablaClob(proceso number,idTabla number,campoTabla varchar2,numReg number) return clob;
 procedure llenarDatosProcedimiento(vproceso number,vnombreproceso varchar2,idtabla number,registrostabla number); 
 
 
 procedure prc_crearProponente(vproceso number, P_NIT varchar2,P_NACIONALIDAD varchar2,P_NUMERO_ID_TRIBUTARIA_PAIS varchar2,P_ORGANIZACION varchar2,P_TAM_EMPRESA varchar2,P_FECHA_INSCRIPCION varchar2,P_FECHA_RENOVACION varchar2);
 procedure crearDirecciones(vproceso number,P_TIPO_DIRECCION number,P_MUN number,P_DIRECCION varchar2,P_TELEFONO1 varchar2,P_CORREO varchar2,P_TELEFONO2 number,P_TELEFONO3 number,P_ZONA varchar2,P_ZONA_POSTAL number,P_UBICACION number,P_BARRIO VARCHAR2);
 procedure crearNombreProponente(vproceso number, P_NOMBRE varchar2,P_SEGUNDO_NOMBE varchar2,P_PRIMER_NOMBRE varchar2,P_SEGUNDO_APELLIDO varchar2, P_PRIMER_APELLIDO varchar2);
 procedure crearRptProponentePn(vproceso number,P_NRO_IDENTIFICACION varchar2,P_TIPO_IDENTIFICACION varchar2,P_PAIS varchar2);
 procedure crearRptProponentePj(vproceso number,P_FECHA_VENCIMIENTO varchar2,P_FECHA_DOCUMENTO varchar2,P_TIPO_DOCUMENTO varchar2,P_NRO_DOCUMENTO varchar2);
 procedure guardarFacultades(vproceso number,textoClob clob);
 procedure guardarRptExperiencia(vproceso number,P_NRO_CONTRATO varchar2,P_NOMBRE_CONTRATANTE varchar2, P_VALOR_CONTRATO varchar2,P_PORCENTAJE varchar2,P_ID_TIPO_ENTIDAD varchar2,P_NOMBRE_CONTRATISTA varchar2,P_CLASIFICACION clob); 
 procedure guardarClasExp(vproceso number,P_ID_EXPERIENCIA varchar2,P_CLASIFICACION clob);
 
 procedure guardarContratos(vproceso number,
  P_INSCRIPCION VARCHAR2, --numeroinscripcionlibro
  P_NRO_CONTRATO VARCHAR2, --numerocontrato
  P_FECHA_ADJUDICACION VARCHAR2, --fechaadjudicacion
  P_FECHA_INICIO VARCHAR2, --fechainicio
  P_FECHA_TERMINACION VARCHAR2, --fechaterminacion
  P_CLASIFICACION VARCHAR2, --codigosunspsc
  P_TIPO_CONTRATISTA VARCHAR2,--tipocontratista
  P_VALOR VARCHAR2, --valorcontrato
  P_VALOR_PAGADO VARCHAR2, --valorpagado
  P_ESTADO VARCHAR2, --estadocontrato
  P_FECHA_PERFECCIONAMIENTO VARCHAR2, --fechaperfeccionamiento
  P_FECHA_LIQUIDACION VARCHAR2, --fechaliquidacion
  P_MOT_TERM_ACT VARCHAR2, --motivoterminacionanticipada
  P_FECHA_ACTO_TERMINACION_ANT VARCHAR2,--fechaterminacionanticipada
  P_CODIGO_CAMARA VARCHAR2,--codigocamara
  P_FECHA_INSCRIPCION VARCHAR2, --fechainscripcionlibro
  P_FECHA_RADICACION_RUE VARCHAR2, --fecharadicacion
  P_NIT_ENTIDAD VARCHAR2, --nitentidad
  P_NRO_CONTRATO_SECOP VARCHAR2,--numerocontratosecop
  P_OBJETO_CONTRATO VARCHAR2, --objeto
  P_MOTIVO_CESION_CONTRATO  VARCHAR2,  --motivocesion
  P_FECHA_CESION_CONTRATO VARCHAR2, --fechacesion
  P_NOMBRE_ENTIDAD VARCHAR2, --nombreentidad
  P_MUNICIPIO VARCHAR2,  --munientidad
  P_AREA VARCHAR2        --divarea
 );


 procedure guardarRtpInfFinanciera(vproceso number,P_TIPO_INF_FINANCIERA varchar2, P_FECHA varchar2,P_VALOR varchar2);
 
 
 procedure guardarMultas(vproceso number,
  P_INSCRIPCION VARCHAR2, --numeroinscripcionlibro
  P_NRO_CONTRATO VARCHAR2, --numerocontrato
  P_ACTO_ADMINISTRATIVO VARCHAR2, --numeroactoadministrativo
  P_FECHA_ACTO_ADMINISTRATIVO VARCHAR2, --fechaactoadministrativo
  P_VALOR VARCHAR2,  --valormulta
  P_VALOR_PAGADO VARCHAR2, --valorpagado
  P_ESTADO VARCHAR2, --estadomulta
  P_ACTO_REVOCACION VARCHAR2,--numeroactorevocacion
  P_FECHA_ACTO_REVOCACION VARCHAR2, --fechaactorevocacion
  P_FECHA_EJECUTORIA_ACTO_ADMIN VARCHAR2,  --fechaejecutoriaactoadministrativo
  P_NRO_ACTO_SUSPENSION_TEMP VARCHAR2, --numeroactosuspension
  P_FECHA_ACTO_SUSPENSION VARCHAR2,  --fechaactosuspension
  P_NRO_ACTO_CONFIRMA_MULTA VARCHAR2, --numeroactoconfirmacion
  P_FECHA_ACTO_CONFIRMA_MULTA VARCHAR2, --fechaactoconfirmacion
  P_CODIGO_CAMARA VARCHAR2, --codigocamara
  P_FECHA_INSCRIPCION VARCHAR2, --fechainscripcionlibro
  P_FECHA_RADICACION_RUE VARCHAR2, --fecharadicacion
  P_NIT_ENTIDAD VARCHAR2, --nitentidad
  P_NRO_CONTRATO_SECOP VARCHAR2,  --numerocontratosecop
  P_NOMBRE_ENTIDAD VARCHAR2, --nombreentidad
  P_MUNICIPIO VARCHAR2,  --munientidad
  P_AREA VARCHAR2       --divarea
);



 procedure guardarSanciones(
  vproceso number,
  P_INSCRIPCION VARCHAR2, --numeroinscripcionlibro
  P_NRO_CONTRATO VARCHAR2,  --numerocontrato
  P_ACTO_ADMINISTRATIVO VARCHAR2,  --numeroactoadministrativo
  P_FECHA_ACTO_ADMINISTRATIVO VARCHAR2,  --fechaactoadministrativo
  P_DESCRIPCION VARCHAR2,  --descripcion
  P_ESTADO VARCHAR2,  --estadosancion
  P_CUMPLIMIENTO VARCHAR2,  --condicionincumplimiento
  P_ACTO_REVOCACION VARCHAR2,   --numeroactorevocacion
  P_FECHA_ACTO_REVOCACION VARCHAR2,  --fechaactorevocacion
  P_FECHA_EJECUTORIA_ACTO_ADMIN VARCHAR2,  --fechaejecutoriaactoadministrativo
  P_NRO_ACTO_SUSPENSION_TEMP VARCHAR2,  --numeroactosuspension
  P_FECHA_ACTO_SUSPENSION VARCHAR2,   --fechaactosuspension
  P_NRO_ACTO_CONFIRMA_SANCION VARCHAR2,  --numeroactoconfirmacion
  P_FECHA_ACTO_CONFIRMA_SANCION VARCHAR2,  --fechaactoconfirmacion
  P_CODIGO_CAMARA VARCHAR2,  --codigocamara
  P_FECHA_INSCRIPCION VARCHAR2,   --fechainscripcionlibro
  P_FECHA_RADICACION_RUE VARCHAR2, --fecharadicacion
  P_NIT_ENTIDAD VARCHAR2,  --nitentidad
  P_NRO_CONTRATO_SECOP VARCHAR2,  --numerocontratosecop
  P_VIGENCIA_SANCION VARCHAR2,  --vigencia
  P_FUNDAMENTO_LEGAL VARCHAR2,  --fundamentolegal
  P_INCUMPLIMIENTO_VIVIENDA VARCHAR2,  --relacionadoconstruccion
  P_NOMBRE_ENTIDAD VARCHAR2,  --nombreentidad
  P_MUNICIPIO_ENTIDAD VARCHAR2,  --munientidad
  P_AREA_ENTIDAD VARCHAR2  --divarea
) ;


 procedure guardarSancionesDisciplinarias(
  vproceso number,
  P_CONSECUTIVO VARCHAR2,  --consecutivo del registro insertado
  P_NIT_ENTIDAD VARCHAR2, --nitentidad
  P_INSCRIPCION VARCHAR2,   --numeroinscripcionlibro
  P_CODIGO_CAMARA VARCHAR2,   --codigocamara
  P_FECHA_INSCRIPCION VARCHAR2,   --fechainscripcionlibro
  P_ACTO_ADMINISTRATIVO VARCHAR2, --numeroactoadministrativo
  P_FECHA_ACTO_ADMINISTRATIVO VARCHAR2,  --fechaactoadministrativo
  P_FECHA_ACTO_EJECUTORIA VARCHAR2, --fechaejecutoriaactoadministrativo
  P_DESCRIPCION VARCHAR2,  --descripcion
  P_VIGENCIA VARCHAR2,  --vigencia
  P_FUNDAMENTO_LEGAL VARCHAR2,  --fundamentolegal
  P_ESTADO VARCHAR2, --estadosancion
  P_ACTO_SUSPENSION_TEMP VARCHAR2, --numeroactosuspension
  P_FECHA_ACTO_SUSPENSION VARCHAR2,  --fechaactosuspension
  P_ACTO_CONFIRMACION VARCHAR2,  --numeroactoconfirmacion
  P_FECHA_ACTO_CONFIRMACION VARCHAR2,  --fechaactoconfirmacion
  P_ACTO_REVOCACION VARCHAR2,  --numeroactorevocacion
  P_FECHA_ACTO_REVOCACION VARCHAR2,  --fechaactorevocacion
  P_NOMBRE_ENTIDAD VARCHAR2, --nombreentidad
  P_MUNICIPIO_ENTIDAD VARCHAR2,  --munientidad
  P_AREA_ENTIDAD  VARCHAR2         --divarea
);


procedure guardarRepreentantes
(
 vproceso number,
 P_SECUENCIA VARCHAR2,
 P_TIPO_IDENTIFICACION VARCHAR2, --tipoidentificacion
 P_NRO_IDENTIFICACION VARCHAR2,--identificacion
 P_PRIMER_NOMBRE  VARCHAR2,--nom1
 P_SEGUNDO_NOMBRE VARCHAR2, --nom2
 P_PRIMER_APELLIDO  VARCHAR2,--ape1
 P_SEGUNDO_APELLIDO  VARCHAR2-- ape2

);
 
 
 
 procedure guardarSituacionesControl
(
  vproceso number,
  P_SECUENCIA VARCHAR2,
  P_NOMBRE VARCHAR2,  --nombre
  P_IDENTIFICACION VARCHAR2, --identificación
  P_TIPO VARCHAR2, --TIPO
  ID_DOMICILIO VARCHAR2--domicilio 
);

END PKG_CD_CAMBIO_DOM;
/


CREATE OR REPLACE PACKAGE BODY PKG_CD_CAMBIO_DOM AS


function fnGetValorCampoTabla(proceso number,idTabla number,campoTabla varchar2,numReg number) return varchar2 as   
 sbres varchar2(1000) :='';
 
 cursor cuDatoJson is 
 select a.nro_registro,b.nombre_campo_json,d.tag_tabla_plural, b.id_tabla,valor,valorclob from cd_tabla_datos_json a , cd_detalle_tabla_json b, cd_tablas_estructura_json d
 where a.id_detalle_json = b.id
 and b.id_tabla = d.id
 --and d.tipo_tabla  = tipoTabla 
 and b.id_tabla = idTabla
 and b.nombre_campo_json = campoTabla
 and a.nro_registro = numReg;
 
	sbValor  varchar2(32000);
 begin
	
	for  rgdato in cuDatoJson  loop
		 sbValor := rgdato.valor;		
	end loop;
	
	return sbValor;
	
	exception 
	when others then 
		return '';
		
 end fnGetValorCampoTabla;
 
 
 function fnGetValorCampoTablaClob(proceso number,idTabla number,campoTabla varchar2,numReg number) return clob as   
 sbres varchar2(1000) :='';
 
 cursor cuDatoJson is 
 select a.nro_registro,b.nombre_campo_json,d.tag_tabla_plural, b.id_tabla,valor,valorclob from cd_tabla_datos_json a , cd_detalle_tabla_json b, cd_tablas_estructura_json d
 where a.id_detalle_json = b.id
 and b.id_tabla = d.id
 --and d.tipo_tabla  = tipoTabla 
 and b.id_tabla = idTabla
 and b.nombre_campo_json = campoTabla
 and a.nro_registro = numReg;
 
	sbValor  clob;
 begin
	
	for  rgdato in cuDatoJson  loop
		 sbValor := rgdato.valorclob;		
	end loop;
	
	return sbValor;
	
	exception 
	when others then 
		return '';
		
 end fnGetValorCampoTablaClob;
 
 
 
 procedure cargaTabla(vproceso number) as 
 
  cursor cutablas is 
  select d.id id_tabla,d.tag_tabla_plural,d.tag_tabla_singular,d.tipo_tabla,nombre_proceso,max(a.nro_registro) registros  
	from cd_tabla_datos_json a , cd_detalle_tabla_json b, cd_tablas_estructura_json d
	where a.id_detalle_json = b.id
	and b.id_tabla = d.id
	and a.cd_json_cargue_id = vproceso
 group by d.id,d.tag_tabla_plural,d.tag_tabla_singular,d.tipo_tabla,nombre_proceso 
  order by tipo_tabla asc;
  

  sbValor varchar2(32000) := '';
 begin
   for rgTablas in cutablas loop
	
		-- se encarga de validar que proceso para insertar los registros mapeados del JSON .
		llenarDatosProcedimiento(vproceso ,rgTablas.NOMBRE_PROCESO, rgTablas.id_tabla ,rgTablas.registros );
		
	
   end loop;
 end cargaTabla;
 

procedure llenarDatosProcedimiento(vproceso number,vnombreproceso varchar2,idtabla number,registrostabla number) as 

	nuReg NUMBER(15);
	sbFEcha varchar2(20) := '';
	
	
	
	cursor curNroProponente is 
	SELECT a.nro_proponente,b.matricula,b.tipo_juridico FROM CD_JSON_CARGUE a, RPT_PROPONENTE  b
	WHERE a.id = vproceso and   b.registro = a.nro_proponente;
	
    
	rgDatosMatricula curNroProponente%rowtype;
	
	sbGrabar boolean := true;
	

begin

	if(vnombreproceso = 'PRCPROPONENTE') Then
		 
			open curNroProponente;
			fetch curNroProponente into rgDatosMatricula;
			close curNroProponente;
			
			if rgDatosMatricula.matricula > 0 then
				sbGrabar := false;
			end if;
			
			--procedmiento llena la tabla de proponente.
			nuReg := 1;
			
			
			
			--recorro la itreacion de los registros de una tabla 1 a n registros. 
			for rgdatos1 in 1 .. registrostabla loop
			
				--forma de traer  el dato de campo valor y numero de registrio de una tabla json mapeada 
				dbms_output.put_line(fnGetValorCampoTabla(vproceso,idtabla,'identificacion',nuReg));
		
				prc_crearProponente(
						vproceso,
						fnGetValorCampoTabla(vproceso,idtabla,'nit',nuReg),
						fnGetValorCampoTabla(vproceso,idtabla,'nacionalidad',nuReg),
						fnGetValorCampoTabla(vproceso,idtabla,'numidetripaisorigenep',nuReg),
						fnGetValorCampoTabla(vproceso,idtabla,'organizacion',nuReg),
						fnGetValorCampoTabla(vproceso,idtabla,'tamanoempresa',nuReg),
						fnGetValorCampoTabla(vproceso,idtabla,'fechaultimainscripcion',nuReg),
						fnGetValorCampoTabla(vproceso,idtabla,'fechaultimarenovacion',nuReg)
				);
			
				
				if(sbGrabar) then --se graba cuando el proponente no esta asociado a un inscrito
						crearDirecciones(vproceso,
										 2,
										 fnGetValorCampoTabla(vproceso,idtabla,'muncom',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'dircom',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'telcom1',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'emailcom',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'telcom2',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'telcom3',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'zonacom',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'codposcom',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'ubicom',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'barriocom',nuReg)
										 );
			
						crearDirecciones(vproceso,
										 1,
										 fnGetValorCampoTabla(vproceso,idtabla,'munnot',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'dirnot',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'telnot1',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'emailnot',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'telnot2',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'telnot3',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'zonanot',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'codposnot',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'ubinot',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'barrionot',nuReg)
										 );
				end if;
				
				
				---todo otra condicion.
				crearNombreProponente(vproceso,
									 fnGetValorCampoTabla(vproceso,idtabla,'nombre_o_razon_social',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'nom2',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'nom1',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'ape2',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'ape1',nuReg)
									);
								
				if rgDatosMatricula.tipo_juridico = 1 then
					crearRptProponentePn(vproceso,
										 fnGetValorCampoTabla(vproceso,idtabla,'identificacion',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'tipoidentificacion',nuReg),
										 fnGetValorCampoTabla(vproceso,idtabla,'idpaisidentificacion',nuReg)
										 );
										 
				else

					crearRptProponentePj(vproceso,
										fnGetValorCampoTabla(vproceso,idtabla,'fechavencimiento',nuReg),
										fnGetValorCampoTabla(vproceso,idtabla,'fecdocperjur',nuReg),
										fnGetValorCampoTabla(vproceso,idtabla,'tipodocperjur',nuReg),
										fnGetValorCampoTabla(vproceso,idtabla,'numdocperjur',nuReg)
										);
									
				end if;

				if(sbGrabar) then --se graba cuando el proponente no esta asociado a un inscrito
					guardarFacultades(vproceso,fnGetValorCampoTablaClob(vproceso,idtabla,'facultades',nuReg));
				end if;
				
				nuReg := nuReg +1 ;
			end loop;
	end if;
	 
	if(vnombreproceso  = 'PREXPERIENCIA') Then
			
			--procedmiento llena la tablas RPT_EXPERIENCIA
			nuReg := 1;
			
			
			
			--recorro la itreacion de los registros de una tabla 1 a n registros. 
			for rgdatos1 in 1 .. registrostabla loop
				
				guardarRptExperiencia(vproceso,
									  fnGetValorCampoTabla(vproceso,idtabla,'secuencia',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'nombrecontratante',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'valor',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'porcentaje',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'celebradopor',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'nombrecontratista',nuReg),
									  fnGetValorCampoTablaClob(vproceso,idtabla,'clasificaciones',nuReg)
									  );
				
								
				nuReg := nuReg +1 ;
			end loop;
		
	end if;
	
	
	if(vnombreproceso  = 'PRCONTRATOSEE') Then
			
			--procedmiento llena la tablas PRCONTRATOSEE
			nuReg := 1;
			
			
			
			--recorro la itreacion de los registros de una tabla 1 a n registros. 
			for rgdatos1 in 1 .. registrostabla loop
				
				
  
				guardarContratos(	  vproceso,
									  fnGetValorCampoTabla(vproceso,idtabla,'numeroinscripcionlibro',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'numerocontrato',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fechaadjudicacion',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fechainicio',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fechaterminacion',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'codigosunspsc',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'tipocontratista',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'valorcontrato',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'valorpagado',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'estadocontrato',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fechaperfeccionamiento',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fechaliquidacion',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'motivoterminacionanticipada',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fechaterminacionanticipada',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'codigocamara',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fechainscripcionlibro',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fecharadicacion',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'nitentidad',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'numerocontratosecop',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'objeto',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'motivocesion',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'fechacesion',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'nombreentidad',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'munientidad',nuReg),
									  fnGetValorCampoTabla(vproceso,idtabla,'divarea',nuReg)
									  );
				
								
				nuReg := nuReg +1 ;
			end loop;
		
	end if;


	if(vnombreproceso  = 'PRINFOFINANCIERA') Then
			
			--procedmiento llena la tablas RPT_EXPERIENCIA
			nuReg := 1;
			
			
					 
			open curNroProponente;
			fetch curNroProponente into rgDatosMatricula;
			close curNroProponente;
			
			if rgDatosMatricula.matricula > 0 then
				sbGrabar := false;
			end if;
			
			if(sbGrabar) then --se graba cuando el proponente no esta asociado a un inscrito
				--recorro la itreacion de los registros de una tabla 1 a n registros. 
				for rgdatos1 in 1 .. registrostabla loop
					
					sbFEcha := fnGetValorCampoTabla(vproceso,idtabla,'inffin_fechacorte',nuReg) ;
					
					guardarRtpInfFinanciera(vproceso,0,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_actcte',nuReg));

					guardarRtpInfFinanciera(vproceso,55,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_actnocte',nuReg));
					
					guardarRtpInfFinanciera(vproceso,4,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_acttot',nuReg));
											
					guardarRtpInfFinanciera(vproceso,56,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_balsoc',nuReg));	
					
					guardarRtpInfFinanciera(vproceso,9,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_paspat',nuReg));	
					
					guardarRtpInfFinanciera(vproceso,5,sbFEcha, fnGetValorCampoTabla(vproceso,idtabla,'inffin_pascte',nuReg));
											
					guardarRtpInfFinanciera(vproceso,7,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_pastot',nuReg));

					guardarRtpInfFinanciera(vproceso,8,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_patnet',nuReg));

					guardarRtpInfFinanciera(vproceso,54,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_renact',nuReg));

					guardarRtpInfFinanciera(vproceso,53,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_renpat',nuReg));
											
					guardarRtpInfFinanciera(vproceso,20,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_utiope',nuReg));
					
					guardarRtpInfFinanciera(vproceso,28,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_utinet',nuReg));
					
					guardarRtpInfFinanciera(vproceso,24,sbFEcha,fnGetValorCampoTabla(vproceso,idtabla,'inffin_indliq',nuReg));
					
					

					
												
					nuReg := nuReg +1 ;
				end loop;
			end if;
	end if;
	
	
	if(vnombreproceso  = 'PRMULTAS') Then
			
			--procedmiento llena la tablas PRMULTAS
			nuReg := 1;
			
			
			
			--recorro la itreacion de los registros de una tabla 1 a n registros. 
			for rgdatos1 in 1 .. registrostabla loop
				

										
										
				guardarMultas(
								vproceso ,
								fnGetValorCampoTabla(vproceso,idtabla,'numeroinscripcionlibro',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numerocontrato',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'valormulta',nuReg),		  
								fnGetValorCampoTabla(vproceso,idtabla,'valorpagado',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'estadomulta',nuReg),  		  
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactorevocacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactorevocacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaejecutoriaactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactosuspension',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactosuspension',nuReg),		  
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactoconfirmacion',nuReg), 		  
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactoconfirmacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'codigocamara',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechainscripcionlibro',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fecharadicacion',nuReg),		  
								fnGetValorCampoTabla(vproceso,idtabla,'nitentidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numerocontratosecop',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'nombreentidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'munientidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'divarea',nuReg)
							
						);
  
				nuReg := nuReg +1 ;
			end loop;
		
	end if;
	
	
	if(vnombreproceso  = 'PRSANCIONES') Then
			
			--procedmiento llena la tablas PRSANCIONES
			nuReg := 1;
			
			
			
			--recorro la itreacion de los registros de una tabla 1 a n registros. 
			for rgdatos1 in 1 .. registrostabla loop
				

										
										
				guardarSanciones(
								vproceso ,
								fnGetValorCampoTabla(vproceso,idtabla,'numeroinscripcionlibro',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numerocontrato',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'descripcion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'estadosancion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'condicionincumplimiento',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactorevocacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactorevocacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaejecutoriaactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactosuspension',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactosuspension',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactoconfirmacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactoconfirmacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'codigocamara',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechainscripcionlibro',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fecharadicacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'nitentidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numerocontratosecop',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'vigencia',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fundamentolegal',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'relacionadoconstruccion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'nombreentidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'munientidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'divarea',nuReg)
								);
								



  
				nuReg := nuReg +1 ;
			end loop;
		
	end if;
	
	
	
	if(vnombreproceso  = 'PRSANCIONDISCIPLINARIA') Then
			
			--procedmiento llena la tablas PRSANCIONDISCIPLINARIA
			nuReg := 1;
			
			
			
			--recorro la itreacion de los registros de una tabla 1 a n registros. 
			for rgdatos1 in 1 .. registrostabla loop
				

										
										
				guardarSancionesDisciplinarias(
								vproceso ,
								nuReg,
								fnGetValorCampoTabla(vproceso,idtabla,'nitentidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroinscripcionlibro',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'codigocamara',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechainscripcionlibro',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaejecutoriaactoadministrativo',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'descripcion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'vigencia',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fundamentolegal',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'estadosancion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactosuspension',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactosuspension',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactoconfirmacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactoconfirmacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'numeroactorevocacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'fechaactorevocacion',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'nombreentidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'munientidad',nuReg),
								fnGetValorCampoTabla(vproceso,idtabla,'divarea',nuReg)
								
						);
								



  
				nuReg := nuReg +1 ;
			end loop;
		
	end if;
	
	
	
	if(vnombreproceso  = 'PRREPRESENNTANTES') Then
			
			--procedmiento llena la tablas PRREPRESENNTANTES
			nuReg := 1;
			
			
			open curNroProponente;
			fetch curNroProponente into rgDatosMatricula;
			close curNroProponente;
			
			if rgDatosMatricula.matricula > 0 then
				sbGrabar := false;
			end if;
			
			
			if(sbGrabar) then --se graba cuando el proponente no esta asociado a un inscrito
				--recorro la itreacion de los registros de una tabla 1 a n registros. 
				for rgdatos1 in 1 .. registrostabla loop
					

	 
					guardarRepreentantes(
									vproceso ,
									nuReg,
									fnGetValorCampoTabla(vproceso,idtabla,'tipoidentificacion',nuReg),
									fnGetValorCampoTabla(vproceso,idtabla,'identificacion',nuReg),
									fnGetValorCampoTabla(vproceso,idtabla,'nom1',nuReg),
									fnGetValorCampoTabla(vproceso,idtabla,'nom2',nuReg),
									fnGetValorCampoTabla(vproceso,idtabla,'ape1',nuReg),
									fnGetValorCampoTabla(vproceso,idtabla,'ape2',nuReg)
							);
									



	  
					nuReg := nuReg +1 ;
				end loop;
			end if;
		
	end if;
	
	
	if(vnombreproceso  = 'PRSITUACIONESCONTROL') Then
			
			--procedmiento llena la tablas PRSITUACIONESCONTROL
			nuReg := 1;
			
			
			
			--recorro la itreacion de los registros de una tabla 1 a n registros. 
			for rgdatos1 in 1 .. registrostabla loop
				

						guardarSituacionesControl(
								  vproceso,
								  nuReg,
								  fnGetValorCampoTabla(vproceso,idtabla,'nombre',nuReg),
								  fnGetValorCampoTabla(vproceso,idtabla,'identificacion',nuReg),
								  fnGetValorCampoTabla(vproceso,idtabla,'tipo',nuReg),
								  fnGetValorCampoTabla(vproceso,idtabla,'domicilio',nuReg)
								  );
				nuReg := nuReg +1 ;
			end loop;
		
	end if;
	
	

end llenarDatosProcedimiento;


 /* *********************************************************
  Descripcion : Procedimiento actualiza datos proponente. 
 * *********************************************************/
procedure prc_crearProponente(vproceso number, P_NIT varchar2,P_NACIONALIDAD varchar2,P_NUMERO_ID_TRIBUTARIA_PAIS varchar2,P_ORGANIZACION varchar2,P_TAM_EMPRESA varchar2,P_FECHA_INSCRIPCION varchar2,P_FECHA_RENOVACION varchar2) as 
		
	cursor cupais is 
	SELECT PAIS FROM TB_PAIS WHERE NACIONALIDAD=P_NACIONALIDAD AND ROWNUM=1;
	
	cursor cuCodigoLocal is 
	SELECT CODIGO_LOCAL FROM BAS_ORGANIZACIONES_JURIDICAS O WHERE O.CODIGO_RUE=P_ORGANIZACION AND ROWNUM=1;
	
	nuPais number;
	nuCodigoLocal  number;
	nunro_registro number;
	
begin 
	--se consulta la nacionalidad 
	open  cupais;
	fetch cupais into  nuPais;
	close cupais;
	
	--se consulta codigo local
	open cuCodigoLocal;
	fetch cuCodigoLocal into nuCodigoLocal;
	close cuCodigoLocal;
	
	-- consultamos dato opcional del registro que esta en la camara.
	SELECT nro_proponente into nunro_registro FROM CD_JSON_CARGUE WHERE ID = vproceso;


--	DBMS_OUTPUT.PUT_LINE('P_FECHA_INSCRIPCION '||P_FECHA_INSCRIPCION||' P_FECHA_RENOVACION '||P_FECHA_RENOVACION);
	
	UPDATE RPT_PROPONENTE
	SET 
		CAMARA=5, --P_CAMARA, --SIEMRE 5
		NIT=P_NIT,
		PAIS_ORIGEN		     		=nuPais,
		NUMERO_ID_TRIBUTARIA_PAIS	=P_NUMERO_ID_TRIBUTARIA_PAIS,
		TIPO_JURIDICO				=NVL(nuCodigoLocal,TIPO_JURIDICO),
		CODIGO_EMPRESA_TAMANO		=decode(P_TAM_EMPRESA,'1','01','2','02','3','03','4','04'),
		FECHA_INSCRIPCION			=TO_DATE(P_FECHA_INSCRIPCION,'YYYYMMDD'),
		FECHA_RENOVACION			=TO_DATE(P_FECHA_RENOVACION,'YYYYMMDD')
	WHERE REGISTRO=nunro_registro;


end prc_crearProponente;



/* *********************************************************
  Descripcion : Procedimiento crea direcciones del proponente
 * *********************************************************/
procedure crearDirecciones(vproceso number,P_TIPO_DIRECCION number,P_MUN number,P_DIRECCION varchar2,P_TELEFONO1 varchar2,P_CORREO varchar2,P_TELEFONO2 number,P_TELEFONO3 number,P_ZONA varchar2,P_ZONA_POSTAL number,P_UBICACION number,P_BARRIO VARCHAR2) as 


 nunro_registro number;

begin

	-- consultamos dato opcional del registro que esta en la camara.
	SELECT nro_proponente into nunro_registro FROM CD_JSON_CARGUE WHERE ID = vproceso;


	INSERT INTO rpt_direccion REGISTRO 
				(registro, 
				 tipo_direccion, 
				 municipio, 
				 direccion, 
				 telefono, 
				 fax, 
				 correo_electronico, 
				 telefono_celular, 
				 telefono3, 
				 apartado, 
				 barrio, 
				 sw_sms, 
				 sw_llamadas, 
				 id_zona, 
				 zona_postal, 
				 id_sede_administrativa, 
				 ubicacion_empresa) 
	VALUES     ( nunro_registro, 
				 p_tipo_direccion,--2 
				 p_mun,--muncom 
				 p_direccion,--dircom 
				 p_telefono1,--telcom1 
				 NULL, 
				 p_correo,--emailcom 
				 p_telefono2,--telcom2 
				 p_telefono3,--telcom3 
				 NULL, 
				 null,--P_BARRIO, 
				 NULL, 
				 NULL, 
				 Decode(p_zona, 'R', 2, 
								1), 
				 --Ubicación 0 No Reporto, 1 LOCAL, 2 OFICINA, 3 LOCAL Y OFICINA, 4 FÁBRICA, 5 VIVIENDA, 6 FINCA 
				 p_zona_postal, 
				 NULL, 
				 p_ubicacion); 

END crearDirecciones;



/* *********************************************************
  Descripcion : Procedimiento crear el nombre del proponente
 * *********************************************************/
procedure crearNombreProponente(vproceso number, P_NOMBRE varchar2,P_SEGUNDO_NOMBE varchar2,P_PRIMER_NOMBRE varchar2,P_SEGUNDO_APELLIDO varchar2, P_PRIMER_APELLIDO varchar2) as

nunro_registro number ;

begin

 -- consultamos dato opcional del registro que esta en la camara.
 SELECT nro_proponente into nunro_registro FROM CD_JSON_CARGUE WHERE ID = vproceso;

	INSERT INTO RPT_NOMBRE_SM
	( 
	  REGISTRO,
	  SECUENCIA,
	  NOMBRE,
	  SEGUNDO_NOMBRE,
	  PRIMER_NOMBRE,
	  SEGUNDO_APELLIDO,
	  PRIMER_APELLIDO
	)
	VALUES(
	  nunro_registro,
	  1,
	  P_NOMBRE,
	  P_SEGUNDO_NOMBE,
	  P_PRIMER_NOMBRE,
	  P_SEGUNDO_APELLIDO,
	  P_PRIMER_APELLIDO
	);


end crearNombreProponente;


/* *************************************************************
  Descripcion : Procedimiento guardar RPT_PROPONENTE_PN
 * **********************************************************/
procedure crearRptProponentePn(vproceso number,P_NRO_IDENTIFICACION varchar2,P_TIPO_IDENTIFICACION varchar2,P_PAIS varchar2)  as 

nunro_registro number ;


begin


 -- consultamos dato opcional del registro que esta en la camara.
 SELECT nro_proponente into nunro_registro FROM CD_JSON_CARGUE WHERE ID = vproceso;


INSERT INTO RPT_PROPONENTE_PN
(
  REGISTRO,
  TIPO_IDENTIFICACION,
  NRO_IDENTIFICACION,
  PAIS,
  OFICIO,
  PROFESION,
  FECHA_GRADO,
  FECHA_EXPEDICION_TARJETA,
  FECHA_EXPEDICION_DOCUMENTO,
  LUGAR_EXPEDICION_DOCUMENTO,
  FECHA_NACIMIENTO
)
VALUES(
  nunro_registro,
  (SELECT ti.CODIGO_LOCAL FROM BAS_CLASES_IDENTIFICACION ti WHERE ti.CODIGO_RUE=P_TIPO_IDENTIFICACION AND ROWNUM=1),
  P_NRO_IDENTIFICACION,
  P_PAIS,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL
);


end crearRptProponentePn;


/* *************************************************************
  Descripcion : Procedimiento guardar RPT_PROPONENTE_PJ
 * **********************************************************/
procedure crearRptProponentePj(vproceso number,P_FECHA_VENCIMIENTO varchar2,P_FECHA_DOCUMENTO varchar2,P_TIPO_DOCUMENTO varchar2,P_NRO_DOCUMENTO varchar2)  as 
nunro_registro number ;

begin 


 -- consultamos dato opcional del registro que esta en la camara.
 SELECT nro_proponente into nunro_registro FROM CD_JSON_CARGUE WHERE ID = vproceso;


INSERT INTO RPT_PROPONENTE_PJ(
  REGISTRO,
  DURACION,
  DURACION_INDEFINIDA,
  FECHA_DOCUMENTO,
  TIPO_DOCUMENTO,
  EXPEDIDA,
  NRO_DOCUMENTO,
  FECHA_PERSONERIA
)
VALUES(
  nunro_registro,
  DECODE(P_FECHA_VENCIMIENTO,99991231,NULL,TO_DATE(P_FECHA_VENCIMIENTO,'YYYYMMDD')),  --fechavencimiento
  DECODE(P_FECHA_VENCIMIENTO,99991231,1,0), --fechavencimiento
  TO_DATE(P_FECHA_DOCUMENTO,'YYYYMMDD'),--fecdocperjur
  P_TIPO_DOCUMENTO, --tipodocperjur
  NULL,
  P_NRO_DOCUMENTO,--numdocperjur
  NULL 
);


end crearRptProponentePj;




/* *************************************************************
  Descripcion : Procedimiento guardar texto clob de factultades
 * **********************************************************/
 
procedure guardarFacultades(vproceso number,textoClob clob) as 

P_Secuencia 	 number;
P_TotalProcesado number;
P_Cadenafija varchar2(500);
nunro_registro number;
n_totalcadena_aux number;

begin
	
	-- consultamos dato opcional del registro que esta en la camara.
	SELECT nro_proponente into nunro_registro FROM CD_JSON_CARGUE WHERE ID = vproceso;


	
	
	select DBMS_LOB.getlength(textoClob) into n_totalcadena_aux  from dual;

    P_Secuencia := 1;
    P_TotalProcesado :=1;

        while P_TotalProcesado  <=  n_totalcadena_aux loop
              select Dbms_Lob.Substr(textoClob , 80, P_Totalprocesado )    into P_Cadenafija        from dual;
              insert into rpt_facultad (registro,secuencia,descripcion) values (nunro_registro,P_Secuencia,UPPER(P_Cadenafija));
              P_Totalprocesado := P_Totalprocesado + 80;
              P_Secuencia := P_Secuencia  + 1;
        end loop;

end guardarFacultades;



/* *************************************************************
  Descripcion : Procedimiento guardar texto clob de rpt_experiencia
 * **********************************************************/
procedure guardarRptExperiencia(vproceso number,P_NRO_CONTRATO varchar2,P_NOMBRE_CONTRATANTE varchar2, P_VALOR_CONTRATO varchar2,P_PORCENTAJE varchar2,P_ID_TIPO_ENTIDAD varchar2,P_NOMBRE_CONTRATISTA varchar2,P_CLASIFICACION clob) as 


	nunro_registro number;
	nuSecExper number;
begin
	
	-- consultamos dato opcional del registro que esta en la camara.
	SELECT nro_proponente into nunro_registro FROM CD_JSON_CARGUE WHERE ID = vproceso;


	--dbms_output.put_line(P_NRO_CONTRATO ||' * '|| P_NOMBRE_CONTRATANTE ||' * '|| P_VALOR_CONTRATO ||' * '|| P_PORCENTAJE ||' * '|| P_ID_TIPO_ENTIDAD ||' * '|| P_NOMBRE_CONTRATISTA);
	INSERT INTO RPT_EXPERIENCIA
	(
	  REGISTRO,
	  SECUENCIA,
	  NRO_CONTRATO,
	  NOMBRE_CONTRATANTE,
	  VALOR_CONTRATO,
	  SW_UNION_TEMPORAL,
	  PORCENTAJE_UNION_TEMPORAL,
	  VALOR_UNION_TEMPORAL,
	  SW_FUSION_ESCISION,
	  PORCENTAJE_FUSION_ESCISION,
	  ID_TIPO_ENTIDAD,
	  NOMBRE_CONTRATISTA,
	  BORRADO,
	  TIPO_CERTIFICACION,
	  CERTIFICACION_CON_CLASIFICADOR,
	  ID_SUB_TIPO_ENTIDAD,
	  VALOR_CONTRATO_PESOS,
	  FECHA_TERMINACION,
	  OBJETO_CONTRATO,
	  CIUDAD_EXPIDE,
	  SW_NUEVO,
	  LINK_SECOP
	)
	VALUES
	(
	  nunro_registro,
	  SECUENCIA_RPT_EA.NEXTVAL, --secuencia
	  P_NRO_CONTRATO,
	  P_NOMBRE_CONTRATANTE, --nombrecontratante
	  to_number(P_VALOR_CONTRATO, '9999999999D9999', 'NLS_NUMERIC_CHARACTERS='',.'''),
	  DECODE(P_PORCENTAJE,'',0,1), --porcentaje
	  to_number(P_PORCENTAJE, '9999999999D9999', 'NLS_NUMERIC_CHARACTERS='',.'''),
	  NULL,
	  0,
	  NULL,
	  P_ID_TIPO_ENTIDAD,--celebradopor
	  P_NOMBRE_CONTRATISTA, --nombrecontratista
	  1,
	  NULL,
	  NULL,
	  NULL,
	  NULL,
	  NULL,
	  NULL,
	  NULL,
	  1,
	  NULL

	);
	
	
	select SECUENCIA_RPT_EA.currval into nuSecExper  from dual;
	
	--guardar la clasificaciones.
	guardarClasExp(vproceso,nuSecExper,P_CLASIFICACION);
	



end guardarRptExperiencia;



/* *************************************************************
  Descripcion : Procedimiento guardar la información de las clasificaciones asociadas a una experiencia
* **********************************************************/
procedure guardarClasExp(vproceso number,P_ID_EXPERIENCIA varchar2,P_CLASIFICACION clob) as

P_REGISTRO number;
  clasificacion varchar2(10);
  segmento      varchar2(2);
  familia       varchar2(2);
  clase         varchar2(2);
  
  --Cursor que se encarga de separar los grupos de clasificacione por el separador ,
   cursor cr_clasificaciones is
   WITH CL AS (SELECT P_CLASIFICACION clasificacion FROM DUAL)
    SELECT TRIM(REGEXP_SUBSTR(clasificacion, '[^,]+', 1, level)) clasificacion
    FROM CL
    CONNECT BY level <= REGEXP_COUNT(clasificacion, '[^,]+')
           AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL;

BEGIN

-- Se consulta el número de registro asociado al proponente que se carga
SELECT nro_proponente into P_REGISTRO FROM CD_JSON_CARGUE WHERE ID = vproceso;

  --Se recorre el cursor de clasificaciones para obtener los respectivos valores de segmento, familia y clase
    FOR c IN cr_clasificaciones LOOP
        --dbms_output.put_line(c.clasificacion);
        segmento:=SUBSTR(c.clasificacion,0,2);
        familia:=SUBSTR(c.clasificacion,3,2);
        clase:=SUBSTR(c.clasificacion,5,2);
		
        INSERT INTO RPT_CLASIFICACION_EXP
        (
            SECUENCIA,
            ID_EXPERIENCIA,
            SEGMENTO,
            FAMILIA,
            CLASE,
            REGISTRO
        )
        VALUES
        (
            SECUENCIA_RPT_EA.NEXTVAL,
            P_ID_EXPERIENCIA,
            segmento,
            familia,
            clase,
            P_REGISTRO
        );
  END LOOP;

END guardarClasExp;



/* *************************************************************
  Descripcion : Procedimiento guardar la información de los contratos
 * **********************************************************/
procedure guardarContratos(vproceso number,
  P_INSCRIPCION VARCHAR2, --numeroinscripcionlibro
  P_NRO_CONTRATO VARCHAR2, --numerocontrato
  P_FECHA_ADJUDICACION VARCHAR2, --fechaadjudicacion
  P_FECHA_INICIO VARCHAR2, --fechainicio
  P_FECHA_TERMINACION VARCHAR2, --fechaterminacion
  P_CLASIFICACION VARCHAR2, --codigosunspsc
  P_TIPO_CONTRATISTA VARCHAR2,--tipocontratista
  P_VALOR VARCHAR2, --valorcontrato
  P_VALOR_PAGADO VARCHAR2, --valorpagado
  P_ESTADO VARCHAR2, --estadocontrato
  P_FECHA_PERFECCIONAMIENTO VARCHAR2, --fechaperfeccionamiento
  P_FECHA_LIQUIDACION VARCHAR2, --fechaliquidacion
  P_MOT_TERM_ACT VARCHAR2, --motivoterminacionanticipada
  P_FECHA_ACTO_TERMINACION_ANT VARCHAR2,--fechaterminacionanticipada
  P_CODIGO_CAMARA VARCHAR2,--codigocamara
  P_FECHA_INSCRIPCION VARCHAR2, --fechainscripcionlibro
  P_FECHA_RADICACION_RUE VARCHAR2, --fecharadicacion
  P_NIT_ENTIDAD VARCHAR2, --nitentidad
  P_NRO_CONTRATO_SECOP VARCHAR2,--numerocontratosecop
  P_OBJETO_CONTRATO VARCHAR2, --objeto
  P_MOTIVO_CESION_CONTRATO  VARCHAR2,  --motivocesion
  P_FECHA_CESION_CONTRATO VARCHAR2, --fechacesion
  P_NOMBRE_ENTIDAD VARCHAR2, --nombreentidad
  P_MUNICIPIO VARCHAR2,  --munientidad
  P_AREA VARCHAR2        --divarea  
) as

P_REGISTRO number;
 BEGIN
   -- Se consulta el número de registro asociado al proponente que se carga
	SELECT nro_proponente into P_REGISTRO FROM CD_JSON_CARGUE WHERE ID = vproceso;
	
	INSERT INTO RPT_CONTRATO
	(
	  CONSECUTIVO_REPORTE,
	  REGISTRO,
	  INSCRIPCION,
	  NRO_CONTRATO,
	  NIT_PROPONENTE,
	  FECHA_ADJUDICACION,
	  FECHA_INICIO,
	  FECHA_TERMINACION,
	  CLASIFICACION,
	  TIPO_CONTRATISTA,
	  VALOR,
	  VALOR_PAGADO,
	  INDICADOR_CUMPLIMIENTO,
	  ESTADO,
	  INDICADOR_ENVIO,
	  TIPO_IDENTIFICACION,
	  FECHA_PERFECCIONAMIENTO,
	  FECHA_LIQUIDACION,
	  CODIGO_ACTIVIDAD,
	  CODIGO_CIIU,
	  MOTIVO_TERMINACION_ANTICIPADA,
	  FECHA_ACTO_TERMINACION_ANT,
	  OBSERVACIONES,
	  CODIGO_CAMARA,
	  CODIGO_LIBRO_REGISTRADO,
	  FECHA_INSCRIPCION,
	  FECHA_RADICACION_RUE,
	  NRO_RADICACION_RUE,
	  SW_DECRETO734,
	  NIT_ENTIDAD,
	  SW_RUES,
	  NRO_CONTRATO_SECOP,
	  CLASIFICADOR_BS,
	  OBJETO_CONTRATO,
	  MOTIVO_CESION_CONTRATO,
	  FECHA_CESION_CONTRATO,
	  CONTRATO_RELACIONADO,
	  NOMBRE_ENTIDAD,
	  MUNICIPIO_ENTIDAD,
	  AREA_ENTIDAD

	)
	VALUES
	(
	  0,
	  P_REGISTRO,
	  P_INSCRIPCION, --numeroinscripcionlibro
	  P_NRO_CONTRATO, --numerocontrato
	  NULL,
	  TO_DATE(P_FECHA_ADJUDICACION,'YYYYMMDD'), --fechaadjudicacion
	  TO_DATE(P_FECHA_INICIO,'YYYYMMDD'), --fechainicio
	  TO_DATE(P_FECHA_TERMINACION,'YYYYMMDD'), --fechaterminacion
	  P_CLASIFICACION, --codigosunspsc
	  P_TIPO_CONTRATISTA,--tipocontratista
	  P_VALOR, --valorcontrato
	  P_VALOR_PAGADO, --valorpagado
	  NULL,
	  P_ESTADO, --estadocontrato
	  NULL,
	  NULL,
	  TO_DATE(P_FECHA_PERFECCIONAMIENTO,'YYYYMMDD'), --fechaperfeccionamiento
	  TO_DATE(P_FECHA_LIQUIDACION,'YYYYMMDD'), --fechaliquidacion
	  NULL,
	  NULL,
	  from_base64(P_MOT_TERM_ACT), --motivoterminacionanticipada
	  TO_DATE(P_FECHA_ACTO_TERMINACION_ANT,'YYYYMMDD'),--fechaterminacionanticipada
	  NULL,
	  P_CODIGO_CAMARA,--codigocamara
	  NULL,
	  TO_DATE(P_FECHA_INSCRIPCION,'YYYYMMDD'), --fechainscripcionlibro
	  TO_DATE(P_FECHA_RADICACION_RUE,'YYYYMMDD'), --fecharadicacion
	  NULL,
	  NULL,
	  P_NIT_ENTIDAD, --nitentidad
	  NULL,
	  P_NRO_CONTRATO_SECOP,--numerocontratosecop
	  NULL,
	  from_base64(P_OBJETO_CONTRATO), --objeto
	  from_base64(P_MOTIVO_CESION_CONTRATO),  --motivocesion
	  TO_DATE(P_FECHA_CESION_CONTRATO,'YYYYMMDD'), --fechacesion  
	  NULL,
	  P_NOMBRE_ENTIDAD, --nombreentidad
	  P_MUNICIPIO,  --munientidad
      P_AREA        --divarea
	);
END guardarContratos;



/* *************************************************************
  Descripcion : Procedimiento guardar la información de info financiera.
 * **********************************************************/
procedure  guardarRtpInfFinanciera(vproceso number,P_TIPO_INF_FINANCIERA varchar2,P_FECHA varchar2,P_VALOR varchar2) as 

nrro_proponente number;

begin
	   -- Se consulta el número de registro asociado al proponente que se carga
	SELECT nro_proponente into nrro_proponente FROM CD_JSON_CARGUE WHERE ID = vproceso;
	
	
	--DBMS_OUTPUT.PUT_LINE('::'||P_VALOR);
	if(P_VALOR is not null )then
	
		INSERT INTO RPT_INF_FINANCIERA 
		(
		  REGISTRO,
		  TIPO_INF_FINANCIERA,
		  ANO,
		  VALOR,
		  FECHA,
		  VALOR_COP
		)
		VALUES
		(
		  nrro_proponente,
		  P_TIPO_INF_FINANCIERA, 
		  TO_CHAR(TO_DATE(P_FECHA,'YYYYMMDD'),'YYYY'),--inffin_fechacorte sacar solo el año
		  to_number(P_VALOR, '9999999999D99', 'NLS_NUMERIC_CHARACTERS='',.'''),
		  TO_DATE(P_FECHA,'YYYYMMDD'),--inffin_fechacorte
		  NULL
		);
	end if;
end guardarRtpInfFinanciera;




/* *************************************************************
  Descripcion : Procedimiento guardar la información de los multas
 * **********************************************************/
procedure guardarMultas(vproceso number,
  P_INSCRIPCION VARCHAR2, --numeroinscripcionlibro
  P_NRO_CONTRATO VARCHAR2, --numerocontrato
  P_ACTO_ADMINISTRATIVO VARCHAR2, --numeroactoadministrativo
  P_FECHA_ACTO_ADMINISTRATIVO VARCHAR2, --fechaactoadministrativo
  P_VALOR VARCHAR2,  --valormulta
  P_VALOR_PAGADO VARCHAR2, --valorpagado
  P_ESTADO VARCHAR2, --estadomulta
  P_ACTO_REVOCACION VARCHAR2,--numeroactorevocacion
  P_FECHA_ACTO_REVOCACION VARCHAR2, --fechaactorevocacion
  P_FECHA_EJECUTORIA_ACTO_ADMIN VARCHAR2,  --fechaejecutoriaactoadministrativo
  P_NRO_ACTO_SUSPENSION_TEMP VARCHAR2, --numeroactosuspension
  P_FECHA_ACTO_SUSPENSION VARCHAR2,  --fechaactosuspension
  P_NRO_ACTO_CONFIRMA_MULTA VARCHAR2, --numeroactoconfirmacion
  P_FECHA_ACTO_CONFIRMA_MULTA VARCHAR2, --fechaactoconfirmacion
  P_CODIGO_CAMARA VARCHAR2, --codigocamara
  P_FECHA_INSCRIPCION VARCHAR2, --fechainscripcionlibro
  P_FECHA_RADICACION_RUE VARCHAR2, --fecharadicacion
  P_NIT_ENTIDAD VARCHAR2, --nitentidad
  P_NRO_CONTRATO_SECOP VARCHAR2,  --numerocontratosecop
  P_NOMBRE_ENTIDAD VARCHAR2, --nombreentidad
  P_MUNICIPIO VARCHAR2,  --munientidad
  P_AREA VARCHAR2       --divarea
) as

P_REGISTRO number;
  BEGIN
   -- Se consulta el número de registro asociado al proponente que se carga
SELECT nro_proponente into P_REGISTRO FROM CD_JSON_CARGUE WHERE ID = vproceso;
 
  INSERT INTO RPT_MULTA
  (
    CONSECUTIVO_REPORTE,
    REGISTRO,
    INSCRIPCION,
    NRO_CONTRATO,
    NIT_PROPONENTE,
    ACTO_ADMINISTRATIVO,
    FECHA_ACTO_ADMINISTRATIVO,
    VALOR,
    VALOR_PAGADO,
    ESTADO,
    ACTO_REVOCACION,
    FECHA_ACTO_REVOCACION,
    INDICADOR_ENVIO,
    TIPO_IDENTIFICACION,
    FECHA_EJECUTORIA_ACTO_ADMIN,
    NRO_ACTO_SUSPENSION_TEMP,
    FECHA_ACTO_SUSPENSION,
    NRO_ACTO_CONFIRMA_MULTA,
    FECHA_ACTO_CONFIRMA_MULTA,
    OBSERVACIONES,
    CODIGO_CAMARA,
    CODIGO_LIBRO_REGISTRADO,
    FECHA_INSCRIPCION,
    FECHA_RADICACION_RUE,
    NRO_RADICACION_RUE,
    SW_DECRETO734,
    NIT_ENTIDAD,
    SW_RUES,
    NRO_CONTRATO_SECOP,
    IMAGEN_ACTO,
    NRO_ACTO_EJECUTORIA,
    NOMBRE_ENTIDAD,
    MUNICIPIO_ENTIDAD,
    AREA_ENTIDAD
  )
  VALUES
  (
    0,
    P_REGISTRO,
    P_INSCRIPCION, --numeroinscripcionlibro
    P_NRO_CONTRATO, --numerocontrato
    NULL,
    P_ACTO_ADMINISTRATIVO, --numeroactoadministrativo
    TO_DATE(P_FECHA_ACTO_ADMINISTRATIVO,'YYYYMMDD'), --fechaactoadministrativo
    P_VALOR,  --valormulta
    P_VALOR_PAGADO, --valorpagado
    P_ESTADO, --estadomulta
    P_ACTO_REVOCACION,--numeroactorevocacion
    TO_DATE(P_FECHA_ACTO_REVOCACION,'YYYYMMDD'), --fechaactorevocacion
    NULL,
    NULL,
    TO_DATE(P_FECHA_EJECUTORIA_ACTO_ADMIN,'YYYYMMDD'),  --fechaejecutoriaactoadministrativo
    P_NRO_ACTO_SUSPENSION_TEMP, --numeroactosuspension
    TO_DATE(P_FECHA_ACTO_SUSPENSION,'YYYYMMDD'),  --fechaactosuspension
    P_NRO_ACTO_CONFIRMA_MULTA, --numeroactoconfirmacion
    TO_DATE(P_FECHA_ACTO_CONFIRMA_MULTA,'YYYYMMDD'), --fechaactoconfirmacion
    NULL,
    P_CODIGO_CAMARA, --codigocamara
    NULL,
    TO_DATE(P_FECHA_INSCRIPCION,'YYYYMMDD'), --fechainscripcionlibro
    TO_DATE(P_FECHA_RADICACION_RUE,'YYYYMMDD'), --fecharadicacion
    NULL,
    NULL,
    P_NIT_ENTIDAD, --nitentidad
    1,
    P_NRO_CONTRATO_SECOP,  --numerocontratosecop
    NULL,
    NULL,
    P_NOMBRE_ENTIDAD, --nombreentidad
    P_MUNICIPIO,  --munientidad
    P_AREA        --divarea
  );
 
END guardarMultas;


--************************++SANCIONES
/* *************************************************************
  Descripcion : Procedimiento guardar la información de los sanciones
 * **********************************************************/
procedure guardarSanciones(
  vproceso number,
  P_INSCRIPCION VARCHAR2, --numeroinscripcionlibro
  P_NRO_CONTRATO VARCHAR2,  --numerocontrato
  P_ACTO_ADMINISTRATIVO VARCHAR2,  --numeroactoadministrativo
  P_FECHA_ACTO_ADMINISTRATIVO VARCHAR2,  --fechaactoadministrativo
  P_DESCRIPCION VARCHAR2,  --descripcion
  P_ESTADO VARCHAR2,  --estadosancion
  P_CUMPLIMIENTO VARCHAR2,  --condicionincumplimiento
  P_ACTO_REVOCACION VARCHAR2,   --numeroactorevocacion
  P_FECHA_ACTO_REVOCACION VARCHAR2,  --fechaactorevocacion
  P_FECHA_EJECUTORIA_ACTO_ADMIN VARCHAR2,  --fechaejecutoriaactoadministrativo
  P_NRO_ACTO_SUSPENSION_TEMP VARCHAR2,  --numeroactosuspension
  P_FECHA_ACTO_SUSPENSION VARCHAR2,   --fechaactosuspension
  P_NRO_ACTO_CONFIRMA_SANCION VARCHAR2,  --numeroactoconfirmacion
  P_FECHA_ACTO_CONFIRMA_SANCION VARCHAR2,  --fechaactoconfirmacion
  P_CODIGO_CAMARA VARCHAR2,  --codigocamara
  P_FECHA_INSCRIPCION VARCHAR2,   --fechainscripcionlibro
  P_FECHA_RADICACION_RUE VARCHAR2, --fecharadicacion
  P_NIT_ENTIDAD VARCHAR2,  --nitentidad
  P_NRO_CONTRATO_SECOP VARCHAR2,  --numerocontratosecop
  P_VIGENCIA_SANCION VARCHAR2,  --vigencia
  P_FUNDAMENTO_LEGAL VARCHAR2,  --fundamentolegal
  P_INCUMPLIMIENTO_VIVIENDA VARCHAR2,  --relacionadoconstruccion
  P_NOMBRE_ENTIDAD VARCHAR2,  --nombreentidad
  P_MUNICIPIO_ENTIDAD VARCHAR2,  --munientidad
  P_AREA_ENTIDAD VARCHAR2  --divarea
) as

P_REGISTRO number;
  BEGIN
   -- Se consulta el número de registro asociado al proponente que se carga
SELECT nro_proponente into P_REGISTRO FROM CD_JSON_CARGUE WHERE ID = vproceso;
 
  INSERT INTO RPT_SANCION
(
  CONSECUTIVO_REPORTE,
  REGISTRO,
  INSCRIPCION,
  NRO_CONTRATO,
  NIT_PROPONENTE,
  ACTO_ADMINISTRATIVO,
  FECHA_ACTO_ADMINISTRATIVO,
  DESCRIPCION,
  ESTADO,
  CUMPLIMIENTO,
  ACTO_REVOCACION,
  FECHA_ACTO_REVOCACION,
  INDICADOR_ENVIO,
  TIPO_IDENTIFICACION,
  FECHA_EJECUTORIA_ACTO_ADMIN,
  NRO_ACTO_SUSPENSION_TEMP,
  FECHA_ACTO_SUSPENSION,
  NRO_ACTO_CONFIRMA_SANCION,
  FECHA_ACTO_CONFIRMA_SANCION,
  OBSERVACIONES,
  CODIGO_CAMARA,
  CODIGO_LIBRO_REGISTRADO,
  FECHA_INSCRIPCION,
  FECHA_RADICACION_RUE,
  NRO_RADICACION_RUE,
  SW_DECRETO734,
  NIT_ENTIDAD,
  SW_RUES,
  NRO_CONTRATO_SECOP,
  IMAGEN_ACTO,
  NRO_ACTO_EJECUTORIA,
  VIGENCIA_SANCION,
  FUNDAMENTO_LEGAL,
  CONTRATO_RELACIONADO,
  INCUMPLIMIENTO_VIVIENDA,
  NOMBRE_ENTIDAD,
  MUNICIPIO_ENTIDAD,
  AREA_ENTIDAD
)
VALUES
(
  0,
  P_REGISTRO,
  P_INSCRIPCION, --numeroinscripcionlibro
  P_NRO_CONTRATO,  --numerocontrato
  NULL,
  P_ACTO_ADMINISTRATIVO,  --numeroactoadministrativo
  TO_DATE(P_FECHA_ACTO_ADMINISTRATIVO,'YYYYMMDD'),  --fechaactoadministrativo
  P_DESCRIPCION,  --descripcion
  P_ESTADO,  --estadosancion
  DECODE(P_CUMPLIMIENTO,'S',0),  --condicionincumplimiento
  P_ACTO_REVOCACION,   --numeroactorevocacion
  TO_DATE(P_FECHA_ACTO_REVOCACION,'YYYYMMDD'),  --fechaactorevocacion
  1,
  NULL,
  TO_DATE(P_FECHA_EJECUTORIA_ACTO_ADMIN,'YYYYMMDD'),  --fechaejecutoriaactoadministrativo
  P_NRO_ACTO_SUSPENSION_TEMP,  --numeroactosuspension
  TO_DATE(P_FECHA_ACTO_SUSPENSION,'YYYYMMDD'),   --fechaactosuspension
  P_NRO_ACTO_CONFIRMA_SANCION,  --numeroactoconfirmacion
  TO_DATE(P_FECHA_ACTO_CONFIRMA_SANCION,'YYYYMMDD'),  --fechaactoconfirmacion
  NULL,
  P_CODIGO_CAMARA,  --codigocamara
  NULL,
  TO_DATE(P_FECHA_INSCRIPCION,'YYYYMMDD'),   --fechainscripcionlibro
  TO_DATE(P_FECHA_RADICACION_RUE,'YYYYMMDD'), --fecharadicacion
  NULL,
  NULL,
  P_NIT_ENTIDAD,  --nitentidad
  1,
  P_NRO_CONTRATO_SECOP,  --numerocontratosecop
  NULL,
  NULL,
  TO_DATE(P_VIGENCIA_SANCION,'YYYYMMDD'),  --vigencia
  from_base64(P_FUNDAMENTO_LEGAL),  --fundamentolegal
  NULL,
  DECODE(P_INCUMPLIMIENTO_VIVIENDA,'S',1,0),  --relacionadoconstruccion
  P_NOMBRE_ENTIDAD,  --nombreentidad
  P_MUNICIPIO_ENTIDAD,  --munientidad
  P_AREA_ENTIDAD  --divarea
);
 
END guardarSanciones;


--************************++SANCIONES DISCIPLINARIAS
/* *************************************************************
  Descripcion : Procedimiento guardar la información de los sanciones disciplinarias
 * **********************************************************/
procedure guardarSancionesDisciplinarias(
  vproceso number,
  P_CONSECUTIVO VARCHAR2,  --consecutivo del registro insertado
  P_NIT_ENTIDAD VARCHAR2, --nitentidad
  P_INSCRIPCION VARCHAR2,   --numeroinscripcionlibro
  P_CODIGO_CAMARA VARCHAR2,   --codigocamara
  P_FECHA_INSCRIPCION VARCHAR2,   --fechainscripcionlibro
  P_ACTO_ADMINISTRATIVO VARCHAR2, --numeroactoadministrativo
  P_FECHA_ACTO_ADMINISTRATIVO VARCHAR2,  --fechaactoadministrativo
  P_FECHA_ACTO_EJECUTORIA VARCHAR2, --fechaejecutoriaactoadministrativo
  P_DESCRIPCION VARCHAR2,  --descripcion
  P_VIGENCIA VARCHAR2,  --vigencia
  P_FUNDAMENTO_LEGAL VARCHAR2,  --fundamentolegal
  P_ESTADO VARCHAR2, --estadosancion
  P_ACTO_SUSPENSION_TEMP VARCHAR2, --numeroactosuspension
  P_FECHA_ACTO_SUSPENSION VARCHAR2,  --fechaactosuspension
  P_ACTO_CONFIRMACION VARCHAR2,  --numeroactoconfirmacion
  P_FECHA_ACTO_CONFIRMACION VARCHAR2,  --fechaactoconfirmacion
  P_ACTO_REVOCACION VARCHAR2,  --numeroactorevocacion
  P_FECHA_ACTO_REVOCACION VARCHAR2,  --fechaactorevocacion
  P_NOMBRE_ENTIDAD VARCHAR2, --nombreentidad
  P_MUNICIPIO_ENTIDAD VARCHAR2,  --munientidad
  P_AREA_ENTIDAD  VARCHAR2         --divarea
) as

P_REGISTRO number;
  BEGIN
   -- Se consulta el número de registro asociado al proponente que se carga
SELECT nro_proponente into P_REGISTRO FROM CD_JSON_CARGUE WHERE ID = vproceso;
 
 
  INSERT INTO RPT_SANCION_DISCIPLINARIA
  (
    CONSECUTIVO_REPORTE,
    REGISTRO,
    CONSECUTIVO,
    NIT_ENTIDAD,
    INSCRIPCION,
    CODIGO_CAMARA,
    CODIGO_LIBRO_REGISTRADO,
    FECHA_INSCRIPCION,
    TIPO_IDENTIFICACION,
    NIT_PROPONENTE,
    NOMBRE_PROPONENTE,
    ACTO_ADMINISTRATIVO,
    FECHA_ACTO_ADMINISTRATIVO,
    ACTO_EJECUTORIA,
    FECHA_ACTO_EJECUTORIA,
    DESCRIPCION,
    VIGENCIA,
    FUNDAMENTO_LEGAL,
    ESTADO,
    ACTO_SUSPENSION_TEMP,
    FECHA_ACTO_SUSPENSION,
    ACTO_CONFIRMACION,
    FECHA_ACTO_CONFIRMACION,
    ACTO_REVOCACION,
    FECHA_ACTO_REVOCACION,
    INDICADOR_ENVIO,
    OBSERVACIONES,
    IMAGEN_ACTO,
    NOMBRE_ENTIDAD,
    MUNICIPIO_ENTIDAD,
    AREA_ENTIDAD
   
  )
  VALUES
  (
    0,
    P_REGISTRO,
    P_CONSECUTIVO,  --consecutivo del registro insertado
    P_NIT_ENTIDAD, --nitentidad
    P_INSCRIPCION,   --numeroinscripcionlibro
    P_CODIGO_CAMARA,   --codigocamara
    NULL,
    TO_DATE(P_FECHA_INSCRIPCION,'YYYYMMDD'),   --fechainscripcionlibro
    NULL,
    NULL,
    NULL,
    P_ACTO_ADMINISTRATIVO, --numeroactoadministrativo
    TO_DATE(P_FECHA_ACTO_ADMINISTRATIVO,'YYYYMMDD'),  --fechaactoadministrativo
    NULL,
    TO_DATE(P_FECHA_ACTO_EJECUTORIA,'YYYYMMDD'), --fechaejecutoriaactoadministrativo
    P_DESCRIPCION,  --descripcion
    TO_DATE(P_VIGENCIA,'YYYYMMDD'),  --vigencia
    from_base64(P_FUNDAMENTO_LEGAL),  --fundamentolegal
    P_ESTADO, --estadosancion
    P_ACTO_SUSPENSION_TEMP, --numeroactosuspension
    TO_DATE(P_FECHA_ACTO_SUSPENSION,'YYYYMMDD'),  --fechaactosuspension
    P_ACTO_CONFIRMACION,  --numeroactoconfirmacion
    TO_DATE(P_FECHA_ACTO_CONFIRMACION,'YYYYMMDD'),  --fechaactoconfirmacion
    P_ACTO_REVOCACION,  --numeroactorevocacion
    TO_DATE(P_FECHA_ACTO_REVOCACION,'YYYYMMDD'),  --fechaactorevocacion
    1,
    NULL,
    NULL,
    P_NOMBRE_ENTIDAD, --nombreentidad
    P_MUNICIPIO_ENTIDAD,  --munientidad
    P_AREA_ENTIDAD          --divarea
  );
 
END guardarSancionesDisciplinarias;


--**********************REPRESENTANTES LEGALES

/* *************************************************************
  Descripcion : Procedimiento guardar la información de los representantes legales
 * **********************************************************/
procedure guardarRepreentantes
(
 vproceso number,
 P_SECUENCIA VARCHAR2,
 P_TIPO_IDENTIFICACION VARCHAR2, --tipoidentificacion
 P_NRO_IDENTIFICACION VARCHAR2,--identificacion
 P_PRIMER_NOMBRE  VARCHAR2,--nom1
 P_SEGUNDO_NOMBRE VARCHAR2, --nom2
 P_PRIMER_APELLIDO  VARCHAR2,--ape1
 P_SEGUNDO_APELLIDO  VARCHAR2-- ape2

) as

P_REGISTRO number;
  BEGIN
   -- Se consulta el número de registro asociado al proponente que se carga
	SELECT nro_proponente into P_REGISTRO FROM CD_JSON_CARGUE WHERE ID = vproceso;
 
 
 
INSERT INTO RPT_REPRESENTANTE
(
 REGISTRO,
 NRO_REPRESENTANTE,
 TIPO_IDENTIFICACION,
 NRO_IDENTIFICACION,
 PAIS,
 NOMBRE_REPRESENTANTE
)
VALUES
(
 P_REGISTRO,
 P_SECUENCIA,
 (SELECT ti.CODIGO_LOCAL FROM BAS_CLASES_IDENTIFICACION ti WHERE ti.CODIGO_RUE=P_TIPO_IDENTIFICACION AND ROWNUM=1), --tipoidentificacion
 P_NRO_IDENTIFICACION,--identificacion
 169,
 (P_PRIMER_NOMBRE||' '||P_SEGUNDO_NOMBRE||' '||P_PRIMER_APELLIDO ||' '|| P_SEGUNDO_APELLIDO) --ape1 ape2 nom1 nom2

);

 
END guardarRepreentantes;


--**********************SITUACIONES DE CONTROL

/* *************************************************************
  Descripcion : Procedimiento guardar la información de las situaciones de control
 * **********************************************************/
procedure guardarSituacionesControl
(
  vproceso number,
  P_SECUENCIA VARCHAR2,
  P_NOMBRE VARCHAR2,  --nombre
  P_IDENTIFICACION VARCHAR2, --identificación
  P_TIPO VARCHAR2, --TIPO
  ID_DOMICILIO VARCHAR2--domicilio 
) as



cursor cuDatos  is select NOMBRE_CIUDAD from ciudades  where ciudad = ID_DOMICILIO;


	P_REGISTRO number;
	sbCiudad 	varchar2(50) := '';

  BEGIN
  
  OPEN cuDatos;
  FETCH cuDatos into sbCiudad;
  close cuDatos;
   
  
   -- Se consulta el número de registro asociado al proponente que se carga
SELECT nro_proponente into P_REGISTRO FROM CD_JSON_CARGUE WHERE ID = vproceso;
 
 
 
 
 
 
INSERT INTO RPT_SITUACIONES_CONTROL
(
  REGISTRO,
  SECUENCIA,
  GRUPO,
  NOMBRE,
  IDENTIFICACION,
  DOMICILIO,
  ID_SITUACION_ROL,
  ID_DOMICILIO
)
VALUES
(
  P_REGISTRO,
  P_SECUENCIA,
  1,
  P_NOMBRE,
  P_IDENTIFICACION, --identificación
  sbCiudad, --domicilio
  (TO_NUMBER(P_TIPO)+1), --TIPO
  ID_DOMICILIO --domicilio
);

 
END guardarSituacionesControl;

END PKG_CD_CAMBIO_DOM;
/
