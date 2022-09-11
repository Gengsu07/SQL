SELECT nama, kdbayar,masa ,datebayar, nominal, ket,
`FULL`,NAMA_WP, NAMA_AR, SEKSI, `KD MAP`, `MAP`
FROM netto2021
where datebayar between '2021-11-01' and '2021-11-30' 
and masa ='11'
and `KD MAP` in('411211')
and kdbayar like '9%';
