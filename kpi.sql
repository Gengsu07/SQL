--penerimaan per Jenis Penerimaan
select 
sum(case when p.ket ='MPN'then p.nominal end) as mpn,
sum(case when p.ket ='SPM'then p.nominal end) as pbk,
sum(case when p.ket ='PBK TERIMA'then p.nominal end) as pbk_terima,
sum(case when p.ket ='PBK KIRIM'then p.nominal end) as pbk_kirim,
sum(case when p.ket ='SPMKP'then p.nominal end) as SPMKP,
sum(p.nominal) as netto
from ppmpkm2022 p 

--Jenis PPM PKM
select 
sum(case when p."JENIS_PPM_PKM" ='RUTIN' then p.nominal end) as rutin,
sum(case when p."JENIS_PPM_PKM" ='PENGAWASAN' then p.nominal end) as pengawasan,
sum(case when p."JENIS_PPM_PKM" ='PENAGIHAN' then p.nominal end) as penagihan,
sum(case when p."JENIS_PPM_PKM" ='PEMERIKSAAN' then p.nominal end) as pemeriksaan
from ppmpkm2022 p 

