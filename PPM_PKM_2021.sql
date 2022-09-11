SELECT A.NPWP,
       A.KPP,
       A.CABANG,
       A.NAMA,
       A.KDMAP,
       A.KDBAYAR,
       MASA,
       A.TAHUN,
       TAHUNBAYAR,
       BULANBAYAR,
       DATEBAYAR,
       nosk,
       NOMINAL,
       CASE
         WHEN SUBSTRING(A.KDMAP,1,5) IN ('41131','41111') THEN 'PPM'
         WHEN TAHUNBAYAR = A.TAHUN THEN 'PPM'
         WHEN TAHUNBAYAR - A.TAHUN IN (0,1) AND A.KDMAP IN ('411125','411126') AND A.KDBAYAR IN ('200','199','310','320','390','500','501') THEN 'PPM'
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
FROM MPN A
  LEFT JOIN WP B
         ON A.NPWP = B.NPWP
        AND A.KPP = B.KPP
        AND A.CABANG = B.CABANG
  LEFT JOIN PEGAWAI C ON B.NIPPJ = C.NIP
  LEFT JOIN SEKSI D ON C.SEKSI = D.ID
  LEFT JOIN MAP E
         ON A.KDMAP = E.KDMAP
        AND A.KDBAYAR = E.KDBAYAR
  LEFT JOIN KLU F ON B.KLU = F.KODE
WHERE TAHUNBAYAR = 2021;