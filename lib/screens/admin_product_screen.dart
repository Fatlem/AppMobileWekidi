import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import 'package:wekidiapp/services/api_service.dart';  
import 'package:wekidiapp/models/product.dart';  
import 'package:wekidiapp/utils/product_provider.dart';  
import 'edit_product_screen.dart'; // Import halaman edit produk  
import 'add_product_screen.dart'; // Import halaman tambah produk  
  
class AdminProductScreen extends StatefulWidget {  
  const AdminProductScreen({super.key});  
  
  @override  
  State<AdminProductScreen> createState() => _AdminProductScreenState();  
}  
  
class _AdminProductScreenState extends State<AdminProductScreen> {  
  late Future<List<Product>> _products;  
  
  @override  
  void initState() {  
    super.initState();  
    _fetchProducts();  
  }  
  
  Future<void> _fetchProducts() async {  
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();  
  }  
  
  Future<void> _deleteProduct(int productId) async {  
    try {  
      await Provider.of<ProductProvider>(context, listen: false)  
          .deleteProduct(productId);  
      ScaffoldMessenger.of(context).showSnackBar(  
        const SnackBar(content: Text('Produk berhasil dihapus')),  
      );  
      _fetchProducts(); // Refresh the product list  
    } catch (e) {  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('Gagal menghapus produk: $e')),  
      );  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Admin Produk', style: TextStyle(color: Colors.black, fontFamily: 'DynaPuff')), // DynaPuff font  
        backgroundColor: Colors.white, // Ubah latar belakang AppBar menjadi putih  
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
        child: Consumer<ProductProvider>(  
          builder: (context, productProvider, child) {  
            final products = productProvider.products;  
            if (products.isEmpty) {  
              return const Center(child: CircularProgressIndicator());  
            } else {  
              return ListView.builder(  
                itemCount: products.length,  
                itemBuilder: (context, index) {  
                  final product = products[index];  
                  return ListTile(  
                    title: Text(product.name, style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff')), // Ubah warna teks menjadi putih  
                    subtitle: Text('\$${product.price}', style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff')), // Ubah warna teks menjadi putih  
                    trailing: Row(  
                      mainAxisSize: MainAxisSize.min,  
                      children: [  
                        IconButton(  
                          icon: const Icon(Icons.edit, color: Colors.white), // Ubah warna ikon menjadi putih  
                          onPressed: () {  
                            Navigator.push(  
                              context,  
                              MaterialPageRoute(  
                                builder: (context) =>  
                                    EditProductScreen(product: product),  
                              ),  
                            ).then((_) => _fetchProducts()); // Refresh after editing  
                          },  
                        ),  
                        IconButton(  
                          icon: const Icon(Icons.delete, color: Colors.white), // Ubah warna ikon menjadi putih  
                          onPressed: () {  
                            _deleteProduct(product.id);  
                          },  
                        ),  
                      ],  
                    ),  
                  );  
                },  
              );  
            }  
          },  
        ),  
      ),  
      floatingActionButton: FloatingActionButton(  
        onPressed: () {  
          Navigator.push(  
            context,  
            MaterialPageRoute(  
              builder: (context) => AddProductScreen(), // Navigasi ke halaman tambah produk  
            ),  
          ).then((_) => _fetchProducts()); // Refresh after adding  
        },  
        child: const Icon(Icons.add),  
        backgroundColor: const Color(0xFFD76D2E), // Warna latar belakang FloatingActionButton  
      ),  
    );  
  }  
}  
