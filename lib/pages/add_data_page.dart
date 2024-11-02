import 'package:flutter/material.dart';
import 'package:starbhakmart/pages/menu_page.dart';

import 'order_page.dart';

void main() {
  runApp(AddDataPage());
}

class AddDataPage extends StatelessWidget {
  const AddDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Map<String, dynamic>> _products = [
    {
      'image': 'assets/images/Burger.jpeg',
      'name': 'Burger King Medium',
      'price': 'Rp.50.000,00',
    },
    {
      'image': 'assets/images/teh-botol.jpeg',
      'name': 'Teh Botol',
      'price': 'Rp.4.000,00',
    },
    {
      'image': 'assets/images/Burger.jpeg',
      'name': 'Burger King Small',
      'price': 'Rp.35.000,00',
    },
  ];

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MenuPage()),
    );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderPage()),
    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text('Add Data +'),
            ),
            const SizedBox(height: 16),
            Table(
              columnWidths: const {
                0: const FixedColumnWidth(60),
                1: const FlexColumnWidth(),
                2: const FixedColumnWidth(100),
                3: const FixedColumnWidth(50),
              },
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey.shade300),
              ),
              children: [
                const TableRow(
                  children: [
                    Text('Foto', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Nama Produk', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Harga', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                for (int i = 0; i < _products.length; i++)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(_products[i]['image'], width: 50, height: 50),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_products[i]['name']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_products[i]['price']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(i),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
