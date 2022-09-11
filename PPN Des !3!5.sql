SELECT nama, kdbayar,masa ,tahun ,tanggalbayar,bulanbayar,tahunbayar ,datebayar,
nominal, ntpn, bank, nosk, nospm, tipe, source, extra, billing, nop, pembuat,
ket, `FULL`, NPWP, NAMA_WP, NAMA_AR, SEKSI, NAMA_KLU, `KD MAP`, `MAP`
FROM netto2021
where datebayar > '2021-12-15'
and `KD MAP` in('411211','411212','411222')
and kdbayar not like '3%'
and kdbayar not like '5%';
