import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/page/sineIn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Admen extends StatefulWidget {
  const Admen({super.key});

  @override
  State<Admen> createState() => _AdmenState();
}

class _AdmenState extends State<Admen> {
  final CollectionReference productsRef = FirebaseFirestore.instance.collection(
    'productes',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbacegGrond,
      appBar: AppBar(
        title: const Text("إدارة الأصناف"),
        backgroundColor: kbotton,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    sinein(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            ); // أو pushReplacement للهوم
          },
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: productsRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              double count = double.tryParse(product['nambrr'] ?? '0') ?? 0;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: kbotton,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // الاسم فوق بكامل عرض الكارت
                        Text(
                          product['name'] ?? '',
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        // Row للعدد والزراير
                        Row(
                          children: [
                            // أزرار النقص على اليسار
                            Column(
                              children: [
                                _buildAdjustButton(-1, product.id, count),
                                _buildAdjustButton(-10, product.id, count),
                                _buildAdjustButton(-100, product.id, count),
                              ],
                            ),
                            const SizedBox(width: 10),
                            // العدد في المنتصف مع تنسيق عشري
                            Expanded(
                              child: Text(
                                formatNumber(count),
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: kText,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // أزرار الزيادة على اليمين
                            Column(
                              children: [
                                _buildAdjustButton(1, product.id, count),
                                _buildAdjustButton(10, product.id, count),
                                _buildAdjustButton(100, product.id, count),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAdjustButton(int delta, String docId, double currentCount) {
    bool isAdd = delta > 0;
    String text = isAdd ? "+$delta" : "$delta";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: 90,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kbotton.withOpacity(0.9),
            foregroundColor: kText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          onPressed: () async {
            double newCount = currentCount + delta;
            if (newCount < 0) newCount = 0;
            await productsRef.doc(docId).update({
              'nambrr': newCount.toString(),
            });
          },
          child: Text(
            text,
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // دالة تنسيق الأعداد العشرية بدون مكتبة
  String formatNumber(double number) {
    String numStr = number.toStringAsFixed(2); // يظهر عشريتين
    List<String> parts = numStr.split('.');
    String integerPart = _formatInteger(parts[0]);
    String decimalPart = parts[1];
    return '$integerPart.$decimalPart';
  }

  String _formatInteger(String numberStr) {
    String result = '';
    int len = numberStr.length;
    int count = 0;

    for (int i = len - 1; i >= 0; i--) {
      result = numberStr[i] + result;
      count++;
      if (count % 3 == 0 && i != 0) {
        result = ',$result';
      }
    }
    return result;
  }
}
