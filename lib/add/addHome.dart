import 'package:elhwar/custem/kTextFormField.dart';
import 'package:elhwar/page/Products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddHome extends StatefulWidget {
  const AddHome({super.key});

  @override
  State<AddHome> createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {
  final TextEditingController name = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final CollectionReference productes = FirebaseFirestore.instance.collection(
    'productes',
  );

  Future<void> addProductes() async {
    if (formkey.currentState!.validate()) {
      try {
        await productes.add({
          'name': name.text,
          'id': FirebaseAuth.instance.currentUser!.uid,
        });

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Products(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFBDBDBD),
        appBar: AppBar(
          title: const Text('إضافة صنف جديد'),
          backgroundColor: Colors.grey[800],
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Products(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'إضافة صنف جديد',
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                custmTextField(
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك أدخل اسم الصنف الجديد';
                    }
                    return null;
                  },
                  hint: 'اسم الصنف',
                  leabol: 'الاسم',
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: addProductes,
                  child: const Text(
                    "إضافة الصنف",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
