import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/page/Products.dart';
import 'package:elhwar/page/detilsProducts.dart';
import 'package:elhwar/updaithome.dart/edithom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // 👈 لازم تضيف المكتبة دي

class CardProducts extends StatelessWidget {
  const CardProducts({
    super.key,
    required this.name,
    required this.id,
    required QueryDocumentSnapshot<Object?> data,
  });
  final String name;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // 👈 كانت 8 خليتها 4
      child: GestureDetector(
        onLongPress: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'حذف ',
            desc: 'اختر ماذا تريد',
            btnCancelText: 'حذف',
            btnOkText: 'تعديل',
            btnCancelOnPress: () async {
              await FirebaseFirestore.instance
                  .collection('productes')
                  .doc(id)
                  .delete();
              print('ok');
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => Products()));
            },
            btnOkOnPress: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      edidhome(docid: id, oldname: name, oldNumber: 'nambrr'),
                ),
              );
            },
          ).show();
        },
        onTap: () {},

        child: Container(
          // color: Colors.black,
          alignment: Alignment.topCenter,
          height: 120, // 👈 كانت 190 قللناها
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0), // 👈 كانت 8 خليتها 4
                child: Container(
                  margin: const EdgeInsets.only(top: 35), // 👈 كانت 30 قللناها
                  height: 90, // 👈 كانت 100 قللناها
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: kbotton,
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
                ),
              ),
              Positioned(
                top: 0, // 👈 يخليها فوق
                left: 10,
                bottom: 20, // 👈 يخليها في الكورنر الشمال
                child: Container(
                  // color: Colors.amber,
                  height: 120,
                  width: 110,
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/download.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 50, // 👈 يطلع الكلام فوق شوية
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ':  Product ',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kText,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        name,
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kmontg,
                          ),
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
    );
  }
}
