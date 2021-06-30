#### Video Demo Aplikasi
link: https://www.youtube.com/watch?v=sED8zRPXz_w

# Aplikasi Perpustakaan
Aplikasi Perpustakaan adalah aplikasi untuk manajemen perpustakaan yang sasarannya adalah perpustakaan di lingkungan sekolah maupun perpustakaan di lingkungan umum. Di dalam aplikasi ini terdapat dua view, view yang pertama adalah view guest. Di view guest ini pengunjung dapat menjelajahi buku buku yang ada di perpustakaan, pengunjung juga dapat mencari buku yang ingin dicari dengan mengetikan judul, penulis atau penerbit lewat kolom pencarian. Aplikasi ini akan memunculkan daftar buku yang sesuai dengan ingin pengunjung cari. Pengunjung juga dapat mengajukan pinjaman lewat aplikasi ini dengan menekan tombol pinjam dan login dengan menggunakan akun pengunjung yang sudah terdaftar di admin. View yang kedua adalah view admin. Dalam aplikasi ini admin dapat melakukan banyak hal diantaranya mengupdate data buku, memasukan buku dalam katalog, menghapus buku dari katalog, melihat peminjaman, melihat siapa yang telat mengembalikan buku beserta denda yang dikenakan untuk ketelatan mengembalikan buku, mendaftarkan pengunjung menjadi member perpustakaan, melihat, menghapus dan mengupdate data member.

#### Cara Pakai
##### Linux
- untuk ```Ubuntu >= 18.04``` jalankan ```sudo apt install qtbase5-dev qtdeclarative5-dev qtcreator```
- untuk ```Ubuntu <= 16.04 dan Windows``` silahkan download dan installer di ```https://www.qt.io/offline-installers``` dengan versi ```5.9.X```
- jalankan ```python3 -m pip install redis PyQt5 ```
- setting database host, port, dll. berada di ```app/config/db_config.py```
- jalankan ```redis-server```
- jalankan ```python3 app/seed.py```
- jalankan ```python3 app/app.py```
- login dengan akun admin ```username: hadi``` dan ```password: hadi99```


#### Fitur
Admin:
- Melihat, menambahkan, menyunting, membuat buku
- Melihat, menambahkan, menyunting, membuat member
- Pengembalian buku, Melihat siapa yang telat mengembalikan buku beserta dendanya

User:
- Meminjam buku
- Mencari di katalog buku
- Melihat informasi sebuah buku

