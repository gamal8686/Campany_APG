import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/add/addHome.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/CardProducts.dart';
import 'package:elhwar/page/detilsProducts.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:elhwar/updaithome.dart/edithom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<QueryDocumentSnapshot> data = [];
  getdata() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('productes')
        .get();
    data.addAll(querySnapshot.docs);
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // لما يضغط زر الرجوع على الجهاز، يرجع للـ HomPage
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => HomPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        return false; // false لمنع الرجوع الافتراضي
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      AddHome(),
                  transitionDuration: Duration.zero, // 👈 بدون أنيميشن نهائيًا
                  reverseTransitionDuration:
                      Duration.zero, // 👈 عند الرجوع برضو
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 159, 113, 96),
            child: Text('Add', style: TextStyle(color: kText, fontSize: 20)),
          ),
          backgroundColor: kbotton,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: const Color.fromARGB(255, 242, 238, 238),
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    HomPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },

                      // ← ترجع للصفحة السابقة
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text(
                'الانتاج التام بالكامل',
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kText,
                  ),
                ),
              ),

              SizedBox(
                height: 50,

                child: Center(
                  child: Text(
                    ' x  :عدد الاصناف',
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
                child: data.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.brown, // تختار اللون اللي يعجبك
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: InkWell(
                              onLongPress: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'حذف',
                                  desc: 'اختر ماذا تريد',
                                  btnCancelText: 'حذف',
                                  btnOkText: 'تعديل',
                                  btnCancelOnPress: () async {
                                    // 👇 نفتح دايلوج تأكيد قبل الحذف
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.question,
                                      animType: AnimType.scale,
                                      title: 'تأكيد الحذف',
                                      desc:
                                          'هل أنت متأكد أنك تريد حذف هذا المنتج؟',
                                      btnCancelText: 'إلغاء',
                                      btnOkText: 'تأكيد',
                                      btnOkOnPress: () async {
                                        await FirebaseFirestore.instance
                                            .collection('productes')
                                            .doc(data[index].id)
                                            .delete();
                                        print('تم الحذف ✅');

                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder:
                                                (
                                                  context,
                                                  animation,
                                                  secondaryAnimation,
                                                ) => Products(),
                                            transitionDuration: Duration.zero,
                                            reverseTransitionDuration:
                                                Duration.zero,
                                          ),
                                        );
                                      },
                                      btnCancelOnPress: () {},
                                    ).show();
                                  },
                                  btnOkOnPress: () {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                            ) => edidhome(
                                              docid: data[index].id,
                                              oldname: data[index]['name'],
                                            ),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                  },
                                ).show();
                              },
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  //color: Colors.black,
                                  alignment: Alignment.topCenter,
                                  height: 200, // 👈 كانت 190 قللناها
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                          4.0,
                                        ), // 👈 كانت 8 خليتها 4
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            top: 20,
                                          ), // 👈 كانت 30 قللناها
                                          height: 200, // 👈 كانت 100 قللناها
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                              255,
                                              172,
                                              141,
                                              89,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors
                                                    .black, // 👈 لون ظل خفيف
                                                offset: const Offset(
                                                  0,
                                                  4,
                                                ), // 👈 اتجاه الظل
                                                blurRadius:
                                                    8, // 👈 مدى نعومة الظل
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 20, // 👈 المسافة من فوق
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 170,
                                                  // color: Colors.black
                                                ),
                                              ),
                                              Positioned(
                                                left: 10,

                                                bottom: 0,

                                                child: Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(
                                                        context,
                                                      ).push(
                                                        PageRouteBuilder(
                                                          pageBuilder:
                                                              (
                                                                context,
                                                                animation,
                                                                secondaryAnimation,
                                                              ) => detilsProducts(
                                                                categoreid:
                                                                    data[index]
                                                                        .id,
                                                              ),
                                                          transitionDuration:
                                                              Duration.zero,
                                                          reverseTransitionDuration:
                                                              Duration.zero,
                                                        ),
                                                      );
                                                    },
                                                    child: CircleAvatar(
                                                      maxRadius: 30,
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                            255,
                                                            241,
                                                            236,
                                                            123,
                                                          ),
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0, // 👈 المسافة من فوق
                                                left: 0,
                                                right: 180,

                                                child: Center(
                                                  child: CircleAvatar(
                                                    maxRadius: 50,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                          255,
                                                          241,
                                                          236,
                                                          123,
                                                        ),
                                                    child: Image.asset(
                                                      'assets/images/download.png',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 50, // 👈 المسافة من فوق
                                                left: 190,
                                                right: 10,
                                                child: SizedBox(
                                                  child: Center(
                                                    child: Text(
                                                      ': Product ',
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      softWrap:
                                                          true, // 👈 يخلي النص يكسر سطر
                                                      maxLines:
                                                          2, // 👈 أقصى عدد سطور
                                                      overflow: TextOverflow
                                                          .ellipsis, // 👈 يحط "..." لو زاد
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 110,
                                                left: 120,
                                                right: 10,
                                                child: Container(
                                                  width: 150,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    data[index]['name'],
                                                    style: const TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // child: Container(
                              //   alignment: Alignment.topCenter,
                              //   height: 120,
                              //   child: Stack(
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.all(4.0),
                              //         child: Container(
                              //           margin: const EdgeInsets.only(top: 35),
                              //           height: 90,
                              //           width: MediaQuery.of(context).size.width,
                              //           decoration: BoxDecoration(
                              //             color: kbotton,
                              //             borderRadius: BorderRadius.circular(10),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.black,
                              //                 offset: const Offset(0, 4),
                              //                 blurRadius: 8,
                              //                 spreadRadius: 1,
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       Positioned(
                              //         top: 0,
                              //         left: 10,
                              //         bottom: 20,
                              //         child: Container(
                              //           height: 120,
                              //           width: 110,
                              //           padding: const EdgeInsets.all(8.0),
                              //           // child: Image.asset(
                              //           // 'assets/images/download.png'
                              //           //,
                              //           //  fit: BoxFit.contain,
                              //           // ),
                              //         ),
                              //       ),
                              //       Positioned(
                              //         top: 50,
                              //         right: 16,
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.end,
                              //           children: [
                              //             Text(
                              //               ':  Product ',
                              //               style: GoogleFonts.cairo(
                              //                 textStyle: const TextStyle(
                              //                   fontSize: 23,
                              //                   fontWeight: FontWeight.bold,
                              //                   color: kmontg,
                              //                 ),
                              //               ),
                              //             ),
                              //             Center(
                              //               widthFactor: 2,
                              //               child: Text(
                              //                 data[index]['name'],
                              //                 style: GoogleFonts.cairo(
                              //                   textStyle: const TextStyle(
                              //                     fontSize: 22,
                              //                     fontWeight: FontWeight.bold,
                              //                     color: kText,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ),
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
