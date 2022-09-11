drop table if exists laporan.mpn2021_oke cascade ;
drop table if exists laporan.mpn2020_oke cascade ;

select m.npwp as "FULL", mj."NAMA_WP" , mp."MAP",m.kd_setor  as kdbayar ,mj."NAMA_KLU" , s."Kategori" ,
extract(month from m.tgl_setor) as "BULANBAYAR", m.tgl_setor ,mj."NAMA_AR" , mj."SEKSI" ,dsd."KET" ,m.ntpn , sum(m.jml_setor) as Jumlah2021
into laporan.mpn2021_oke 
from mpn_2021 m
left join mfwp_juni2022 mj on m.npwp = mj."FULL" 
left join map_polos mp on m.kd_map = mp."KD MAP" 
left join klu k on mj."KODE_KLU" = k.klu_kode 
left join sektor s on k.klu_sektor  =s."Kode" 
left join dim_sbr_data dsd on m.dim_sbr_data =dsd."ID_SBR_DATA" 
group by m.npwp, mj."NAMA_WP" , mp."MAP",m.kd_setor ,mj."NAMA_KLU" , s."Kategori" ,
extract(month from m.tgl_setor),m.tgl_setor , mj."NAMA_AR" , mj."SEKSI" ,dsd."KET",m.ntpn ;

select m.npwp as "FULL", mj."NAMA_WP" , mp."MAP",m.kd_setor as kdbayar ,mj."NAMA_KLU" , s."Kategori" ,
extract(month from m.tgl_setor) as "BULANBAYAR",m.tgl_setor  ,mj."NAMA_AR" , mj."SEKSI" ,dsd."KET" ,m.ntpn , sum(m.jml_setor) as Jumlah2020
into laporan.mpn2020_oke
from mpn_2020 m
left join mfwp_juni2022 mj on m.npwp = mj."FULL" 
left join map_polos mp on m.kd_map = mp."KD MAP" 
left join klu k on mj."KODE_KLU" = k.klu_kode 
left join sektor s on k.klu_sektor  =s."Kode" 
left join dim_sbr_data dsd on m.dim_sbr_data =dsd."ID_SBR_DATA" 
group by m.npwp, mj."NAMA_WP" , mp."MAP",m.kd_setor ,mj."NAMA_KLU" , s."Kategori" ,
extract(month from m.tgl_setor),m.tgl_setor , mj."NAMA_AR" , mj."SEKSI" ,dsd."KET",m.ntpn  ;