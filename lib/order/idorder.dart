import 'package:elhwar/order/order.dart';
import 'package:flutter/material.dart';

class ManagerCodePage extends StatefulWidget {
  const ManagerCodePage({super.key});

  @override
  State<ManagerCodePage> createState() => _ManagerCodePageState();
}

class _ManagerCodePageState extends State<ManagerCodePage> {
  final TextEditingController _codeController = TextEditingController();
  final String managerCode = '2222'; // الكود الثابت

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('كود المدير'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'أدخل الكود للوصول إلى صفحة المدير:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              obscureText: true, // يخفي الرقم أثناء الكتابة
              decoration: InputDecoration(
                hintText: 'أدخل الكود هنا',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_codeController.text.trim() == managerCode) {
                    // الكود صحيح
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 50),
                        pageBuilder: (_, __, ___) => const ManagerOrdersPage(),
                        transitionsBuilder: (_, animation, __, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    );
                  } else {
                    // الكود خطأ
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('❌ الكود غير صحيح'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    _codeController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تأكيد',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
