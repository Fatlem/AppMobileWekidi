import 'package:flutter/material.dart';  
import 'package:pdf/pdf.dart';  
import 'package:pdf/widgets.dart' as pw;  
import 'package:printing/printing.dart';  
  
class PaymentPage extends StatefulWidget {  
  final double totalPrice;  
  final double shippingCost;  
  
  const PaymentPage({Key? key, required this.totalPrice, required this.shippingCost}) : super(key: key);  
  
  @override  
  State<PaymentPage> createState() => _PaymentPageState();  
}  
  
class _PaymentPageState extends State<PaymentPage> {  
  final TextEditingController _amountController = TextEditingController();  
  double? _totalPayment;  
  
  @override  
  void initState() {  
    super.initState();  
    _totalPayment = widget.totalPrice + widget.shippingCost;  
  }  
  
  Future<void> _generatePdf() async {  
    final pdf = pw.Document();  
  
    pdf.addPage(  
      pw.Page(  
        build: (pw.Context context) {  
          return pw.Center(  
            child: pw.Column(  
              mainAxisAlignment: pw.MainAxisAlignment.center,  
              children: [  
                pw.Text('Nota Pembayaran', style: pw.TextStyle(fontSize: 24)),  
                pw.SizedBox(height: 20),  
                pw.Text('Total Harga: Rp ${widget.totalPrice}'),  
                pw.Text('Ongkir: Rp ${widget.shippingCost}'),  
                pw.Text('Total Pembayaran: Rp $_totalPayment'),  
              ],  
            ),  
          );  
        },  
      ),  
    );  
  
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Pembayaran', style: TextStyle(fontFamily: 'DynaPuff')), // DynaPuff font  
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
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Text('Total Pembayaran: Rp $_totalPayment', style: const TextStyle(fontSize: 20, fontFamily: 'DynaPuff', color: Colors.white)), // DynaPuff font  
            const SizedBox(height: 20),  
            TextField(  
              controller: _amountController,  
              keyboardType: TextInputType.number,  
              decoration: const InputDecoration(  
                labelText: 'Masukkan Total Harga',  
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
            const SizedBox(height: 20),  
            ElevatedButton(  
              onPressed: () {  
                _generatePdf(); // Menghasilkan PDF  
              },  
              child: const Text('Bayar', style: TextStyle(fontFamily: 'DynaPuff')), // DynaPuff font  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}  
