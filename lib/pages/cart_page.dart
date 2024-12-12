import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> initialCartItems;

  const CartPage({
    super.key, 
    this.initialCartItems = const [],
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize cart items with the items passed from the menu page
    cartItems = List.from(widget.initialCartItems);
  }

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.black, size: 18),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child: cartItems.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined, 
                        size: 100, 
                        color: Colors.grey[300]
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rp ${item.price}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              _buildQuantityButton(
                                icon: Icons.remove,
                                onPressed: () {
                                  if (item.quantity > 1) {
                                    setState(() {
                                      item.quantity--;
                                    });
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  item.quantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              _buildQuantityButton(
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    item.quantity++;
                                  });
                                },
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cartItems.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
          ),

          // Cart Summary and Checkout
          if (cartItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan Belanja',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('PPN 11%'),
                        Text(
                          'Rp ${(totalPrice * 0.11).round()}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total belanja'),
                        Text(
                          'Rp ${totalPrice.round()}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Rp ${(totalPrice * 1.11).round()}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff3748E4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement checkout logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Checkout berhasil!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3748E4),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
        padding: const EdgeInsets.all(4),
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final int price;
  int quantity;
  final String image;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}