
create or replace  view VI_CD_RMINFOFINANCIERA AS 

SELECT DISTINCT
f.matricula,
f.camara,
F.ANO||'12'||'31' fechadatos,
F.ANO anodatos,
NULL personal,
NULL personaltempporc,
NULL actvin,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 0) actcte,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 55)actnocte,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 4) acttot,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 4) pascte,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 6) pasnocte,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 7) pastot,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 8) patnet,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 9) paspat,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 56) balsoc,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 39)ingope,
NULL ingnoope,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 11) cosven,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 13) gasope,
NULL gasnoope,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 57) gasimp,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 20) utiope,
F_INF_FINANCIERA(f.matricula, f.camara, f.ano, 28)utinet,
NULL gruponiif,
NULL pornalpub,
NULL pornalpri,
NULL porextpub,
NULL porextpri,
NULL facultades
FROM INFORM_FINANCIERA_INSCRITOS f
WHERE ANO> extract(year from sysdate) -6
ORDER BY ANO;
