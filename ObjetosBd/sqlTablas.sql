-- Generado por Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   en:        2020-11-03 15:17:01 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g




CREATE TABLE reca_db.cd_detalle_tabla_json (
    id                   NUMBER(15) NOT NULL,
    id_tabla             NUMBER(15) NOT NULL,
    nombre_campo_json    VARCHAR2(50),
    nombre_campo_oracle  VARCHAR2(50),
    tipo_campo           CHAR(1),
    tipodato             VARCHAR2(50)
)
LOGGING;

COMMENT ON COLUMN reca_db.cd_detalle_tabla_json.id IS
    'id clave principal';

COMMENT ON COLUMN reca_db.cd_detalle_tabla_json.id_tabla IS
    'id tabla estructura. ';

COMMENT ON COLUMN reca_db.cd_detalle_tabla_json.nombre_campo_json IS
    'nombre campo json.';

COMMENT ON COLUMN reca_db.cd_detalle_tabla_json.nombre_campo_oracle IS
    'nombre campo oracle.';

COMMENT ON COLUMN reca_db.cd_detalle_tabla_json.tipo_campo IS
    'N normal , S Sublista.';

ALTER TABLE reca_db.cd_detalle_tabla_json ADD CONSTRAINT bas_detalletablajson_pk PRIMARY KEY ( id );
CREATE TABLE reca_db.cd_json_generado (
    id                NUMBER(15) NOT NULL,
    id_maestra_json   NUMBER(15) NOT NULL,
    fecha_generacion  DATE,
    json_generado     CLOB,
    log               VARCHAR2(3000)
)
LOGGING;

COMMENT ON COLUMN reca_db.cd_json_generado.log IS
    'Log proceso.';

ALTER TABLE reca_db.cd_json_generado ADD CONSTRAINT bas_json_generado_pk PRIMARY KEY ( id );
CREATE TABLE reca_db.cd_maestra_json (
    id           NUMBER(15) NOT NULL,
    nombre       VARCHAR2(50),
    descripcion  VARCHAR2(3000),
    estado       CHAR(1)
)
LOGGING;

ALTER TABLE reca_db.cd_maestra_json
    ADD CHECK ( estado IN ( 'A', 'I' ) );

COMMENT ON COLUMN reca_db.cd_maestra_json.id IS
    'ID PRINCIPAL TABLA';

COMMENT ON COLUMN reca_db.cd_maestra_json.nombre IS
    'NOMBRE DEL JSON';

COMMENT ON COLUMN reca_db.cd_maestra_json.descripcion IS
    'DESCRIPCION JSON.';

COMMENT ON COLUMN reca_db.cd_maestra_json.estado IS
    'ESTADO DEL JSON A- ACTIVO - I INACTIVO';

ALTER TABLE reca_db.cd_maestra_json ADD CONSTRAINT bas_maestrajson_pk PRIMARY KEY ( id );
CREATE TABLE reca_db.cd_relacion_tablas_json (
    id                        NUMBER(15) NOT NULL,
    id_tabla_estructura       NUMBER(15) NOT NULL,
    id_detalle_json_relacion  NUMBER(15) NOT NULL
)
LOGGING;

ALTER TABLE reca_db.cd_relacion_tablas_json ADD CONSTRAINT bas_relacion_tablas_json_pk PRIMARY KEY ( id );
CREATE TABLE reca_db.cd_tablas_estructura_json (
    id                  NUMBER(15) NOT NULL,
    id_maestrojson      NUMBER(15) NOT NULL,
    tabla_origen        VARCHAR2(500),
    where_dinamico      VARCHAR2(200),
    tabla_padre         NUMBER(15),
    tipo_tabla          CHAR 
--  WARNING: CHAR size not specified 
    ,
    tag_tabla_singular  VARCHAR2(100),
    tag_tabla_plural    VARCHAR2(100)
)
LOGGING;

ALTER TABLE reca_db.cd_tablas_estructura_json
    ADD CHECK ( tipo_tabla IN ( 'P', 'S' ) );

COMMENT ON COLUMN reca_db.cd_tablas_estructura_json.id IS
    'id llave principal';

COMMENT ON COLUMN reca_db.cd_tablas_estructura_json.id_maestrojson IS
    'id foranea tabla BAS_MAESTRAJSON';

COMMENT ON COLUMN reca_db.cd_tablas_estructura_json.tabla_origen IS
    'Nombre objeto tabla para consultar la inforamcion.';

COMMENT ON COLUMN reca_db.cd_tablas_estructura_json.where_dinamico IS
    'where de rabla principal o join de tabla secundaria.';

COMMENT ON COLUMN reca_db.cd_tablas_estructura_json.tabla_padre IS
    'id tabla padre.';

COMMENT ON COLUMN reca_db.cd_tablas_estructura_json.tipo_tabla IS
    'P principal ,  S subtabla';

ALTER TABLE reca_db.cd_tablas_estructura_json ADD CONSTRAINT bas_tablas_estructura_pk PRIMARY KEY ( id );
ALTER TABLE reca_db.cd_detalle_tabla_json
    ADD CONSTRAINT tabla_detalle_fk1 FOREIGN KEY ( id_tabla )
        REFERENCES reca_db.cd_tablas_estructura_json ( id )
    NOT DEFERRABLE;
ALTER TABLE reca_db.cd_json_generado
    ADD CONSTRAINT cd_js_gen_maesjson_fk1 FOREIGN KEY ( id_maestra_json )
        REFERENCES reca_db.cd_maestra_json ( id )
    NOT DEFERRABLE;
ALTER TABLE reca_db.cd_relacion_tablas_json
    ADD CONSTRAINT cd_rel_tb_fk2 FOREIGN KEY ( id_tabla_estructura )
        REFERENCES reca_db.cd_tablas_estructura_json ( id )
    NOT DEFERRABLE;
ALTER TABLE reca_db.cd_relacion_tablas_json
    ADD CONSTRAINT cd_rel_tb_fk1 FOREIGN KEY ( id_detalle_json_relacion )
        REFERENCES reca_db.cd_detalle_tabla_json ( id )
    NOT DEFERRABLE;
ALTER TABLE reca_db.cd_tablas_estructura_json
    ADD CONSTRAINT cd_jsonm_tablas_fk1 FOREIGN KEY ( id_maestrojson )
        REFERENCES reca_db.cd_maestra_json ( id )
    NOT DEFERRABLE;

-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             0
-- CREATE VIEW                              0
-- ALTER TABLE                             12
-- ALTER INDEX                              0
-- ALTER VIEW                               0
-- DROP TABLE                               0
-- DROP INDEX                               0
-- DROP VIEW                                0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- DROP PACKAGE                             0
-- DROP PACKAGE BODY                        0
-- DROP PROCEDURE                           0
-- DROP FUNCTION                            0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- DROP TRIGGER                             0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- DROP TYPE                                0
-- CREATE SEQUENCE                          0
-- ALTER SEQUENCE                           0
-- DROP SEQUENCE                            0
-- CREATE MATERIALIZED VIEW                 0
-- DROP MATERIALIZED VIEW                   0
-- CREATE SYNONYM                           0
-- DROP SYNONYM                             0
-- CREATE DIMENSION                         0
-- DROP DIMENSION                           0
-- CREATE CONTEXT                           0
-- DROP CONTEXT                             0
-- CREATE DIRECTORY                         0
-- DROP DIRECTORY                           0

-- 
-- ERRORS                                   0
-- WARNINGS                                 1
