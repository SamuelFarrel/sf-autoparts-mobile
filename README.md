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


# Tugas 9
## Pengambilan Data JSON tanpa membuat model
Hal tersebut mungkin saja dan bisa untuk dilakukan dengan menggunakan metode "parsing" dari JSON. Tetapi, membuat model terlebih dahulu menggunakan sebuah Dart class memungkinkan kita untuk mengorganisir data dengan lebih baik, memberikan tipe data yang jelas, dan memudahkan proses pengelolaan data secara umum. Pembuatan model dapat dilewati jika data yang diolah simpel, tetapi jika data banyak dan kompleks disarankan untuk menggunakan model.

## `CookieRequest` pada Flutter
- `CookieRequest` dalam aplikasi Flutter umumnya digunakan untuk manajemen cookie dalam permintaan HTTP. Cookie digunakan untuk menyimpan informasi sesi atau data lain di sisi klien dan dikirim kembali ke server bersama dengan permintaan selanjutnya. Fungsi CookieRequest melibatkan pembuatan, penyimpanan, atau pengelolaan cookie terkait permintaan HTTP.
- Membagikan instance CookieRequest ke semua komponen di aplikasi Flutter bermanfaat karena memastikan konsistensi data sesi, efisiensi dalam manajemen cookie, kemampuan state management untuk berinteraksi dengan perubahan state cookie, dan kemudahan konfigurasi pengaturan khusus.

## Mekanisme pengambilan data JSON hingga ditampilkan pada Flutter
1. Penggunaan http package di Flutter untuk membuat permintaan HTTP ke server
2. Menerima respons dalam format JSON
3. Menguraikan atau "parse" JSON tersebut. 
4. Menggunakan Dart's built-in dart:convert library untuk mengubah string JSON menjadi objek Dart. 
5. Menggunakan objek tersebut untuk membuat antarmuka pengguna aplikasi Flutter.

## Mekanisme autentikasi dari input data akun pada Flutter ke Django
1. Autentikasi dari Flutter ke Django melibatkan permintaan HTTP dari Flutter ke backend Django, biasanya dengan menggunakan protokol seperti OAuth atau JWT (JSON Web Tokens). 
2. Pengguna memasukkan kredensial mereka di aplikasi Flutter, kemudian aplikasi membuat permintaan otentikasi ke Django. 
3. Django memeriksa kredensial, menghasilkan token otentikasi jika valid, dan mengirimkannya kembali ke aplikasi Flutter. 
4. Aplikasi Flutter kemudian dapat menyimpan token ini dan menyertakannya dalam setiap permintaan selanjutnya ke Django untuk memastikan otentikasi.
5. Setelah autentikasi selesai, Django dapat mengembalikan data yang diperlukan untuk menampilkan menu atau konten spesifik pada aplikasi Flutter. Aplikasi Flutter kemudian dapat menggunakan data ini untuk membangun antarmuka pengguna yang sesuai.

## Widget yang digunakan
- `MaterialApp` : Memberikan struktur dan konfigurasi awal untuk aplikasi Flutter.
- `Scaffold` : Menyediakan kerangka tata letak aplikasi dengan komponen seperti AppBar dan Drawer.
- `AppBar` : Menampilkan bar navigasi di bagian atas aplikasi.
- `Drawer` : Menyediakan tampilan samping untuk navigasi aplikasi.
- `FutureBuilder` : Digunakan untuk mengelola state Future dan menangani data asynchronous.
- `ListView` : Menampilkan daftar item dengan kemampuan scrolling.
- `Column` : Menyusun widget secara vertikal.
- `Text` : Menampilkan teks.
- `TextField` : Menyediakan input teks dari pengguna.
- `ElevatedButton` : Membuat tombol dengan tampilan yang lebih tinggi.
- `Padding` : Menambahkan padding pada widget.
- `Center` : Mengatur widget ke tengah layar.
- `SingleChildScrollView` : Memberikan area scrolling untuk konten yang melebihi layar.
- `Future` : Representasi nilai atau kesalahan yang mungkin terjadi di masa depan.

## Cara Implementasi Checklist
1. Memastikan deployment berjalan dengan lancar pada github
2. Membuat halaman login pada tugas proyek Flutter:
  - Membuat file `login.dart` pada folder `lib`
  - Isi file tersebut:
    ```dart
    import 'package:sf_autoparts/menu.dart';
    import 'package:flutter/material.dart';
    import 'package:pbp_django_auth/pbp_django_auth.dart';
    import 'package:provider/provider.dart';

    void main() {
      runApp(const LoginApp());
    }

    class LoginApp extends StatelessWidget {
      const LoginApp({super.key});

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Login',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginPage(),
        );
      }
    }

    class LoginPage extends StatefulWidget {
      const LoginPage({super.key});

      @override
      _LoginPageState createState() => _LoginPageState();
    }

    class _LoginPageState extends State<LoginPage> {
      final TextEditingController _usernameController = TextEditingController();
      final TextEditingController _passwordController = TextEditingController();

      @override
      Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    // Cek kredensial
                    // Untuk menyambungkan Android emulator dengan Django pada localhost,
                    // gunakan URL http://10.0.2.2/
                    final response = await request.login("https://samuel-farrel-tugas.pbp.cs.ui.ac.id/auth/login/", {
                      'username': username,
                      'password': password,
                    });

                    if (request.loggedIn) {
                      String message = response['message'];
                      String uname = response['username'];
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(content: Text("$message Selamat datang, $uname.")));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Login Gagal'),
                          content:
                          Text(response['message']),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      }
    }
    ```

3. Mengintegrasikan sistem autentikasi Django dengan proyek Flutter:
  - Membuat app baru pada Django bernama `authentication`:
    - `views.py` dengan method `login` dan `logout`:
      ```python
      from django.shortcuts import render
      from django.contrib.auth import authenticate, login as auth_login
      from django.http import JsonResponse
      from django.views.decorators.csrf import csrf_exempt
      from django.contrib.auth import logout as auth_logout

      @csrf_exempt
      def login(request):
          username = request.POST['username']
          password = request.POST['password']
          user = authenticate(username=username, password=password)
          if user is not None:
              if user.is_active:
                  auth_login(request, user)
                  # Status login sukses.
                  return JsonResponse({
                      "username": user.username,
                      "status": True,
                      "message": "Login sukses!"
                      # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
                  }, status=200)
              else:
                  return JsonResponse({
                      "status": False,
                      "message": "Login gagal, akun dinonaktifkan."
                  }, status=401)

          else:
              return JsonResponse({
                  "status": False,
                  "message": "Login gagal, periksa kembali email atau kata sandi."
              }, status=401)


      @csrf_exempt
      def logout(request):
          username = request.user.username

          try:
              auth_logout(request)
              return JsonResponse({
                  "username": username,
                  "status": True,
                  "message": "Logout berhasil!"
              }, status=200)
          except:
              return JsonResponse({
              "status": False,
              "message": "Logout gagal."
              }, status=401)
      ```
    - Menambahkan kedua method tersebut pada routing `urls.py`
      ```python
      from django.urls import path
      from authentication.views import login,logout

      app_name = 'authentication'

      urlpatterns = [
          path('login/', login, name='login'),
          path('logout/', logout, name='logout'),
      ]
      ```
    - Menambahkan routing app authentication pada `urls.py` di folder `sf_autoparts`

  - Mengintegrasi sistem autentikasi pada Flutter:
    - Install dua package berikut
      ```
      flutter pub add provider
      flutter pub add pbp_django_auth
      ```
    - Memodifikasi agar root page diarahkan ke `LoginPage()` dan mendukung cookie request (implement login)
      ```dart
      import 'package:flutter/material.dart';
      import 'package:pbp_django_auth/pbp_django_auth.dart';
      import 'package:provider/provider.dart';
      import 'package:sf_autoparts/login.dart';

      void main() {
        runApp(const MyApp());
      }

      class MyApp extends StatelessWidget {
        const MyApp({Key? key}) : super(key: key);

        @override
        Widget build(BuildContext context) {
          return Provider(
            create: (_) {
              CookieRequest request = CookieRequest();
              return request;
            },
            child: MaterialApp(
                title: 'SF Autoparts',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
                  useMaterial3: true,
                ),
                home: LoginPage()
            ),
          );
        }
      }
      ```
    - Modifikasi agar tombol logout berfungsi untuk logout:
      ```dart
      ...

      else if (item.name == "Logout") {
            final response = await request.logout(
                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                "https://samuel-farrel-tugas.pbp.cs.ui.ac.id/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message"),
              ));
            }
          }
        },

      ...
      ```
  
4. Membuat model pada Flutter sesuai dengan app Django :
  - Mengconvert model dari endpoint JSON pada Django ke model Dart class melalui situs Quicktype
  - Membuat file baru pada `lib/models` bernama `item.dart`
  - Paste hasil convert dari Quicktype ke file tersebut
  
5. Membuat halaman daftar semua item yang terdapat pada endpoint JSON aplikasi Django
  - Menambahkan dependensi HTTP pada flutter:
    - Jalankan `flutter pub add http`
    - Tambahkan line berikut pada file `android/app/src/main/AndroidManifest.xml`:
      ```dart
      </application>
      <!-- Required to fetch data from the Internet. -->
      <uses-permission android:name="android.permission.INTERNET" />
      ```
  
  - Membuat halaman produk `show_products.dart` yang menampilkan nama,jumlah,deskripsi dan akan memunculkan detail item jika diclick:
      ```dart
      import 'package:sf_autoparts/widgets/left_drawer.dart';
      import 'package:flutter/material.dart';
      import 'package:http/http.dart' as http;
      import 'dart:convert';
      import 'package:sf_autoparts/models/item.dart';
      import 'package:sf_autoparts/item_details.dart'; // Import your ProductDetailPage

      class ShowItems extends StatefulWidget {
        const ShowItems({Key? key}) : super(key: key);

        @override
        _ItemPageState createState() => _ItemPageState();
      }

      class _ItemPageState extends State<ShowItems> {
        Future<List<Item>> fetchItem() async {
          var url = Uri.parse('http://samuel-farrel-tugas.pbp.cs.ui.ac.id/json/');
          var response = await http.get(
            url,
            headers: {"Content-Type": "application/json"},
          );

          // melakukan decode response menjadi bentuk json
          var data = jsonDecode(utf8.decode(response.bodyBytes));

          // melakukan konversi data json menjadi object Item
          List<Item> list_Item = [];
          for (var d in data) {
            if (d != null) {
              list_Item.add(Item.fromJson(d));
            }
          }
          return list_Item;
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Item'),
            ),
            drawer: const LeftDrawer(),
            body: FutureBuilder(
              future: fetchItem(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text(
                          "Tidak ada data produk.",
                          style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          // Navigate to the item details page when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(item: snapshot.data![index]),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data![index].fields.name}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text("${snapshot.data![index].fields.amount}"),
                              const SizedBox(height: 10),
                              Text(
                                  "${snapshot.data![index].fields.description}")
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          );
        }
      }
      ```

6. Halaman detail item yang menampilkan seluruh attribute dengan tombol kembali:
  - `item_details.dart`:
    ```dart
    import 'package:flutter/material.dart';
    import 'package:sf_autoparts/models/item.dart';

    class ProductDetailPage extends StatelessWidget {
      final Item item;

      const ProductDetailPage({Key? key, required this.item}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Product Detail'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${item.fields.name}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Amount: ${item.fields.amount}'),
                SizedBox(height: 10),
                Text('Description: ${item.fields.description}'),
                SizedBox(height: 10),
                Text('Car: ${item.fields.car}'),
                SizedBox(height: 10),
                Text('Production Date: ${item.fields.productionDate.toLocal()}'),
                SizedBox(height: 10),
                Text('Price: ${item.fields.price}'),
                SizedBox(height: 10),
                Text('User: ${item.fields.user}'),
                // Add other attributes as needed
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
            label: Text(
              'Kembali',
              style: TextStyle(color: Colors.white), // Set label color to white
            ),
            backgroundColor: Colors.blue, // Customize the button color as needed
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      }
    }
    ```