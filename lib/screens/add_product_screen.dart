import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import 'package:wekidiapp/utils/product_provider.dart';  
  
class AddProductScreen extends StatelessWidget {  
  final _nameController = TextEditingController();  
  final _descriptionController = TextEditingController();  
  final _priceController = TextEditingController();  
  final _imageUrlController = TextEditingController();  
  
  void _addProduct(BuildContext context) async {  
    final name = _nameController.text.trim();  
    final description = _descriptionController.text.trim();  
    final price = double.tryParse(_priceController.text.trim());  
    final imageUrl = _imageUrlController.text.trim();  
  
    if (name.isEmpty ||  
        description.isEmpty ||  
        price == null ||  
        imageUrl.isEmpty) {  
      ScaffoldMessenger.of(context).showSnackBar(  
        const SnackBar(content: Text('Harap isi semua kolom')),  
      );  
      return;  
    }  
  
    try {  
      await Provider.of<ProductProvider>(context, listen: false)  
          .addProduct(name, description, price, imageUrl);  
      ScaffoldMessenger.of(context).showSnackBar(  
        const SnackBar(content: Text('Produk berhasil ditambahkan')),  
      );  
      Navigator.pop(context); // Kembali ke halaman sebelumnya  
    } catch (e) {  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('Gagal menambahkan produk: $e')),  
      );  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Tambah Produk', style: TextStyle(fontFamily: 'DynaPuff')), // DynaPuff font  
      ),  
      body: Container(  
        decoration: BoxDecoration(  
          gradient: LinearGradient(  
            begin: Alignment.topCenter,  
            end: Alignment.bottomCenter,  
            colors: [  
              Color(0xFFF2A65A), // Light orange for the top  
              Color(0xFFD76D2E), // Deeper orange for the middle  
              Color(0xFF7B3E19), // Brown for the bottom  
            ],  
          ),  
        ),  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.stretch,  
          children: [  
            TextField(  
              controller: _nameController,  
              decoration: const InputDecoration(  
                labelText: 'Nama Produk',  
                labelStyle: TextStyle(color: Colors.white), // White label  
                enabledBorder: UnderlineInputBorder(  
                  borderSide: BorderSide(color: Colors.white), // White underline  
                ),  
                focusedBorder: UnderlineInputBorder(  
                  borderSide: BorderSide(color: Colors.white), // White underline on focus  
                ),  
              ),  
              style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // White text with DynaPuff font  
            ),  
            const SizedBox(height: 16),  
            TextField(  
              controller: _descriptionController,  
              decoration: const InputDecoration(  
                labelText: 'Deskripsi',  
                labelStyle: TextStyle(color: Colors.white), // White label  
                enabledBorder: UnderlineInputBorder(  
                  borderSide: BorderSide(color: Colors.white), // White underline  
                ),  
                focusedBorder: UnderlineInputBorder(  
                  borderSide: BorderSide(color: Colors.white), // White underline on focus  
                ),  
              ),  
              style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // White text with DynaPuff font  
            ),  
            const SizedBox(height: 16),  
            TextField(  
              controller: _priceController,  
              decoration: const InputDecoration(  
                labelText: 'Harga',  
                labelStyle: TextStyle(color: Colors.white), // White label  
                enabledBorder: UnderlineInputBorder(  
                  borderSide: BorderSide(color: Colors.white), // White underline  
                ),  
                focusedBorder: UnderlineInputBorder(  
                  borderSide: BorderSide(color: Colors.white), // White underline on focus  
                ),  
              ),  
              keyboardType: TextInputType.number,  
              style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // White text with DynaPuff font  
            ),  
            const SizedBox(height: 16),  
            TextField(  
              controller: _imageUrlController,  
              decoration: const InputDecoration(  
                labelText: 'URL Gambar',  
                labelStyle: TextStyle(color: Colors.white), // White label  
                enabledBorder: UnderlineInputBorder(  
                  borderSide: BorderSide(color: Colors.white), // White underline  
                ),  
                focusedBorder: UnderlineInputBorder(  
                  borderSide: BorderSide(color: Colors.white), // White underline on focus  
                ),  
              ),  
              style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // White text with DynaPuff font  
            ),  
            const SizedBox(height: 32),  
            ElevatedButton(  
              onPressed: () => _addProduct(context),  
              child: const Text('Tambah Produk', style: TextStyle(fontFamily: 'DynaPuff')), // DynaPuff font  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}  
