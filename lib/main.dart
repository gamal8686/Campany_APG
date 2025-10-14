import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:elhwar/page/pageCompany.dart';
import 'package:elhwar/page/sineIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase
  await Firebase.initializeApp();

  // تفعيل offline persistence للـ Firestore
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  // التحقق إذا كان المستخدم دخل صفحة company قبل كده
  final prefs = await SharedPreferences.getInstance();
  final bool visitedCompany = prefs.getBool("visitedCompany") ?? false;

  // تشغيل التطبيق
  runApp(MyApp(visitedCompany: visitedCompany));
}

class MyApp extends StatelessWidget {
  final bool visitedCompany;
  const MyApp({super.key, required this.visitedCompany});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: BouncingScrollWrapper.builder(context, widget!),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: _getStartPage(),
    );
  }

  Widget _getStartPage() {
    if (!visitedCompany) {
      // أول مرة → صفحة الشركة
      return const Company();
    } else {
      // مش أول مرة → نشوف حالة اليوزر
      if (FirebaseAuth.instance.currentUser == null) {
        return sinein(); // لو مش مسجل دخول → صفحة تسجيل الدخول
      } else {
        return const HomPage(); // لو مسجل → الهوم
      }
    }
  }
}
