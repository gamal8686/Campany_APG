import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/page/Products.dart';
import 'package:elhwar/page/detilsProducts.dart';
import 'package:elhwar/updaithome.dart/edithom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class detilsProductscard extends StatelessWidget {
  const detilsProductscard({
    super.key,
    required this.montg,
    required this.alaboa,
    required this.elsfof,
    required this.fen,
    required this.productId,
  });
  final String montg;
  final String alaboa;
  final String elsfof;
  final String fen;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        //color: Colors.black,
        alignment: Alignment.topCenter,
        height: 170, // 👈 كانت 190 قللناها
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0), // 👈 كانت 8 خليتها 4
              child: Container(
                margin: const EdgeInsets.only(top: 20), // 👈 كانت 30 قللناها
                height: 150, // 👈 كانت 100 قللناها
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 236, 123),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black, // 👈 لون ظل خفيف
                      offset: const Offset(0, 4), // 👈 اتجاه الظل
                      blurRadius: 8, // 👈 مدى نعومة الظل
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'حذف',
                          desc: 'اختر ماذا تريد',
                          btnCancelText: 'حذف',
                          btnCancelOnPress: () async {
                            // 👇 نفتح دايلوج تأكيد قبل الحذف
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.scale,
                              title: 'تأكيد الحذف',
                              desc: 'هل أنت متأكد أنك تريد حذف هذه الملاحظة؟',
                              btnOkText: 'تأكيد',
                              btnCancelText: 'إلغاء',
                              btnOkOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection('note')
                                    .doc(productId)
                                    .delete();

                                print('✅ تم حذف الملاحظة: $productId');

                                // ترجع للخلف أو تحدث الصفحة
                                Navigator.of(
                                  context,
                                ).pop(); // أو اعمل push لصفحة معينة لو حبيت
                              },
                              btnCancelOnPress: () {
                                print('❌ تم إلغاء الحذف');
                              },
                            ).show();
                          },
                        ).show();
                      },
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end, // 👈 هنا خليه start
                        children: [
                          Directionality(
                            textDirection: TextDirection
                                .rtl, // 👈 يخلي كل الكلام جوه Row يبدأ من اليمين
                            child: Row(
                              children: [
                                Text(
                                  '  زجاجة :',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kmontg,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' $montg    ',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: kText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection
                                .rtl, // 👈 يخلي كل الكلام جوه Row يبدأ من اليمين
                            child: Row(
                              children: [
                                Text(
                                  ' العبوة:',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kmontg,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' $alaboa    ',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: kText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Directionality(
                            textDirection: TextDirection
                                .rtl, // 👈 يخلي كل الكلام جوه Row يبدأ من اليمين
                            child: Row(
                              children: [
                                Text(
                                  ' عدد الصفوف:',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kmontg,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' $elsfof   ',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: kText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection
                                .rtl, // 👈 يخلي كل الكلام جوه Row يبدأ من اليمين
                            child: Row(
                              children: [
                                Text(
                                  ' موجودة في :',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kmontg,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' $fen    ',
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: kText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
