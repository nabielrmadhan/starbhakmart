import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> initialCartItems;

  const CartPage({
    Key? key, 
    this.initialCartItems = const [],
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();
    // Initialize cart items with the items passed from the menu page
    cartItems = List.from(widget.initialCartItems);
  }

  // Calculate total price before tax
  double get subtotal {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Calculate tax (11%)
  double get tax {
    return subtotal * 0.11;
  }

  // Calculate total price including tax
  double get totalPrice {
    return subtotal + tax;
  }

  // Method to remove an item from the cart
  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Method to update item quantity
  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty 
        ? _buildEmptyCartView()
        : _buildCartListView(),
      bottomNavigationBar: cartItems.isNotEmpty 
        ? _buildCheckoutSection() 
        : null,
    );
  }

  Widget _buildEmptyCartView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty-cart.png', // Add an empty cart image
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Looks like you haven\'t added any items yet',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
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
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rp ${item.price}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Decrease Quantity Button
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () => _updateQuantity(index, item.quantity - 1),
                          ),
                          
                          // Quantity
                          Text(
                            '${item.quantity}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          // Increase Quantity Button
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                            onPressed: () => _updateQuantity(index, item.quantity + 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Delete Button
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _removeItem(index),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Order Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal'),
              Text('Rp ${subtotal.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tax (11%)'),
              Text('Rp ${tax.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Rp ${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Checkout Button
          ElevatedButton(
            onPressed: () {
              // Implement checkout logic
              _showCheckoutDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Proceed to Checkout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout Confirmation'),
          content: const Text('Are you sure you want to proceed with the checkout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement actual checkout process
                Navigator.of(context).pop(); // Close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Checkout successful!'),
                    backgroundColor: Colors.green,
                  ),
                );
                
                // Clear cart after successful checkout
                setState(() {
                  cartItems.clear();
                });
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

// CartItem class definition
class CartItem {
  final String name;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}