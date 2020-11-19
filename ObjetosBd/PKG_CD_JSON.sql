CREATE OR REPLACE PACKAGE PKG_CD_JSON AS 
/*
    Definicion : generar json 
    Parametros : jsonid id json tabla CD_MAESTRA_JSON, datos varchar2 para filtrar tabla princiapal.
*/

	type xmldata IS RECORD (
		xmljson XMLTYPE
	);

	TYPE xmldatatb IS TABLE OF xmldata;
	
 PROCEDURE generarJson( jsonid  in number , datos in varchar2 , idjsongen out number ,clobjsongen out clob );
 
 
 function fnHomologaDato (vtabla varchar2,datolocal varchar2) return varchar2;
 
 function generarJsonxmlclob(xml clob,json clob)return clob;

 
END PKG_CD_JSON;
/


CREATE OR REPLACE PACKAGE BODY PKG_CD_JSON AS


 function fnHomologaDato (vtabla varchar2,datolocal varchar2) return varchar2 as
 
 sbres varchar2(1000) :='';
 
 begin
	select VALOR_HOMOLOGADO into sbres FROM  RECA_DB.CD_HOMOLOGACION_JSON WHERE TABLA = vtabla and VALOR_LOCAL = datolocal; 
	return sbres;
	
	exception 
	when others then 
		return '';
		
 end fnHomologaDato; 
 
 procedure guardaProceso(idJson number ,json_generado clob  ,logerr varchar2) as 
 begin 
 
	insert into CD_JSON_GENERADO(ID,ID_MAESTRA_JSON,FECHA_GENERACION,JSON_GENERADO,log) values (CD_JSON_GENERADO_SEQ.nextval,idJson,sysdate,json_generado,logerr);
	
	commit;
	
 end guardaProceso;


  function generaSqlTablaPrincipal(vid number ,datoswhere varchar2,vtipo varchar2) return varchar2 AS 
  cursor cuDatosTabla is 
  select * from  CD_TABLAS_ESTRUCTURA_JSON  where id = vid;
  
    cursor cuDatosTabla2(vid number) is 
  select * from  CD_TABLAS_ESTRUCTURA_JSON  where id = vid;
  
  rgDatosTabla cuDatosTabla%rowtype;
  
  rgDatosTabla2 cuDatosTabla%rowtype;
  
  
  cursor cuDatosCampos(vidTabla number) is
  select * from  CD_DETALLE_TABLA_JSON where id_tabla = vidTabla
  ORDER BY ORDEN ASC;
  
  nuCampos number :=0;
  
  sbRestsql varchar2(32000);
  sbCampos varchar2(32000) := '';
  
  
  cursor cuTablaAnidada(idCampo number) is 
  select id_tabla_estructura from CD_RELACION_TABLAS_JSON where id_detalle_json_relacion = idCampo;
  
  nuEstructura number := null;
  sbsqlTabla2 varchar2(32000) :='';
  
  sbArregloini varchar2(20) := '';
  sbArreglofin varchar2(20) := '';
  
  BEGIN
	OPEN cuDatosTabla;
	FETCH cuDatosTabla INTO rgDatosTabla;
	CLOSE cuDatosTabla;
	
	if(vtipo ='S') THEN
		sbArregloini := 'XMLAGG(';
		sbArreglofin := ')';
		
	end if;
	 
	sbRestsql :='SELECT '||sbArregloini||' XMLELEMENT("'||rgDatosTabla.tag_tabla_plural||'",
						 
								XMLELEMENT ("'||rgDatosTabla.tag_tabla_singular||'", 
									XMLFOREST (';
	
	
	for rgCampos in cuDatosCampos(rgDatosTabla.id) loop
		nuCampos  := nuCampos+1;
		nuEstructura := null;
	
	
		-- SE GENERA EL CAMPO NORMAL.
		IF (rgCampos.TIPO_CAMPO = 'N') THEN
			sbCampos := sbCampos  || '
													'||rgCampos.NOMBRE_CAMPO_ORACLE || ' AS "'|| rgCampos.NOMBRE_CAMPO_JSON||'",';
		END IF;
		
		if(rgCampos.TIPO_CAMPO = 'S') then
			--consultar la tabla anidada del campo .
			open cuTablaAnidada(rgCampos.id);
			fetch cuTablaAnidada into nuEstructura;
			close cuTablaAnidada;
			
			if(nuEstructura is null ) then
				guardaProceso(rgDatosTabla.ID_MAESTROJSON,NULL,'JSON ERR : NO EXISTE CONFIGURACION DE TABLA PARA LA  LISTA  ID : .'||rgCampos.id );
				RAISE_APPLICATION_ERROR(-20000, 'JSON ERR : NO EXISTE CONFIGURACION DE TABLA PARA LA LISTA  ID : .'||rgCampos.id);
			end if;

			open cuDatosTabla2(nuEstructura);
			fetch cuDatosTabla2 into rgDatosTabla2;
			close cuDatosTabla2; 
			--se crea xml de la estructura anidada.
			sbsqlTabla2 := generaSqlTablaPrincipal(nuEstructura,null,'S');
			sbCampos := sbCampos ||'	( 
										'|| sbsqlTabla2 ||'
										
									)' || rgDatosTabla2.tag_tabla_plural||',';
			
			--limpiar cadenas
			rgDatosTabla2 := null;
			sbsqlTabla2:=null;
			
		end if;
		
		
		
		
	end loop;
	--elimina ultima comma.
	sbCampos := RTRIM(sbCampos,',');
	
	
	
	sbRestsql :=sbRestsql||sbCampos||'
				)
			
		)
	) '||sbArreglofin||' xmldata';
	
	
	-- se concatena el from de la tabla
	sbRestsql := sbRestsql || ' 
	FROM 
	'|| rgDatosTabla.TABLA_ORIGEN;
	
	-- se concatena el where dinamico
	sbRestsql := sbRestsql || '
	 '|| rgDatosTabla.WHERE_DINAMICO;
	
	
	sbRestsql := sbRestsql || datoswhere ;
	
	--dbms_output.put_line('sql '||sbRestsql);
	
	
	
	
	if(nuCampos = 0) then
		guardaProceso(rgDatosTabla.ID_MAESTROJSON,NULL,'JSON ERR : LA TABLA ID : '||vid||'  NO TIENE CONFIGURADO DETALLE DE LA ESTRUCTURA.');
		RAISE_APPLICATION_ERROR(-20000, 'JSON ERR : LA TABLA ID : '||vid||' NO TIENE CONFIGURADO DETALLE DE LA ESTRUCTURA.');
		
	end if;
	
	return sbRestsql;
  END generaSqlTablaPrincipal;
  
  
  
  
 /*Procedimiento principal genera json.*/
  PROCEDURE generarJson( jsonid  in number  , datos in  varchar2  , idjsongen  out number ,clobjsongen out clob ) AS
  
  --cursor datos estructura json.
  cursor cucdMaestrajson is 
  select * from CD_MAESTRA_JSON where id = jsonid;
  
  cursor cuTablaPrincipal(vidmaestro number) is
  select * from CD_TABLAS_ESTRUCTURA_JSON where id_maestrojson  = vidmaestro
  and tipo_tabla= 'P';
  
  
  rgMaestrajson cucdMaestrajson%rowtype;
  rgtablaPrincipal cuTablaPrincipal%rowtype;
  vsqlxml varchar2(32000);
  v_row xmldata;
  clobxml clob := null;
  clobjson clob := null;
  
  clobfinaljson clob:=null;
  
  xmlvjson xmltype;
  
  BEGIN
    
	
    open cucdMaestrajson;
    fetch cucdMaestrajson into rgMaestrajson;
    close cucdMaestrajson; 
	--valida si existe configuracion. 
	if(rgMaestrajson.id is null) then
			guardaProceso(jsonid,NULL,'JSON ERR : NO SE ENCONTRO CONFIGURACION DEL ID '||jsonid);
			RAISE_APPLICATION_ERROR(-20000, 'JSON ERR : NO SE ENCONTRO CONFIGURACION DEL ID '||jsonid);
	end if;
	
	open  cuTablaPrincipal(rgMaestrajson.id);
	fetch cuTablaPrincipal into rgtablaPrincipal;
	close cuTablaPrincipal;
	
	
	if(rgtablaPrincipal.id is null) then
			guardaProceso(jsonid,NULL,'JSON ERR : NO SE ENCONTRO CONFIGURACION DE TABLA PRINCIPAL '||rgtablaPrincipal.id);
			RAISE_APPLICATION_ERROR(-20000, 'JSON ERR : NO SE ENCONTRO CONFIGURACION DE TABLA PRINCIPAL '||rgtablaPrincipal.id);
	end if;
	
    vsqlxml :=generaSqlTablaPrincipal(rgtablaPrincipal.id,datos,'N');
	
	
	
	-- EJECUCION DE QUERY. 
	begin
		EXECUTE IMMEDIATE vsqlxml into v_row;
		
		exception 
		when no_data_found then
			guardaProceso(jsonid,NULL,'JSON ERR : NO SE ENCONTRARON REGISTORS ');
			RAISE_APPLICATION_ERROR(-20000, 'JSON ERR : NO SE ENCONTRARON REGISTROS '||vsqlxml);
		when others then
			guardaProceso(jsonid,NULL,'JSON ERR : ERROR EJECUTANDO QUERY XML '||vsqlxml);

			RAISE_APPLICATION_ERROR(-20000, 'JSON ERR : ERROR EJECUTANDO QUERY XML '||vsqlxml);
	end;
	
	
	-- generacion json 
	
	begin
		clobxml := v_row.xmljson.getClobVal();
		
		--variable clob.
		select XMLELEMENT("JSON") into xmlvjson from dual;
		clobjson := xmlvjson.getClobVal();
		
		clobfinaljson := generarJsonxmlclob(clobxml,clobjson);
		
		
		guardaProceso(jsonid,clobfinaljson,'');
		
		clobjsongen := clobfinaljson;
		idjsongen := CD_JSON_GENERADO_SEQ.currval;
		
		
	exception 
		when others then
		guardaProceso(jsonid,NULL,'JSON ERR : ERROR GENERANDO JSON XML '||SQLERRM);
		RAISE_APPLICATION_ERROR(-20000, 'ERROR GENERANDO JSON XML '||SQLERRM);

	end;
	
  END generarJson;
  
  


function         generarJsonxmlclob(xml clob,json clob)return clob as
LANGUAGE JAVA
NAME 'utils.json.JsonplUtil.generarJsonxmlclob(java.sql.Clob,java.sql.Clob) return java.sql.Clob ';

  

END PKG_CD_JSON;
/
