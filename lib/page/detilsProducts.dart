import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/add/addproduct.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/detailsProduct%20card.dart';
import 'package:elhwar/page/Products.dart';
import 'package:elhwar/page/empalyprodected.dart';

class detilsProducts extends StatefulWidget {
  final String categoreid;
  const detilsProducts({super.key, required this.categoreid});

  @override
  State<detilsProducts> createState() => _detilsProductsState();
}

class _detilsProductsState extends State<detilsProducts> {
  @override
  void initState() {
    super.initState();
    // تفعيل الـ offline persistence
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // الرجوع للصفحة السابقة
        Navigator.of(context).pop();
        return false; // false لمنع الرجوع التلقائي
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Addproduct(categoreid: widget.categoreid),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            backgroundColor: Colors.brown,
            child: Text('Add', style: TextStyle(color: kText, fontSize: 20)),
          ),
          backgroundColor: kbotton,
          body: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const Products(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'مكان المنتج ',
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kText,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    ' x  : عدد البلتات ',
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kText,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('note')
                      .where('categoreid', isEqualTo: widget.categoreid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "❌ خطأ في الاتصال بالانترنت",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      );
                    }
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final docs = snapshot.data!.docs;

                    if (docs.isEmpty) {
                      return const Center(child: Text("📭 لا يوجد منتجات"));
                    }

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;

                        return detilsProductscard(
                          montg: data['montag']?.toString() ?? '',
                          alaboa: data['alaboa']?.toString() ?? '',
                          elsfof: data['elsfof']?.toString() ?? '',
                          fen: data['fan']?.toString() ?? '',
                          productId: docs[index].id,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
