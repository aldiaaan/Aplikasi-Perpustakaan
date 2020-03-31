terdapat tiga model yaitu:

1. Member

   - \_id (string)
   - nama (string)
   - alamat (string)
   - foto_profil (string)
   - username (string)
   - password (string)
   - role (string)

2. Buku

   - \_id (string)
   - judul (string)
   - ISBN (string)
   - halaman (string)
   - genre (string)
   - cover (string)
   - deskripsi (string)
   - author (string)
   - penerbit (string)
   - stok (string)
   - lokasi (string)

3. Peminjaman
   - \_id (string)
   - id_buku (string)
   - id_member (string)
   - nama_member (string)
   - judul_buku (string)
   - tanggal_peminjaman (date)
   - tanggal_pengembalian (date)
