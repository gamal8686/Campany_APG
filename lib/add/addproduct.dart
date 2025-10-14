import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/kTextFormField.dart';
import 'package:elhwar/page/detilsProducts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Addproduct extends StatefulWidget {
  final String categoreid;
  const Addproduct({super.key, required this.categoreid});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController name4 = TextEditingController();
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();
  CollectionReference note = FirebaseFirestore.instance.collection('note');
  addproductes() async {
    if (formkey.currentState!.validate()) {
      try {
        DocumentReference respons = await note.add({
          'montag': name4.text,
          'alaboa': name.text,
          'elsfof': name1.text,
          'fan': name2.text,

          'categoreid': widget.categoreid, // 👈 نربط المنتج بالـ id
          'productId': FirebaseAuth.instance.currentUser!.uid,
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => detilsProducts(categoreid: widget.categoreid),
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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // يشيل الظل لو مش محتاجه
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      detilsProducts(categoreid: widget.categoreid),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
          ),
        ),

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  'ادخل بيانات المنتج الجديد',
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: kText,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                custmTextField(
                  controller: name4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل بيانات المنتج الجديد';
                    }
                    return null;
                  },
                  hint: 'المنتج',
                  leabol: 'المنتج',
                ),
                SizedBox(height: 10),
                custmTextField(
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل بيانات المنتج الجديد';
                    }
                    return null;
                  },
                  hint: 'العبوة',
                  leabol: 'العبوة',
                ),
                SizedBox(height: 10),
                custmTextField(
                  controller: name1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل بيانات المنتج الجديد';
                    }
                    return null;
                  },
                  hint: 'عدد الصفوف',
                  leabol: 'عدد الصفوف',
                ),
                SizedBox(height: 10),
                custmTextField(
                  controller: name2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل بيانات المنتج الجديد';
                    }
                    return null;
                  },
                  hint: 'مكانها',
                  leabol: 'مكانها',
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    addproductes();
                  },
                  child: Text(
                    "إضافة المنتج",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
