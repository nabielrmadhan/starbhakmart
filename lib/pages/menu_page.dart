import 'package:flutter/material.dart';
import 'package:starbhakmart/pages/cart_page.dart';
import 'package:starbhakmart/pages/add_data_page.dart';
import 'package:starbhakmart/theme.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: _buildAppBarIcon(
          Icons.menu,
          () {},
        ),
        leadingWidth: 56,
        actions: [
          _buildAppBarIcon(
            Icons.person_outline,
            () {},
          ),
          const SizedBox(width: 2), 
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryItem(Icons.lunch_dining, 'All', true),
                _buildCategoryItem(Icons.lunch_dining, 'Makanan', false),
                _buildCategoryItem(Icons.local_drink, 'Minuman', false),
              ],
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All Food',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
  child: GridView.builder(
    padding: const EdgeInsets.all(16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    ),
    itemCount: 8,
    itemBuilder: (context, index) {
      return _buildFoodItem(
        context,
        index < 3 
          ? 'Burger King Medium'
          : 'Teh Botol',
        index < 3 
          ? 'Rp. 50.000,00'
          : 'Rp. 4.000,00',
        index < 3 
          ? 'assets/images/Burger.jpeg'
          : 'assets/images/teh-botol.jpeg',
      );
    },
  ),
),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: birubg,),
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
    child: const Stack(
      children: [
        Icon(Icons.list_alt),
      ],
    ),
  ),
             label: 'Add'
          ),
        ],
      ),
    );
  }


  Widget _buildAppBarIcon(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),  // Shadow color
        //     spreadRadius: 2,  // How far the shadow spreads
        //     blurRadius: 8,   // How blurry the shadow is
        //     offset: const Offset(0, 2),  // Shadow position
        //   ),
        // ],
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

  Widget _buildCategoryItem(IconData icon, String label, bool isSelected) {
    return Column(
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
    );
  }

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
                          price: int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')), // Hapus karakter non-angka
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
}