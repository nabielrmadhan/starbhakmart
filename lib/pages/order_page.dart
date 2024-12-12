import 'package:flutter/material.dart';
import 'package:starbhakmart/pages/add_data_page.dart';
import 'dart:io';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedCategory;
  String? selectedImage;
  List<String> categories = ['Makanan', 'Minuman', 'Snack'];

  // Daftar gambar dari folder assets/images
  final List<String> availableImages = [
    'assets/images/Burger.jpeg',
    'assets/images/teh-botol.jpeg',
    // Tambahkan path gambar lain yang ada di folder assets/images
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddDataPage()),
            );
          },
        ), 
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Produk',
                hintText: 'Masukan nama produk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Harga',
                hintText: 'Masukan Harga',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Kategori produk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedImage,
              items: availableImages.map((String imagePath) {
                return DropdownMenuItem<String>(
                  value: imagePath,
                  child: Row(
                    children: [
                      Image.asset(
                        imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Text(imagePath.split('/').last),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedImage = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pilih Gambar',
                hintText: 'Pilih gambar dari assets',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validasi input
                if (_validateInput()) {
                  // Proses submit
                  _submitForm();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInput() {
    if (nameController.text.isEmpty) {
      _showErrorSnackBar('Nama produk harus diisi');
      return false;
    }
    if (priceController.text.isEmpty) {
      _showErrorSnackBar('Harga harus diisi');
      return false;
    }
    if (selectedCategory == null) {
      _showErrorSnackBar('Kategori harus dipilih');
      return false;
    }
    if (selectedImage == null) {
      _showErrorSnackBar('Gambar harus dipilih');
      return false;
    }
    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _submitForm() {
    // Contoh logika submit - Anda bisa sesuaikan dengan kebutuhan Anda
    print('Nama: ${nameController.text}');
    print('Harga: ${priceController.text}');
    print('Kategori: $selectedCategory');
    print('Gambar: $selectedImage');

    // Tampilkan pesan sukses
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produk berhasil ditambahkan'),
        backgroundColor: Colors.green,
      ),
    );

    // Reset form
    nameController.clear();
    priceController.clear();
    setState(() {
      selectedCategory = null;
      selectedImage = null;
    });
  }
}