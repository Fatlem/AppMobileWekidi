import 'package:flutter/material.dart';  
import '../services/api_service.dart';  
  
class HistoryScreen extends StatefulWidget {  
  const HistoryScreen({super.key});  
  
  @override  
  State<HistoryScreen> createState() => _HistoryScreenState();  
}  
  
class _HistoryScreenState extends State<HistoryScreen> {  
  late Future<List<Map<String, dynamic>>> _cartHistory; // Menggunakan peta untuk data keranjang  
  final ApiService _apiService = ApiService();  
  final int userId = 1; // Ganti dengan ID pengguna yang sesuai  
  
  @override  
  void initState() {  
    super.initState();  
    _fetchCartHistory(); // Memanggil fungsi untuk mengambil riwayat belanja  
  }  
  
  Future<void> _fetchCartHistory() async {  
    setState(() {  
      _cartHistory = _apiService.getCurrentCart(userId); // Mengambil riwayat belanja  
    });  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Riwayat Belanja', style: TextStyle(fontFamily: 'DynaPuff')), // DynaPuff font  
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
        child: FutureBuilder<List<Map<String, dynamic>>>(  
          future: _cartHistory,  
          builder: (context, snapshot) {  
            if (snapshot.connectionState == ConnectionState.waiting) {  
              return const Center(child: CircularProgressIndicator());  
            } else if (snapshot.hasError) {  
              return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(fontFamily: 'DynaPuff', color: Colors.white)));  
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {  
              return const Center(child: Text('Tidak ada riwayat belanja', style: TextStyle(fontFamily: 'DynaPuff', color: Colors.white)));  
            } else {  
              return ListView.builder(  
                itemCount: snapshot.data!.length,  
                itemBuilder: (context, index) {  
                  final cartItem = snapshot.data![index];  
                  return Card(  
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),  
                    child: ListTile(  
                      leading: const Icon(Icons.receipt, color: Colors.orange),  
                      title: Text('Pesanan ${cartItem['product_id']}', style: const TextStyle(fontFamily: 'DynaPuff')),  
                      subtitle: Text('Jumlah: ${cartItem['jumlah']}', style: const TextStyle(fontFamily: 'DynaPuff')),  
                      trailing: Text('Rp ${cartItem['total'] ?? 0}', style: const TextStyle(fontFamily: 'DynaPuff')),  
                    ),  
                  );  
                },  
              );  
            }  
          },  
        ),  
      ),  
    );  
  }  
}  
