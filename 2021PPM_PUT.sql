select
	a.npwp_penyetor as "NPWP",
	d."NAMA_WP" as "NAMA_WP",
	a.ar as "AR",
	a.seksi as "SEKSI",
	a.kd_map as "KDMAP",
	a.kd_setor as "KDBAYAR",
	a.masa_pjk ,
	a.masa_pajak as "MASA",
	a.tahun_pajak as "TAHUN_PAJAK",
	a.no_sk,
	a.tgl_setor as "TGL_BAYAR",
	a.bulan_bayar as "BULAN_BAYAR",
	a.tahun_bayar as "TAHUN_BAYAR",
	a.jml_setor as "JUMLAH",
	a.jenis_data as "JENIS",
	b."URAIAN",
	c."MAP",
	case 
		when substring(a.kd_map,1,5) in('41131','41111') then 'PPM'
		when a.tahun_bayar = a.tahun_pajak  then 'PPM'
		when a.tahun_bayar::int - a.tahun_pajak::int in(0,1) and a.kd_map in('411125','411126') and a.kd_setor in('200','199','310','320','390','500','501') THEN 'PPM'
		when (a.tahun_bayar::int - a.tahun_pajak::int in(0,1) and a.masa_pajak ='12') then  'PPM'
		when a.tahun_pajak::int > a.tahun_bayar::int then 'PPM'
		else 'PKM'
	end PPM_PKM,
	case 
		when a.kd_setor in('900','910','920','930') then 'PEMUNGUT'
		else 'NON PEMUNGUT'
	end PUT
from public.penerimaan_2021 a
inner join mfwp d 
	on a.npwp_penyetor = d."FULL" 
left join "map" b 
	on (a.kd_map=b."KDMAP" and a.kd_setor=b."KDBAYAR")
left join map_polos c 
	on a.kd_map =c."KD MAP"
where 
jenis_data in('MPN','SPM');
