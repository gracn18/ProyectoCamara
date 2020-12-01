

CREATE OR REPLACE FUNCTION F_TRAERINFO_FIN_TIPO(vTipo number,vano number,vregistro number,vinscripcion number) return varchar2  is
    resvalor VARCHAR2(100);
    cursor cuDato is    select  decode(substr(VALOR,1,1),'.','0'||VALOR,VALOR) FROM RP_INF_FINANCIERA where registro = vregistro and inscripcion = vinscripcion and tipo_inf_financiera = vtipo and ano = vano;

begin
   open  cuDato;
   fetch cuDato into resvalor;
   close cuDato;
   
   return resvalor;
end F_TRAERINFO_FIN_TIPO;