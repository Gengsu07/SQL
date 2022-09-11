drop table if exists tahun2022;
drop table if exists tahun2021;

select 
p."FULL" ,m."NAMA_WP" ,p."MAP" ,p."NAMA_KLU" ,p."Kategori"  ,p.bulanbayar as "BULANBAYAR",
m."NAMA_AR",m."SEKSI"  ,sum(p.nominal) as "JUMLAH2022"  
into tahun2022
from ppmpkm2022 p 
left join mfwp_juni2022 m on p."FULL" = m."FULL"  
where p.ket not in ('SPMKP','PBK KIRIM') 
group by p."FULL",m."NAMA_WP",p."MAP" ,p."NAMA_KLU",p."Kategori",p.bulanbayar,m."NAMA_AR",m."SEKSI";

select 
p."FULL" ,p."NAMA_WP" ,p."MAP" ,p."NAMA_KLU",p."Kategori" ,p."BULANBAYAR"  ,
p."NAMA_AR",p."SEKSI",sum(p.jumlah2021) as "JUMLAH2021"  
into tahun2021
from laporan.mpn2021_oke p 
where p."KET" not in ('SPMKP dari SIDJP','PBK KIRIM SEKANTOR','PBK KIRIM BEDA KANTOR') 
group by p."FULL" ,p."NAMA_WP" ,p."MAP" ,p."NAMA_KLU",p."Kategori" ,p."BULANBAYAR"  ,
p."NAMA_AR",p."SEKSI" ;

--NETTO
drop table if exists tahun2022_netto;
drop table if exists tahun2021_netto;

select 
p."FULL"  ,m."NAMA_WP" ,p."MAP" ,p."NAMA_KLU" ,p."Kategori"  ,p.bulanbayar as "BULANBAYAR",
m."NAMA_AR",m."SEKSI"  ,sum(p.nominal) as "JUMLAH2022"  
into tahun2022_netto
from ppmpkm2022 p 
left join mfwp_juni2022 m on p."FULL" = m."FULL"  
group by p."FULL",m."NAMA_WP",p."MAP" ,p."NAMA_KLU",p."Kategori",p.bulanbayar,m."NAMA_AR",m."SEKSI";


select 
p."FULL" ,p."NAMA_WP" ,p."MAP" ,p."NAMA_KLU",p."Kategori" ,p."BULANBAYAR"  ,
p."NAMA_AR",p."SEKSI",sum(p.jumlah2021) as "JUMLAH2021"  
into tahun2021_netto 
from laporan.mpn2021_oke p 
group by p."FULL" ,p."NAMA_WP" ,p."MAP" ,p."NAMA_KLU",p."Kategori" ,p."BULANBAYAR"  ,
p."NAMA_AR",p."SEKSI" ;



drop table if exists laporan.explor;

select m."FULL" ,m."NAMA_WP" ,m."MAP" , 
m.kdbayar ,m.datebayar ,m.ket ,m."Kategori" ,
m."NAMA_AR" ,m."SEKSI" ,m.tahun::text ,m.bulan ,m.ntpn,sum(m.jumlah) as jumlah  
into laporan.explor 
from laporan.mpn2020_2022 m 
group by m."FULL" ,m."NAMA_WP" ,m."MAP" , m.kdbayar ,m.datebayar ,m.ket ,
m."Kategori" ,m."NAMA_AR" ,m."SEKSI",m.tahun::text, m.bulan ,m.ntpn
order by m."NAMA_WP" asc;