package utils.json;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;

public class JsonplUtil {

	private static Clob resclob;

	public static String generarJson(String xml) {
		
		   JSONObject xmlJSONObj = XML.toJSONObject(xml);

           String jsonPrettyPrintString = xmlJSONObj.toString();
           return jsonPrettyPrintString;
           
	
	
	}
	
	public static Clob generarJsonxmlclob( Clob xml,Clob json) throws Exception {
		
		
		StringBuilder sb = new StringBuilder();
		Reader reader;
		resclob = null;
		
	
			reader = xml.getCharacterStream();
			BufferedReader br = new BufferedReader(reader);

	        String line;
	        while(null != (line = br.readLine())) {
	             sb.append(line);
	        }
	        br.close();
	        
	        
	        
			String xmljson = sb.toString();
			
			JSONObject xmlJSONObj = XML.toJSONObject(xmljson);
			
			xml.truncate(xmljson.length());
			
			json.setString(1, xmlJSONObj.toString());
			
			
			
			return json;

		
		
	}
		

	public static String jsontodataoracle(String idproceso,String cadenacon,String user,String pwd) throws SQLException {
		
		 	Connection con =null ;
		 	String paso = "";
		 	String respp ="";
			try {
				
				
			
				   
				Class.forName("oracle.jdbc.driver.OracleDriver");
				paso = "eldriver";
				
				con=DriverManager.getConnection(cadenacon,user,pwd);  
				paso = "paso conexion";  

				Statement stmt=con.createStatement();  
				
			
				paso = "paso statement 1 ";
				
				
				//QUERY PROCESO 
				ResultSet rs=stmt.executeQuery("SELECT ID_MAESTRA_JSON,JSON_CARGADO FROM CD_JSON_CARGUE where ID = "+idproceso);
				String idMaestraJson = "";
				String jsoncargue = "";
				
				paso = "paso statement 2 ejecucion consulta proceso. ";
				
				while(rs.next()) {
					idMaestraJson =rs.getString(1);
					jsoncargue =rs.getString(2);
					
				}
				
			
				
				JSONObject jsonObject = new JSONObject(jsoncargue);
				
				if(jsonObject == null ) {

					grabarError("Error la estructura a cargar configurada  en BASE DE DATOS es invalida ",idproceso,con);
					return "ERROR";
					
				}
					
				rs.close();
				stmt.close();
				
				
				stmt=con.createStatement(); 
				
				//QUERY TABLA PRINCIPAL
				rs=stmt.executeQuery("select ID,Upper(TAG_TABLA_PLURAL) tablaplural,TIPO_TABLA,TAG_TABLA_SINGULAR from cd_tablas_estructura_json\r\n"
						+ "where id_maestrojson = "+idMaestraJson+ " and TIPO_TABLA = 'P'");
				
				
				
				paso = "paso sql principal";

				
				String tablappal = null;
				String idtabla  = "";
				String tipoTabla  ="";
				String tagsingular = "";
				
				while(rs.next()) {
					
				
					
					idtabla 	= rs.getString(1);
					tablappal	= rs.getString(2);
					tipoTabla 	= rs.getString(3);
					tagsingular = rs.getString(4);
					
				}
				
				JSONObject tbprinciapal= null;
				//valida si viene el tag.
				if(jsonObject.getJSONObject(tablappal) != null){
					
					//trae el json principal.
					tbprinciapal =  jsonObject.getJSONObject(tablappal);
					
					paso = "leer tabla jsonl";
					
					
					
					respp= traerfieldstablas(con,tablappal,tagsingular,idproceso,idMaestraJson,idtabla ,tipoTabla,tbprinciapal,1);
					
					
					paso = "leer estructura json";
					
				}
				else {
					return "Error : No se encontroo tag Raiz "+tablappal; //tabla tag raiz principal no encontrada
				}
				
				rs.close();
				stmt.close();
				
				
				//consultas de subtablas
				
				
				
				stmt=con.createStatement(); 
				
				//QUERY DE SUB TABLAS PRINCIPAL
				rs=stmt.executeQuery("select ID,Upper(TAG_TABLA_PLURAL) tablaplural,TIPO_TABLA,TAG_TABLA_SINGULAR from cd_tablas_estructura_json\r\n"
						+ "where id_maestrojson = "+idMaestraJson+ " and TIPO_TABLA = 'S'");
				
		
				 String tagsutabla = null;
				 idtabla  = "";
				 tipoTabla  ="";
				 tagsingular = "";
				
				while(rs.next()) {
						
					idtabla 	= rs.getString(1);
					tagsutabla	= rs.getString(2);
					tipoTabla 	= rs.getString(3);
					tagsingular = rs.getString(4);
					
					//trae el json principal.
					try {
						
						JSONObject tbsubtabla = tbprinciapal.getJSONObject(tagsutabla);
						
						JSONArray arreglodatos = tbsubtabla.getJSONArray(tagsingular);
						
						//recorre todos los datos cuando es una subtabla
						for(int i=0;i<=arreglodatos.length();i++) {
							JSONObject objetojson = (JSONObject) arreglodatos.get(i);
							
							respp += traerfieldstablas(con,tagsutabla,tagsingular,idproceso,idMaestraJson,idtabla ,tipoTabla,objetojson,i+1);
							
						}

					}
					catch (JSONException e) {
						//System.out.println("tabla no encontrada json :: "+e.getCause());
						 paso = "tabla no encontrada json :: "+e.getCause();
						
					}
			
					
					
					
					
					paso = "leer subtabla tag "+tagsutabla+" tabla jsonl";
					
					
				}
		
				rs.close();
				stmt.close();
				
				if(respp.contains("ERRORES")) {
					return "ERRORES";
				}
				return "OK";
				
				
			} catch (JSONException e) {
				if(con!=null) {
					try {
						con.rollback();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
				grabarError("Error de json : "+e.getMessage(),idproceso,con);
				return "Error de json : "+e.getMessage();
			}
			catch (ClassNotFoundException e) {
				grabarError("Error de clase oracle no encontrada : "+paso,idproceso,con);
				return "Error de clase oracle no encontrada : "+paso;
			} catch (SQLException e) {
				
				if(con!=null) {
					try {
						con.rollback();
					} catch (SQLException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
				grabarError("Error de consulta "+e.getMessage()+paso,idproceso,con);
				return "Error de consulta "+e.getMessage()+paso;
			} catch (Exception e) {
				grabarError("Error lectura json "+paso,idproceso,con);
				return "Error lectura json "+paso;
			} 
			finally {
				try {
					if(con!=null) {
						con.commit();
						con.close();
					}

				} catch (SQLException e) {
					return "Error cerrando conexion "+paso;

				}  
			}


			  
	}  
	
	
	
	private static String traerfieldstablas(Connection con,String tagRaiz,String tagsingular,String idCargue,String idMaestrajson,String idTabla,String tipoTabla ,JSONObject jsonobject,Integer numeroRegistro) throws Exception{
		
		String res = "ok";
		
		String sql = "select id,nombre_campo_json,tipo_campo,tipodato,OBLIGATORIO from cd_detalle_tabla_json "
				+ "		where id_tabla = "+idTabla
				+ " AND tipo_campo ='N' "
				+ "order by orden";
		

			Statement stmt=con.createStatement();  
			ResultSet rs=stmt.executeQuery(sql);  
			String sqlinsert  ="";
			int datos=0;
			
			while(rs.next()) {
				
				sqlinsert  ="";
				datos++;
				String idDetalle =  rs.getString(1);
				String nombreCampoJson=  rs.getString(2);
				String tipoCampo=  rs.getString(3);
				String tipodato =  rs.getString(4);
				String obligatorio = rs.getString(5);
				String valor = "";
				String valorClob ="NULL";
						
				try {
					
					//por registro
					valor = jsonobject.optString(nombreCampoJson);
					
					sqlinsert = getinsert(idDetalle,nombreCampoJson,tipoCampo,tipodato,obligatorio,valor,valorClob,idMaestrajson,idCargue,numeroRegistro,con);
					if(sqlinsert.equals("ERRORES")) {
						res = "ERRORES";
					}else {
						
					PreparedStatement stm2 = con.prepareStatement(sqlinsert);
					stm2.executeQuery();
					
					stm2.close();

					}
					
				}catch (Exception e) {
					valor = "";
				}

				
			}
			
			if(datos==0) {
				res= "ERRORES";
				grabarError("Error la estructura a cargar configurada  en BASE DE DATOS es invalida ",idCargue,con);
				//throw new Exception("Error la estructura a cargar configurada  en BASE DE DATOS es invalida ");
			}
				
			
			rs.close();
			stmt.close();
	
		return res;
	}
	
    private static String getinsert(String idDetalle,String nombreCampoJson,String tipoCampo,String tipodato,String obligatorio,String valor,String valorClob,String idMaestrajson,String idCargue,Integer numeroregistro,Connection con) throws Exception{

	
    	String sqlinsert1 = "";
    	
		if(obligatorio !=null && obligatorio.equals("S") && valor.equals("")){
			sqlinsert1 = "ERRORES";
			grabarError("Error la estructura a cargar del archivo json  el campo "+nombreCampoJson+" no contiene datos o el json es invalido",idCargue,con);
			//throw new Exception("Error la estructura a cargar del archivo json  el campo "+nombreCampoJson+" no contiene datos o el json es invalido");
		}
		
		if(tipodato !=null && tipodato.equals("CLOB")) {
			valorClob = "to_clob('"+valor+"')";
			
		}else {
			valorClob = "null";
			
		}
		
		
		boolean inserta = false;
		
		if(valor != null  && !valor.equals("")) {
			inserta = true;
		}

		
		if(valorClob !=null && valorClob.equals("NULL")) {
			valor = "";
			
			inserta = true;
		}
		
		
		if(inserta) {
			sqlinsert1 ="insert into CD_TABLA_DATOS_JSON  (ID,ID_CD_MAESTRA_JSON,ID_DETALLE_JSON,VALOR,VALORCLOB,CD_JSON_CARGUE_ID,NRO_REGISTRO) "
					+ "values (CD_TABLA_DATOS_JSON_SEQ.nextval,"
					+ idMaestrajson+","
					+ idDetalle+","
					+"'" +valor+"',"
					+ valorClob+","
					+ idCargue+","
					+numeroregistro+ ""
							+ ")";
		}
		
    	return sqlinsert1;
    }
    
    private static void grabarError(String errorr,String idCargue,Connection con) throws SQLException {
    	
    	String sqlinsert  = "insert into CD_JSON_LOG_ERRORES_CARGUE(ID,ERROR,CD_JSON_CARGUE_ID) VALUES(CD_JSON_LOG_ERRORES_CARGUE_SQ.NEXTVAL,'"+errorr+"',"+idCargue+")";
    	PreparedStatement stm2 = con.prepareStatement(sqlinsert);
		stm2.executeQuery();
		
		stm2.close();
		
    }
    
    
	public static void main(String[] args) {
	
    
	String res;
	try {
		res = jsontodataoracle("1","jdbc:oracle:thin:@172.16.1.58:1521:CAMARA","RECA_DB","RECA");
		//System.out.println(res);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
		
	}
	
	
}
