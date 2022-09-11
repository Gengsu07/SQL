select sum(p.jml_setor) as setor2021
from penerimaan_2021 p 
left join mfwp m  
	on p.npwp_penyetor  = m."FULL" 
left join map_polos mp 
	on p.kd_map  = mp."KD MAP" 
where p.bulan_bayar  =2  and  p.jenis_data !='RESTITUSI'
	and p.kd_map in('411125','411126','411121','411211') and p.kd_setor  in('100')
	
	
	
select sum(m."JUMLAH") as setor2022 
from appportal.mpnspm_2022 m
left join map_polos mp
	on m."KDMAP"  = mp."KD MAP" 
left join mfwp m2 
	on m."NPWP_FULL"  = m2."FULL" 
where m."BULAN_BAYAR" =2 	
	and m."KDMAP" in('411125','411126','411121','411211') and m."KJS" in('100')
	


--2022 PPh 25, PPh21, PPn DN kode bayar 100 bulan 2
select m."NPWP_FULL"  ,m2."NAMA_WP" ,mp."MAP" , m."KDMAP" ,m."KJS" ,m2."NAMA_AR" ,m2."SEKSI" , sum(m."JUMLAH") as setor2022 
from appportal.mpnspm_2022 m
left join map_polos mp
	on m."KDMAP"  = mp."KD MAP" 
left join mfwp m2 
	on m."NPWP_FULL"  = m2."FULL" 
where m."BULAN_BAYAR" =2 	
	and m."KDMAP" in('411125','411126','411121','411211') and m."KJS" in('100')
group by m."NPWP_FULL"  ,m2."NAMA_WP" ,mp."MAP", m."KDMAP" ,m."KJS",m2."NAMA_AR" ,m2."SEKSI" 
	

--2021 PPh 25, PPh21, PPn DN kode bayar 100 bulan 2
select distinct  p.npwp_penyetor  ,m."NAMA_WP" ,mp."MAP" ,p.kd_map ,p.kd_setor ,m."NAMA_AR" ,m."SEKSI" ,
round(avg(p.jml_setor)) as rata_setor2021 
from penerimaan_2021 p 
left join mfwp m  
	on p.npwp_penyetor  = m."FULL" 
left join map_polos mp 
	on p.kd_map  = mp."KD MAP" 
left join appportal.triwulan t 
	on p.bulan_bayar = t.bulanbayar 
where   triwulan ='Triwulan 1' and p.jenis_data !='RESTITUSI'
	and p.kd_map in('411125','411126','411121','411211') and p.kd_setor  in('100')
group by p.npwp_penyetor,m."NAMA_WP" ,mp."MAP" ,p.kd_map ,p.kd_setor,m."NAMA_AR" ,m."SEKSI",t.triwulan  
	
	
