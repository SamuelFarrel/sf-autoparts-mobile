import 'package:flutter/material.dart';
import 'package:sf_autoparts/form.dart';
import 'package:sf_autoparts/widgets/left_drawer.dart';
import 'package:sf_autoparts/show_products.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<ButtonItem> items = [
    ButtonItem("Lihat Item", Icons.list,Colors.lightBlueAccent),
    ButtonItem("Tambah Item", Icons.add_shopping_cart,Colors.lightBlue),
    ButtonItem("Logout", Icons.logout,Colors.blueAccent),
  ];

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
      appBar: AppBar(
        title: const Text(
          'SF Autoparts',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Welcome to SF Autoparts', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
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
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonItem {
  final String name;
  final IconData icon;
  final Color color;

  ButtonItem(this.name, this.icon,this.color);
}

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
          if (item.name == "Tambah Item") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FormPage()));
          }
          else if(item.name == "Lihat Item"){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShowItems(itemList: Item.itemList)));
          }
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