

CREATE OR REPLACE FUNCTION F_TRAERINFO_FIN_TIPO(vTipo number,vano number,vregistro number,vinscripcion number) return number  is
    resvalor RP_INF_FINANCIERA.VALOR%type := null;
    cursor cuDato is    select VALOR FROM RP_INF_FINANCIERA where registro = vregistro and inscripcion = vinscripcion and tipo_inf_financiera = vtipo and ano = vano;

begin
   open  cuDato;
   fetch cuDato into resvalor;
   close cuDato;
   
   return resvalor;
   
end F_TRAERINFO_FIN_TIPO;