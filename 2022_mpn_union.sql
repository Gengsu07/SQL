select 
	m."NPWP" ,
	m."KPP" ,
	m."CABANG" ,
	m2."NAMA_WP"  ,
	"KDMAP" ,
	"KJS" ,
	"MASA_PAJAK" ,
	"TAHUN_PAJAK" ,
	"TANGGAL_BAYAR" ,
	"BULAN_BAYAR" ,
	"DATEBAYAR",
	"JUMLAH",
	"NOSK" ,
	"NTPN" ,
	"JENIS"  as "JENIS_DATA",
	m2."JENIS_WP" ,
	m2."NAMA_KLU" 
from appportal.mpnspm_2022 m 
left join mfwp m2 on m."NPWP_FULL" = m2."FULL" 
where "TAHUN_BAYAR" = 2022
union all
select 
	p."NPWP" ,
	p."KPP" ,
	p."CABANG" ,
	m2."NAMA_WP"  ,
	"KDMAP" ,
	"KDBAYAR",
	"MASA_PAJAK" ,
	"TAHUN_PAJAK" ,
	extract (day from "TANGGALDOC") as "TANGGAL_BAYAR",
	extract (month from "TANGGALDOC") as "BULAN_BAYAR",
	"TANGGALDOC",
	"NOMINAL"*-1,
	"NO_PROD_HUKUM",
	"NTPN",
	'PBK KIRIM' as "JENIS_DATA",
	m2."JENIS_WP" ,
	m2."NAMA_KLU" 
from appportal.pbk_2022 p 
left join mfwp m2
on p."NPWP" = m2."NPWP" 
and p."KPP" = m2."KPP"
and P."CABANG" = m2."CABANG" 
where "TAHUN" = 2022
union  all 
select 
	p."NPWP2" ,
	p."KPP2" ,
	p."CABANG2" ,
	"NAMA2" ,
	"KDMAP2" ,
	"KDBAYAR2",
	"MASA_PAJAK2" ,
	"TAHUN_PAJAK2" ,
	extract (day from "TANGGALDOC") as "TANGGAL_BAYAR",
	extract (month from "TANGGALDOC") as "BULAN_BAYAR",
	"TANGGALDOC",
	"NOMINAL",
	"NO_PROD_HUKUM",
	"NTPN",
	'PBK TERIMA' as "JENIS_DATA",
	m2."JENIS_WP" ,
	m2."NAMA_KLU" 
from appportal.pbk_2022 p 
left join mfwp m2
on p."NPWP" = m2."NPWP" 
and p."KPP" = m2."KPP"
and P."CABANG" = m2."CABANG" 
where "TAHUN" = 2022
union all 
select 
	s."NPWP" ,
	s."KPP" ,
	s."CABANG" ,
	m2."NAMA_WP",
	"KDMAP" ,
	'',
	null,
	null,
	"HARI",
	"BULAN",
	"DATEBAYAR",
	"NOMINAL"*-1,
	"NO SPMKP",
	'',
	'SPMKP' as "JENIS_DATA",
	m2."JENIS_WP" ,
	m2."NAMA_KLU" 
from appportal.spmkp_2022 s
left join mfwp m2
on s."NPWP" = m2."NPWP" 
and s."KPP" = m2."KPP"
and s."CABANG" = m2."CABANG" 
where s."TAHUN" = 2022