import 'package:flutter/material.dart';  
  
class PaymentScreen extends StatelessWidget {  
  const PaymentScreen({super.key});  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Pembayaran', style: TextStyle(fontFamily: 'DynaPuff')), // DynaPuff font  
      ),  
      body: Center(  
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,  
          children: [  
            const Text(  
              'Silakan unggah bukti pembayaran',  
              style: TextStyle(fontFamily: 'DynaPuff'), // DynaPuff font  
            ),  
            ElevatedButton(  
              onPressed: () {  
                // Implementasi untuk mengunggah bukti pembayaran  
              },  
              child: const Text(  
                'Unggah Bukti Pembayaran',  
                style: TextStyle(fontFamily: 'DynaPuff'), // DynaPuff font  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}  
