import 'package:flutter/material.dart';  
  
class SplashScreen extends StatefulWidget {  
  const SplashScreen({super.key});  
  
  @override  
  State<SplashScreen> createState() => _SplashScreenState();  
}  
  
class _SplashScreenState extends State<SplashScreen> {  
  @override  
  void initState() {  
    super.initState();  
    // Menunda navigasi selama 5 detik  
    Future.delayed(const Duration(seconds: 5), () {  
      // Memastikan widget masih aktif sebelum melakukan navigasi  
      if (mounted) {  
        Navigator.pushReplacementNamed(context, '/login');  
      }  
    });  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
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
        child: Center(  
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [  
              // Mengganti Icon dengan Image  
              Image.asset(  
                'assets/images/Wekidi.png', // Gambar dari assets  
                width: 350, // Sesuaikan ukuran gambar  
                height: 350,  
              ),  
              SizedBox(height: 20),  
              Text(  
                'Welcome To Wekidiくん',  
                textAlign: TextAlign.center,  
                style: TextStyle(  
                  fontSize: 28,  
                  color: Colors.white,  
                  fontWeight: FontWeight.bold,  
                  fontFamily: 'DynaPuff', // Menggunakan font DynaPuff  
                ),  
              ),  
              SizedBox(height: 10),  
              Text(  
                'Mau Mencari Produk Berkualits dan Terjangkau? Cuma Ada Di Wekidiくん Tempatnya.',  
                textAlign: TextAlign.center,  
                style: TextStyle(  
                  fontSize: 16,  
                  color: Colors.white70,  
                  fontFamily: 'DynaPuff', // Menggunakan font DynaPuff  
                ),  
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}  
