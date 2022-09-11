select npwp ,mj."NAMA_WP"  , alamat , m.kd_map ,mp."MAP"  , kd_setor ,
extract (day from m.tgl_setor) as tanggalbayar, extract(month from m.tgl_setor)as bulanbayar,
m.tgl_setor ,m.jml_setor,id."KET",
mj."SEKSI" , mj."NAMA_AR" , s."Kategori" 
into laporan.mpn2020_oke
from mpn_2020 m  
left join "ID_SBR_DATA" id 
	on m.dim_sbr_data = id."ID_SBR_DATA" 
left join map_polos mp  
	on m.kd_map  = mp."KD MAP" 
left  join mfwp_juni2022 mj 
 	on m.npwp  = mj."FULL" 
left join klu k  
 	on mj."KODE_KLU"  = k.klu_kode 
 left join  sektor s 
 	on k.klu_sektor = s."Kode" 

 
 	
select *
from laporan.mpn2021 m 
where extract(year from  m.tgl_setor) ='2020' and kppadm ='007'
