CREATE OR REPLACE PACKAGE PKG_CD_CAMBIO_DOM AS 
/*
    Definicion : paquete logida de cambio de domicilio a partir de datos cargados en la tabla cd_tabla_datos_json
    Parametros : 
*/

	
 procedure cargaTabla(vproceso number);
 function fnGetValorCampoTabla(proceso number,idTabla number,campoTabla varchar2,numReg number) return varchar2;

 --function fnGetValorCampoTablaClob(proceso number,idTabla number,campoTabla varchar2,numReg number) return varchar2;
 procedure llenarDatosProcedimiento(vproceso number,vnombreproceso varchar2,idtabla number,registrostabla number); 
 
 
 procedure prc_crearProponente(vproceso number, P_NIT varchar2,P_NACIONALIDAD varchar2,P_NUMERO_ID_TRIBUTARIA_PAIS varchar2,P_ORGANIZACION varchar2,P_TAM_EMPRESA varchar2,P_FECHA_INSCRIPCION varchar2,P_FECHA_RENOVACION varchar2);
 procedure crearDirecciones(vproceso number,P_TIPO_DIRECCION number,P_MUN number,P_DIRECCION varchar2,P_TELEFONO1 varchar2,P_CORREO varchar2,P_TELEFONO2 number,P_TELEFONO3 number,P_ZONA varchar2,P_ZONA_POSTAL number,P_UBICACION number,P_BARRIO VARCHAR2);
 procedure crearNombreProponente(vproceso number, P_NOMBRE varchar2,P_SEGUNDO_NOMBE varchar2,P_PRIMER_NOMBRE varchar2,P_SEGUNDO_APELLIDO varchar2, P_PRIMER_APELLIDO varchar2);
 procedure crearRptProponentePn(vproceso number,P_NRO_IDENTIFICACION varchar2,P_TIPO_IDENTIFICACION varchar2,P_PAIS varchar2);
 procedure crearRptProponentePj(vproceso number,P_FECHA_VENCIMIENTO varchar2,P_FECHA_DOCUMENTO varchar2,P_TIPO_DOCUMENTO varchar2,P_NRO_DOCUMENTO varchar2);

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

	nuReg NUMBER ;
begin

	if(vnombreproceso = 'PRCPROPONENTE') Then
		 
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
					
				crearNombreProponente(vproceso,
									 fnGetValorCampoTabla(vproceso,idtabla,'nombre_o_razon_social',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'nom2',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'nom1',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'ape2',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'ape1',nuReg)
									);
								
				
				crearRptProponentePn(vproceso,
									 fnGetValorCampoTabla(vproceso,idtabla,'identificacion',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'tipoidentificacion',nuReg),
									 fnGetValorCampoTabla(vproceso,idtabla,'idpaisidentificacion',nuReg)
									 );
									 

				crearRptProponentePj(vproceso,
									fnGetValorCampoTabla(vproceso,idtabla,'fechavencimiento',nuReg),
									fnGetValorCampoTabla(vproceso,idtabla,'fecdocperjur',nuReg),
									fnGetValorCampoTabla(vproceso,idtabla,'tipodocperjur',nuReg),
									fnGetValorCampoTabla(vproceso,idtabla,'numdocperjur',nuReg)
									);

				
				nuReg := nuReg +1 ;
			end loop;
	end if;
	 
	if(vnombreproceso  = 'PRCSITUACIONESCONTROL') Then
		null;
		--procedmiento llena la tabla de proponente.
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
  P_FECHA_DOCUMENTO,--fecdocperjur
  P_TIPO_DOCUMENTO, --tipodocperjur
  NULL,
  P_NRO_DOCUMENTO,--numdocperjur
  NULL 
);


end crearRptProponentePj;

END PKG_CD_CAMBIO_DOM;
/
