import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/add/addproduct.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/detailsProduct%20card.dart';
import 'package:elhwar/custem/employditelscard.dart';
import 'package:elhwar/page/Products.dart';
import 'package:elhwar/page/empalyprodected.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Employdetilsprodect extends StatefulWidget {
  final String categoreid;
  const Employdetilsprodect({super.key, required this.categoreid});

  @override
  State<Employdetilsprodect> createState() => _detilsProductsState();
}

class _detilsProductsState extends State<Employdetilsprodect> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                                  const Empalyprodected(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
            SizedBox(height: 50),

            // ✅ هنا التغيير: StreamBuilder بدل ListView المباشر
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('note')
                    .where('categoreid', isEqualTo: widget.categoreid)
                    .snapshots(), // 👈 Real-time updates
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
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

                      return Employditelscard(
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
    );
  }
}
