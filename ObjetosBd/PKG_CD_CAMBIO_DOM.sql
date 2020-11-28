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
			
				--
					nuReg := nuReg +1 ;
			end loop;
	end if;
	 
	if(vnombreproceso  = 'PRCSITUACIONESCONTROL') Then
		null;
		--procedmiento llena la tabla de proponente.
	end if;

end llenarDatosProcedimiento;


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


	DBMS_OUTPUT.PUT_LINE('P_FECHA_INSCRIPCION '||P_FECHA_INSCRIPCION||' P_FECHA_RENOVACION '||P_FECHA_RENOVACION);
	
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

END PKG_CD_CAMBIO_DOM;
/
