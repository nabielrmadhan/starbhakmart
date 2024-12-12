import 'package:flutter/material.dart';
import 'package:starbhakmart/pages/cart_page.dart';
import 'package:starbhakmart/pages/add_data_page.dart';
import 'package:starbhakmart/theme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Daftar produk 
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Burger King Medium',
      'price': 50000,
      'image': 'assets/images/Burger.jpeg',
      'category': 'Makanan'
    },
    {
      'name': 'Teh Botol',
      'price': 4000,
      'image': 'assets/images/teh-botol.jpeg',
      'category': 'Minuman'
    },
    {
      'name': 'Burger King Small',
      'price': 35000,
      'image': 'assets/images/Burger.jpeg',
      'category': 'Makanan'
    },
  ];

  // Variabel untuk filter kategori
  String selectedCategory = 'All';
  List<String> categories = ['All', 'Makanan', 'Minuman'];

  // Method untuk filter produk
  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'All') return products;
    return products.where((product) => product['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: _buildAppBarIcon(Icons.menu, () {}),
        actions: [
          _buildAppBarIcon(Icons.person_outline, () {}),
        ],
      ),
      body: Column(
        children: [
          // Kategori Filter
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories.map((category) => 
                _buildCategoryItem(
                  _getCategoryIcon(category), 
                  category, 
                  selectedCategory == category
                )
              ).toList(),
            ),
          ),
          
          // Judul Kategori
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '$selectedCategory Food',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Grid Produk
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                var product = filteredProducts[index];
                return _buildFoodItem(
                  context,
                  product['name'],
                  'Rp. ${product['price']},00',
                  product['image'],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: birubg),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell( 
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()), 
                );
              },
              child: Stack(
                children: [
                  const Icon(Icons.shopping_cart),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: InkWell( 
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddDataPage()), 
                );
              },
              child: const Icon(Icons.list_alt),
            ),
            label: 'Add',
          ),
        ],
      ),
    );
  }

  // Metode utility untuk mendapatkan icon berdasarkan kategori
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Makanan': return Icons.lunch_dining;
      case 'Minuman': return Icons.local_drink;
      default: return Icons.restaurant_menu;
    }
  }

  // Widget untuk item makanan
  Widget _buildFoodItem(BuildContext context, String name, String price, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Buat objek CartItem
                          CartItem newItem = CartItem(
                            name: name,
                            price: double.parse(price.replaceAll(RegExp(r'[^0-9]'), '')),
                            quantity: 1,
                            image: imageUrl,
                          );

                          // Navigasi ke CartPage dengan membawa item baru
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(
                                initialCartItems: [newItem],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
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
    );
  }

  // Widget untuk icon app bar
  Widget _buildAppBarIcon(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 20),
        onPressed: onPressed,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
      ),
    );
  }

  // Widget untuk item kategori
  Widget _buildCategoryItem(IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? birubg : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? birubg : Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

