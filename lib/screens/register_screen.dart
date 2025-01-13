import 'package:flutter/material.dart';  
import 'package:shared_preferences/shared_preferences.dart';  
import '../services/api_service.dart';  
import '../utils/navigation_utils.dart';  
  
class RegisterScreen extends StatefulWidget {  
  const RegisterScreen({super.key});  
  
  @override  
  State<RegisterScreen> createState() => _RegisterScreenState();  
}  
  
class _RegisterScreenState extends State<RegisterScreen> {  
  final _nameController = TextEditingController();  
  final _usernameController = TextEditingController();  
  final _passwordController = TextEditingController();  
  final _roleController = TextEditingController(); // Menambahkan controller untuk role  
  final ApiService _apiService = ApiService();  
  
  void _register() async {  
    final user = _nameController.text.trim();  
    final username = _usernameController.text.trim();  
    final password = _passwordController.text.trim();  
    final role = _roleController.text.trim(); // Mengambil role  
  
    if (user.isEmpty || username.isEmpty || password.isEmpty || role.isEmpty) {  
      ScaffoldMessenger.of(context).showSnackBar(  
        const SnackBar(content: Text('Harap isi semua kolom')),  
      );  
      return;  
    }  
  
    try {  
      print('Mencoba mendaftar dengan: $user, $username, $role');  
      final success = await _apiService.registerUser(user, username, password, role); // Mengirim name, username, password, dan role  
      if (success) {  
        // Simpan hanya user ke SharedPreferences  
        final prefs = await SharedPreferences.getInstance();  
        await prefs.setString('user', user); // Simpan nama lengkap pengguna  
  
        ScaffoldMessenger.of(context).showSnackBar(  
          const SnackBar(content: Text('Registrasi berhasil')),  
        );  
        navigateTo(context, '/login'); // Redirect ke halaman login  
      }  
    } catch (e) {  
      print('Error saat registrasi: $e'); // Log error  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('Gagal registrasi: $e')),  
      );  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: const Text('Register', style: TextStyle(fontFamily: 'DynaPuff'))), // DynaPuff font  
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
        child: Center( // Center the content  
          child: Padding(  
            padding: const EdgeInsets.all(16.0),  
            child: Column(  
              mainAxisSize: MainAxisSize.min, // Minimize the height of the column  
              crossAxisAlignment: CrossAxisAlignment.stretch,  
              children: [  
                CircleAvatar(  
                  radius: 40,  
                  backgroundColor: Colors.white,  
                  child: const Icon(Icons.person_add, size: 40, color: Colors.orange), // Ikon di atas  
                ),  
                const SizedBox(height: 20),  
                TextField(  
                  controller: _nameController,  
                  decoration: const InputDecoration(  
                    labelText: 'Name',  
                    labelStyle: TextStyle(color: Colors.white), // White label  
                    prefixIcon: Icon(Icons.person, color: Colors.white), // Ikon untuk nama  
                    enabledBorder: UnderlineInputBorder(  
                      borderSide: BorderSide(color: Colors.white), // White underline  
                    ),  
                    focusedBorder: UnderlineInputBorder(  
                      borderSide: BorderSide(color: Colors.white), // White underline on focus  
                    ),  
                  ),  
                  style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // DynaPuff font  
                ),  
                const SizedBox(height: 16),  
                TextField(  
                  controller: _usernameController,  
                  decoration: const InputDecoration(  
                    labelText: 'Username',  
                    labelStyle: TextStyle(color: Colors.white), // White label  
                    prefixIcon: Icon(Icons.person_outline, color: Colors.white), // Ikon untuk username  
                    enabledBorder: UnderlineInputBorder(  
                      borderSide: BorderSide(color: Colors.white), // White underline  
                    ),  
                    focusedBorder: UnderlineInputBorder(  
                      borderSide: BorderSide(color: Colors.white), // White underline on focus  
                    ),  
                  ),  
                  style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // DynaPuff font  
                ),  
                const SizedBox(height: 16),  
                TextField(  
                  controller: _passwordController,  
                  decoration: const InputDecoration(  
                    labelText: 'Password',  
                    labelStyle: TextStyle(color: Colors.white), // White label  
                    prefixIcon: Icon(Icons.lock, color: Colors.white), // Ikon untuk password  
                    enabledBorder: UnderlineInputBorder(  
                      borderSide: BorderSide(color: Colors.white), // White underline  
                    ),  
                    focusedBorder: UnderlineInputBorder(  
                      borderSide: BorderSide(color: Colors.white), // White underline on focus  
                    ),  
                  ),  
                  obscureText: true,  
                  style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // DynaPuff font  
                ),  
                const SizedBox(height: 16),  
                TextField(  
                  controller: _roleController, // Input untuk role  
                  decoration: const InputDecoration(  
                    labelText: 'Role (e.g., admin/user)',  
                    labelStyle: TextStyle(color: Colors.white), // White label  
                    prefixIcon: Icon(Icons.group, color: Colors.white), // Ikon untuk role  
                    enabledBorder: UnderlineInputBorder(  
                      borderSide: BorderSide(color: Colors.white), // White underline  
                    ),  
                    focusedBorder: UnderlineInputBorder(  
                      borderSide: BorderSide(color: Colors.white), // White underline on focus  
                    ),  
                  ),  
                  style: const TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // DynaPuff font  
                ),  
                const SizedBox(height: 32),  
                ElevatedButton(  
                  onPressed: _register,  
                  child: const Text('Register', style: TextStyle(fontFamily: 'DynaPuff')), // DynaPuff font  
                ),  
                const SizedBox(height: 16),  
                // Prompt to log in if already have an account  
                TextButton(  
                  onPressed: () {  
                    navigateTo(context, '/login'); // Navigate to login screen  
                  },  
                  child: const Text(  
                    'Sudah punya akun? Silakan login di sini',  
                    style: TextStyle(color: Colors.white, fontFamily: 'DynaPuff'), // DynaPuff font  
                  ),  
                ),  
              ],  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
}  
