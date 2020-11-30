DECLARE
  JSONID NUMBER;
  DATOS VARCHAR2(200);
  IDJSONGEN NUMBER;
  CLOBJSONGEN CLOB;
BEGIN
  JSONID := 2;
  DATOS := ' and a.registro = 15302 and rownum = 1 ';

  PKG_CD_JSON.GENERARJSON(
    JSONID => JSONID,
    DATOS => DATOS,
    IDJSONGEN => IDJSONGEN,
    CLOBJSONGEN => CLOBJSONGEN
  );
--DBMS_OUTPUT.PUT_LINE('IDJSONGEN = ' || IDJSONGEN);

--DBMS_OUTPUT.PUT_LINE('CLOBJSONGEN = ' || CLOBJSONGEN);

END;



DECLARE
  VPROCESO NUMBER;
BEGIN
  VPROCESO := 121;

  PKG_CD_CAMBIO_DOM.CARGATABLA(
    VPROCESO => VPROCESO
  );
  /*commit;
  exception 
  when others then 
   dbms_output.put_line(sqlerrm);
  rollback;
  */
END;

PKG_CD_CAMBIO_DOM;

truncate table cd_tabla_datos_json
select to_number('376,6', '9999999999D9999', 'NLS_NUMERIC_CHARACTERS='',.''') from dual

select to_number('376,6','9999,0','NLS_NUMERIC_CHARACTERS = '',.''') from dual

PKG_CD_CAMBIO_DOM