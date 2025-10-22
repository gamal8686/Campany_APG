import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/page/Products.dart';
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
        width: MediaQuery.of(context).size.width, // العرض كامل
        constraints: const BoxConstraints(
          minHeight: 150, // الحد الأدنى للارتفاع
        ),
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
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const Products()),
                        );
                      }
                    },
                    btnCancelOnPress: () {
                      print('❌ تم إلغاء الحذف');
                    },
                  ).show();
                },
              ).show();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 236, 123),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // يتوسع حسب المحتوى
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('زجاجة:', montg),
                  _buildRow('العبوة:', alaboa),
                  _buildRow('عدد الصفوف:', elsfof),
                  _buildRow('موجودة في :', fen),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kmontg,
              ),
            ),
          ),
          Flexible(
            child: Text(
              ' $value',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kText,
                ),
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
