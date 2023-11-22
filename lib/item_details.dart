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
