-- view PPM_PKM 2021 Existing
create view PPM_PKM_2021 as 
select p.npwp_penyetor ,p.nama_penyetor ,p.kd_map ,p.kd_setor,p.bulan_bayar ,p.jenis_data ,p.jml_setor ,p.ar ,p.seksi,
case 
	when substring(p.kd_map,1,5) in('41131','41111') THEN 'PPM'
	when p.tahun_bayar::int = p.tahun_pajak::int then 'PPM'
	when p.tahun_bayar::int - p.tahun_pajak::int in(0,1) and kd_map in('411125','411126') and p.kd_setor in('200','199','310','320','390','500','501') THEN 'PPM'
	when (p.tahun_bayar::int - p.tahun_pajak::int in(0,1) and p.masa_pajak='12' ) then 'PPM'
	when p.tahun_pajak::int >p.tahun_pajak::int then 'PPM'
	else 'PKM'
	end FLAG_PPM_PKM 
from public.penerimaan_2021 p

--Query Rata2 Triwulan 2021
select  pp.npwp_penyetor  ,pp.nama_penyetor ,mp."MAP" ,pp.ar  ,pp.seksi  ,pp.flag_ppm_pkm ,
round(avg(pp.jml_setor)) as rata_setor2021 
from ppm_pkm_2021 pp 
left join map_polos mp 
	on pp.kd_map  = mp."KD MAP" 
left join appportal.triwulan t 
	on pp.bulan_bayar = t.bulanbayar 
where t.triwulan ='Triwulan 1' and pp.jenis_data !='RESTITUSI'
	and pp.flag_ppm_pkm = 'PPM'
group by pp.npwp_penyetor  ,pp.nama_penyetor ,mp."MAP",pp.ar  ,pp.seksi, pp.flag_ppm_pkm
order by pp.nama_penyetor ,mp."MAP"