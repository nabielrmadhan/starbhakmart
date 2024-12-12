import 'package:flutter/material.dart';
import 'package:starbhakmart/pages/menu_page.dart';
import 'package:starbhakmart/pages/order_page.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  // Daftar produk yang dapat diedit
  List<Map<String, dynamic>> _products = [
    {
      'image': 'assets/images/Burger.jpeg',
      'name': 'Burger King Medium',
      'price': 'Rp.50.000,00',
      'category': 'Makanan'
    },
    {
      'image': 'assets/images/teh-botol.jpeg',
      'name': 'Teh Botol',
      'price': 'Rp.4.000,00',
      'category': 'Minuman'
    },
  ];

  // Method untuk menghapus produk
  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  // Method untuk menambah produk
  void _addProduct(String name, String price, String image, String category) {
    setState(() {
      _products.add({
        'image': image,
        'name': name,
        'price': price,
        'category': category
      });
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
                  MaterialPageRoute(
                    builder: (context) => ProductForm(
                      onAddProduct: _addProduct,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Add Data +'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(60),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(100),
                    3: FixedColumnWidth(50),
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
                            child: Image.asset(_products[i]['image'], width: 50, height: 50),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}