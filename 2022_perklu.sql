select  t."FULL" ,m."NAMA_WP" ,s."Kategori" ,sum(t.jumlah2021) 
from tahun2021 t
left join mfwp m using("FULL")
left join klu k  on m."KODE_KLU" = k.klu_kode 
left join sektor s  on k.klu_sektor = s."Kode" 
where t.bulanbayar =3
group by  t."FULL" ,m."NAMA_WP" ,s."Kategori"


select  t."FULL" ,m."NAMA_WP" ,s."Kategori" ,sum(t.jumlah2022) 
from tahun2022 t
left join mfwp m using("FULL")
left join klu k  on m."KODE_KLU" = k.klu_kode 
left join sektor s  on k.klu_sektor = s."Kode" 
where t.bulanbayar =3
group by  t."FULL" ,m."NAMA_WP" ,s."Kategori"

select *
from mfwp m 
where m."FULL" ilike '024483059%'

select t."FULL" , m."NAMA_WP" ,t."MAP",m."NAMA_AR" ,m."SEKSI" ,t.bulanbayar::text , sum(t.jumlah2022)  as "2022"
from tahun2022 t 
left join mfwp m using("FULL")
where t.bulanbayar <5
group by  t."FULL" ,m."NAMA_WP",t."MAP" ,m."NAMA_AR" ,m."SEKSI",t.bulanbayar::text