CREATE VIEW penerimaan 
AS
(
  SELECT admin,
  npwp,
  kpp,
  cabang,
  nama,
  kdmap,
  kdbayar,
  masa,
  masa2,
  tahun,
  tanggalbayar,
  bulanbayar,
  tahunbayar,
  datebayar,
  nominal,
  ntpn,
  bank,
  nosk,
  nospm,
  tipe,
  source,
  extra,
  billing,
  nop,
  pembuat,
  CASE WHEN SOURCE = 1 THEN 'MPN' ELSE 'SPM' END AS ket FROM MPN 
  UNION ALL 
  SELECT admin,
  npwp,
  kpp,
  cabang,
  '',
  kdmap,
  '',
  '',
  '',
  '',
  DAY(tanggal) AS TANGGALBAYAR,
  BULAN,
  TAHUN,
  tanggal,
  NOMINAL*-1,
  '',
  '',
  '',
  '',
  '',
  3 AS SOURCE,
  '',
  '',
  '',
  '',
  'SPMKP' AS 'keterangan' FROM spmkp 
  UNION ALL 
  SELECT A.admin,
  A.npwp,
  A.kpp,
  A.cabang,
  A.nama,
  kdmap,
  kdbayar,
  masapajak,
  masapajak,
  tahunpajak,
  DAY(TANGGALDOC) AS TANGGALBAYAR,
  MONTH(TANGGALDOC) BULAN,
  YEAR(TANGGALDOC) TAHUN,
  TANGGALDOC,
  NOMINAL*-1,
  ntpn,
  '',
  nopbk,
  '',
  '',
  4 AS SOURCE,
  '',
  '',
  '',
  '',
  'PBK KIRIM' AS keterangan FROM PBK A WHERE admin = kpp_admin AND kpp_admin = admin 
  UNION ALL 
  SELECT A.ADMIN,
  npwp2,
  kpp2,
  cabang2,
  nama2,
  kdmap2,
  kdbayar2,
  masapajak2,
  masapajak2,
  tahunpajak2,
  DAY(TANGGALDOC) AS TANGGALBAYAR,
  MONTH(TANGGALDOC) BULAN,
  YEAR(TANGGALDOC) TAHUN,
  TANGGALDOC,
  NOMINAL,
  ntpn,
  '',
  nopbk,
  '',
  '',
  5 AS SOURCE,
  '',
  '',
  '',
  '',
  'PBK TERIMA' AS keterangan FROM PBK A WHERE admin = kpp_admin2 AND kpp_admin2 = admin
)


SELECT KET,
       A.NPWP,
       A.KPP,
       A.CABANG,
       A.NAMA,
       A.KDMAP,
       A.KDBAYAR,
       MASA,
       MASA2,
       A.TAHUN,
       TAHUNBAYAR,
       BULANBAYAR,
       DATEBAYAR,
       NOMINAL,
       NTPN,
       NOSK,
       CASE
         WHEN A.KDMAP = '411128' AND A.KDBAYAR IN ('427','428') THEN 'PPS'
         WHEN A.KDMAP = '411128' AND A.KDBAYAR = '422' THEN 'PKM'
         WHEN KET IN ('SPMKP','PBK KIRIM','PBK TERIMA') THEN 'PPM'
         WHEN TAHUNBAYAR - A.TAHUN IN (0,1) AND A.KDMAP IN ('411125','411126','411111','411112') AND A.KDBAYAR IN ('200','199','310','320','390','500','501') THEN 'PPM'
         WHEN TAHUNBAYAR - A.TAHUN IN (0,1) AND A.KDMAP IN ('411125','411126','411111','411112') AND A.KDBAYAR = '300' AND MASA = 1 AND MASA2 = 12 THEN 'PPM'
         WHEN NOSK IS NOT NULL AND NOSK <> '-' AND NOSK <> '' AND NOSK NOT LIKE '%PBK%' AND NOSK <> 'TIDAK DIKETAHUI' AND MOD (TAHUNBAYAR,100) - CAST(RIGHT(NOSK,2) AS INT) > 0 THEN 'PKM'
         WHEN TAHUNBAYAR = A.TAHUN THEN 'PPM'
         WHEN (TAHUNBAYAR - A.TAHUN IN (0,1) AND MASA = 12) THEN 'PPM'
         WHEN A.TAHUN > TAHUNBAYAR THEN 'PPM'
         ELSE 'PKM'
       END FLAG_PPM_PKM,
       NIPPJ,
       C.NAMA AS NAMA_AR,
       D.NAMA AS NAMA_SEKSI,
       E.SEKTOR,
       URAIAN,
       F.NAMA AS NAMA_KLU,
       F.SEKTOR AS SEKTOR_KLU
FROM PENERIMAAN A
  LEFT JOIN WP B
         ON A.NPWP = B.NPWP
        AND A.KPP = B.KPP
        AND A.CABANG = B.CABANG
  LEFT JOIN PEGAWAI C
         ON B.NIPPJ = C.NIP
        AND C.TAHUN = 2021
  LEFT JOIN SEKSI D ON C.SEKSI = D.ID
  LEFT JOIN MAP E
         ON A.KDMAP = E.KDMAP
        AND A.KDBAYAR = E.KDBAYAR
  LEFT JOIN KLU F ON B.KLU = F.KODE
WHERE TAHUNBAYAR = 2022