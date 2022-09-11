-- Active: 1656903275725@@127.0.0.1@5432@penerimaan@public
--capaian penerimaan perbulan
select p.bulanbayar::text ,  
sum(case when p.ket !='SPMKP' then p.nominal end) as bruto,
sum(case when p.ket ='SPMKP' then p.nominal end) as spmkp,
sum(case when p.ket notnull then p.nominal end) as netto
from ppmpkm2022 p 
group by p.bulanbayar::text 



select mo."BULANBAYAR" ,
sum(case when mo."KET"  !='SPMKP dari SIDJP' then mo.jumlah2021  end) as bruto,
sum(case when mo."KET"  ='SPMKP dari SIDJP' then mo.jumlah2021  end) as spmkp,
sum(case when mo."KET"  notnull then mo.jumlah2021  end) as netto
from laporan.mpn2021_admsetor mo
group by mo."BULANBAYAR" 
order by mo."BULANBAYAR" asc 