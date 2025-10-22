import 'package:elhwar/page/hompage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elhwar/page/sineIn.dart';
import 'package:elhwar/const/const.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({super.key});

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  void login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // لو تسجيل الدخول صح، روح على صفحة sinein
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => sinein(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'حدث خطأ، حاول مرة أخرى';
      if (e.code == 'user-not-found') message = 'المستخدم غير موجود';
      if (e.code == 'wrong-password') message = 'كلمة المرور غير صحيحة';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbotton,
        foregroundColor: kText,
        title: const Text(' خروج'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
        ),
      ),

      backgroundColor: kbacegGrond,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 60),
                Text(
                  'تسجيل الدخول',
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: kText,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // الايميل
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'من فضلك أدخل البريد الإلكتروني';
                    }
                    if (!val.contains('@')) {
                      return 'أدخل بريد إلكتروني صالح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // الباسورد
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'كلمة المرور',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'من فضلك أدخل كلمة المرور';
                    }
                    if (val.length < 6) {
                      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                // زر الدخول
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kbotton,
                      foregroundColor: kText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: loading ? null : login,
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'دخول',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
