import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/kTextFormField.dart';
import 'package:elhwar/page/Products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class edidhome extends StatefulWidget {
  final String docid;
  final String oldname;
  final String oldNumber;
  const edidhome({
    super.key,
    required this.docid,
    required this.oldname,
    required this.oldNumber,
  });

  @override
  State<edidhome> createState() => _edidhomeState();
}

class _edidhomeState extends State<edidhome> {
  TextEditingController name = TextEditingController();
  TextEditingController nambrr = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  CollectionReference productes = FirebaseFirestore.instance.collection(
    'productes',
  );
  editproductes() async {
    if (formkey.currentState!.validate()) {
      try {
        await productes.doc(widget.docid).update({
          'name': name.text,
          'nambrr': nambrr.text,
        });
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Products(),
            transitionDuration: Duration.zero, // بدون أي أنيميشن
            reverseTransitionDuration: Duration.zero, // بدون أنيميشن عند الرجوع
          ),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    name.text = widget.oldname;
    nambrr.text = widget.oldNumber;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kbacgrawenfdh, // ✅ خلفية الصفحة نفس لون الثيم
        appBar: AppBar(
          backgroundColor: kbacgrawenfdh, // ✅ لون الشريط العلوي موحد
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ), // ✅ لون الأيقونة أبيض
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Products(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
          ),
          title: Text(
            'تعديل الصنف',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                'ادخل التعديل الجديد',
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // ✅ النص أبيض
                  ),
                ),
              ),
              const SizedBox(height: 20),
              custmTextField(
                controller: name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ادخل بيانات المنتج الجديد';
                  }
                  return null;
                },
                hint: 'Enter',
                leabol: '',
              ),
              const SizedBox(height: 20),
              custmTextField(
                controller: nambrr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ادخل عدد المنتج الجديد';
                  }
                  return null;
                },
                hint: 'Enter',
                leabol: '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // ✅ الزر أبيض
                  foregroundColor: kbacgrawenfdh, // ✅ النص بنفس لون الثيم
                ),
                onPressed: () async {
                  editproductes();
                },
                child: const Text(
                  "تحديث البيانات",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
