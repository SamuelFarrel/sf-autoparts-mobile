# SF Autoparts (Mobile) | Samuel Farrel | 2206826614

# Tugas 7

## Perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter
- Stateless Widget :
    - Tidak dapat berubah setelah dibuat (widget yang tidak perlu update data)
    - Ketika data yang dimiliki widget berubah, kita perlu membuat widget baru karena stateless widget tidak memiliki state yang dapat kita ubah
    - Tampilan statis dan komponen yang hanya bergantung pada input yang diberikan saat widget dibuat (contohnya teks, tombol, gambar)

- Stateful Widget :
    - Memiliki state yang dapat dirubah selama aplikasi berjalan
    - Ketika data yang dimiliki widget berubah, kita dapat merubah/memperbaruinya melalui state yang dimiliki oleh widget
    - Memiliki 2 class terkait yaitu `StatefulWidget` yang merupakan widget itu sendiri dan `State` yang menyimpan data yang nantinya juga bisa diubah
    - Contohnya form dan scrollable untuk menampilkan konten

## Widget yang digunakan dalam tugas dan fungsinya masing-masing
- `MyHomepage (StatelessWidget)` sebagai widget utama untuk mengantur layout dan struktur tampilan home page
- `Scaffold` memberikan struktur basic dari aplikasi, termasuk app bar dan body dari page
- `AppBar` untuk app bar pada bagian atas aplikasi dengan text dan background color
- `SingleChildScrollView` agar content dapat discroll jika melebihi ukuran layar
- `Padding` untuk apply padding
- `Collumn` mengatur konten secara vertikal
- `Text` menampilkan tulisan pada aplikasi
- `GridView.count` membuat layout grid dengan jumlah collumn tertentu, pada aplikasi ini sebanyak 3 karena terdapat 3 card
- `ShopCard (StatelessWidget)` sebagai widget untuk tiap card pada grid, memiliki text, icon, dan warnanya sendiri (bonus)
- `Material` mengatur tampilan dan action dari card
- `Inkwell` untuk membuat card responsive terhadap action sentuhan dan mengatur responnya
- `Container` untuk menyimpan dan mengatur posisi widget `Text` dan `Icon` pada card

## Cara implementasi checklist
1. Membuat program Flutter baru dengan tema inventory
- Inisiasi awal :
    - Menjalankan perintah `flutter create sf_autoparts` pada direktori yang ingin digunakan sebagai folder project/program
    - Masuk ke root folder program dan jalankan `git init` untuk membuatnya sebagai folder git
    - Menyambungkan folder dengan repository dengan perintah `git remode add origin`

- Mengatur struktur project :
    - Menambahkan file `menu.dart` pada folder `lib`
    - Memindahkan class `MyHomePage` dan `_MyHomePageState` dari `main.dart` ke `menu.dart`
    - Import `menu.dart` ke `main.dart` untuk mengimport `MyHomePage` yang sudah dipindah
        ```dart
        import 'package:flutter/material.dart';
        ```
    - Mengubah `home` pada `main.dart` agar dapat menampilkan widget dengan tepat saat memulai aplikasi
        ```dart
        ...
        home: MyHomePage(),
        ...
        ```

- Mengubah widget menu page menjadi stateless :
    - Menghapus state `MyHomePage` dari `menu.dart` yaitu `_MyHomePageState`
    - Merubah widget `MyHomePage` menjadi stateless dengan merubah kode menjadi berikut
        ```dart
        class MyHomePage extends StatelessWidget {
            MyHomePage({Key? key}) : super(key: key);

            // This widget is the home page of your application. It is stateful, meaning
            // that it has a State object (defined below) that contains fields that affect
            // how it looks.

            // This class is the configuration for the state. It holds the values (in this
            // case the title) provided by the parent (in this case the App widget) and
            // used by the build method of the State. Fields in a Widget subclass are
            // always marked "final".


            @override
            Widget build(BuildContext context) {
                return Scaffold(
                    .....
                )
            }
        }
        ```

2. Membuat tiga tombol sederhana dengan ikon dan teks
- Inisiasi dan pembuatan class baru :
    - Membuat class `ButtonItem` untuk button pada homepage dengan attribute nama, icon, dan warna (bonus)
        ```dart
        class ButtonItem {
        final String name;
        final IconData icon;
        final Color color;

        ButtonItem(this.name, this.icon,this.color);
        }
        ```
    - Membuat class `ButtonCard` untuk mengatur tampilan dan action dari button
        ```dart
        class ButtonCard extends StatelessWidget {
        final ButtonItem item;

        const ButtonCard(this.item, {super.key}); // Constructor

        @override
        Widget build(BuildContext context) {
            return Material(
            color: item.color,
            child: InkWell(
                // Area responsive terhadap sentuhan
                onTap: () {
                // Memunculkan SnackBar ketika diklik
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("Kamu telah menekan tombol ${item.name}!")));
                },
                child: Container(
                // Container untuk menyimpan Icon dan Text
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                        item.icon,
                        color: Colors.white,
                        size: 30.0,
                        ),
                        const Padding(padding: EdgeInsets.all(3)),
                        Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                        ),
                    ],
                    ),
                ),
                ),
            ),
            );
        }
        }
        ```
- Menampilkan ketiga tombol pada home page
    - Membuat list `items` berisi `ButtonItem` pada class `MyHomePage`
        ```dart
        final List<ButtonItem> items = [
            ButtonItem("Lihat Item", Icons.list,Colors.lightBlueAccent),
            ButtonItem("Tambah Item", Icons.add_shopping_cart,Colors.lightBlue),
            ButtonItem("Logout", Icons.logout,Colors.blueAccent),
        ];
        ```
    - Menambahkan kode berikut pada bagian `padding` di widget `build`
        ```dart
        GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ButtonItem item) {
                  // Iterasi untuk setiap item
                  return ButtonCard(item);
                }).toList(),
              ),
        ```
3. Memunculkan Snackbar untuk action tombol
- Telah dilakukan dengan menambahkan `onTap()` di `InkWell` pada `ButtonCard`
    ```dart
    child: InkWell(
                // Area responsive terhadap sentuhan
                onTap: () {
                // Memunculkan SnackBar ketika diklik
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content: Text("Kamu telah menekan tombol ${item.name}!")));
                },
    ```


# Tugas 8

## Perbedaan antara Navigator.push() dan Navigator.pushReplacement()
- `Navigator.push()`:
    - Digunakan untuk routing halaman baru dengan menambahkan route halaman baru dalam stack navigation, sehingga user dapat kembali ke halaman sebelumnya dengan tombol back.
    - Contoh:
        ```dart
        Navigator.push(context, 
            MaterialPageRoute(builder: (context) => NextScreen()));
        ```
- `Navigator.pushReplacement()`:
    - Digunakan untuk routing halaman baru dengan dengan mereplace halaman dimana user berada dengan halaman baru pada stack navigation, sehingga user tidak dapat kembali ke halaman sebelumnya.
    - Contoh:
        ```dart
        Navigator.pushReplacement(context, 
            MaterialPageRoute(builder: (context) => NextScreen()));
        ```

## Layout Widget pada Flutter dan Konteks Penggunaannya
- `Container` : Digunakan untuk mengelompokkan widget lain dan mengatur terhadap layout attribute seperti margin dan padding.
- `Column` : Digunakan untuk menampilkan widget dalam susunan vertikal.
- `Row` : Digunakan untuk menampilkan widget dalam susunan horizontal.
- `ListView` : Digunakan untuk menampilkan daftar elemen scrollable.
- `Stack` : Digunakan untuk "menumpuk" widget satu di atas yang lain.

## Elemen Input pada Form pada Tugas
- Pada tugas ini, karena semua input yang diperlukan adalah berupa teks dalam bentuk string dan integer, maka saya menggunakan `TextField` yang diwrap oleh `FormField` atau `FormField` yang contains `TextField`  yaitu `TextFormField`
- `TextField` digunakan untuk input teks (contoh: nama, email, alamat, dll)

## Penerapan Clean Architecture pada Flutter
Clean Architecture pada aplikasi Flutter terdiri dari tiga lapisan utama (separation of concerns):

- Domain Layer:
    - Logika bisnis dan aturan aplikasi.
    - Model dan use case yang independen dari framework atau teknologi.

- Data Layer:
    - Implementasi akses data eksternal.
    - Terdiri dari repository yang mengimplementasikan interface dari domain layer.

- Feature Layer:
    - Menangani logika UI dan interaksi pengguna.
    - Menggunakan widget Flutter untuk membangun antarmuka pengguna.

Prinsip Dependency Rule diikuti, dengan domain layer sebagai pusat yang tidak bergantung pada lapisan lain. Struktur direpresentasikan melalui paket atau modul terpisah.

## Cara Implementasi Checklist
1. Membuat halaman baru formulir untuk menambah item
- Membuat file baru pada folder `lib` bernama `form.dart`
- Memakai tiga elemen input :
    - `TextFormField` untuk input field `name` dengan validasi agar tidak kosong :
        ```dart
        ....
          child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nama Item",
                  labelText: "Nama Item",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _name = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
        ....
        ```
    - `TextFormField` untuk input field `amount` dengan validasi apakah input berupa angka (integer) dan tidak kosong :
        ```dart
        ....

          child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Jumlah",
                  labelText: "Jumlah",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _amount = int.parse(value!);
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Jumlah tidak boleh kosong!";
                  }
                  if (int.tryParse(value) == null) {
                    return "Jumlah harus berupa angka!";
                  }
                  return null;
                },
              ),

        ....
        ```
    - `TextFormField` untuk input field `description` dengan validasi agar tidak kosong :
        ```dart
        ....

          child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Deskripsi",
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _description = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  return null;
                },
              ),

        ....
        ```

- Memiliki tombol save yang akan menyimpan item ke list (bonus) dan menampilkan popup detail item :
    ```dart
    ....

      child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Item berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: $_name'),
                                  Text('Jumlah: $_amount'),
                                  Text('Deskripsi: $_description'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                  Item.itemList.add(Item(_name, _amount, _description));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    _formKey.currentState!.reset();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

    ....
    ```
2. Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol `Tambah Item` pada halaman utama :
- Menambahkan kode berikut pada bagian `onTap()` milik class `ButtonCard` :
    ```dart
    if (item.name == "Tambah Item"){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FormPage()));}
    ```

3. Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman formulir tambah item baru.
    ```dart
    ...

    onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Item berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: $_name'),
                                  Text('Jumlah: $_amount'),
                                  Text('Deskripsi: $_description'),
                                ],
                              ),
                            ),

    ...

    ```

4. Membuat drawer pada aplikasi
- Membuat file `left_drawer.dart` pada direktori baru `lib/widgets` :
    - Drawer memiliki tiga buah opsi yaitu `Main Page`, `Tambah Item`, dan `Daftar Item`
        ```dart
        ...

          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Main Page'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_sharp),
            title: const Text('Daftar Item'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowItems(itemList: Item.itemList),
                  )
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_task),
            title: const Text('Add Item'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormPage(),
                  )
              );
            },
          ),
        
        ...
        ```
    - Pada tiap bagian, jika diklik maka user akan diarahkan ke page sesuai bagian tersebut