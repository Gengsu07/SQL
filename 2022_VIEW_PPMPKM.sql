--VIEW PPM PKM 2022
create view PPM_PKM_2022 as 
select m."NPWP_FULL",m2."NAMA_WP" ,mp."MAP"  ,m."KDMAP"  ,m."KJS" ,m."BULAN_BAYAR" ,m."JENIS" ,m."JUMLAH"  ,m2."NAMA_AR" ,m2."SEKSI" ,
case 
	when substring(m."KDMAP",1,5) in('41131','41111') THEN 'PPM'
	when m."TAHUN_BAYAR"  = m."TAHUN_PAJAK"  then 'PPM'
	when m."TAHUN_BAYAR" - m."TAHUN_PAJAK" in(0,1) and m."KDMAP" in('411125','411126') and m."KJS"  in('200','199','310','320','390','500','501') THEN 'PPM'
	when (m."TAHUN_BAYAR" - m."TAHUN_PAJAK" in(0,1) and m."TAHUN_PAJAK"=12 ) then 'PPM'
	when m."TAHUN_BAYAR" >m."TAHUN_PAJAK" then 'PPM'
	else 'PKM'
	end FLAG_PPM_PKM
from appportal.mpnspm_2022 m 
left join mfwp m2 
	on m."NPWP_FULL"  = m2."FULL" 
left join map_polos mp 
	on m."KDMAP"  = mp."KD MAP"  
	
	
select pp."NPWP_FULL" , pp."NAMA_WP" ,pp."MAP" ,pp."NAMA_AR" ,pp."SEKSI" ,sum(pp."JUMLAH") as "2022_Januari" 
from ppm_pkm_2022 pp 
where pp."BULAN_BAYAR" =1
group by pp."NPWP_FULL" , pp."NAMA_WP" ,pp."MAP" ,pp."NAMA_AR" ,pp."SEKSI"