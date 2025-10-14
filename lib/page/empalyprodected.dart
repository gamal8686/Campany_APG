import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/add/addHome.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/CardProducts.dart';
import 'package:elhwar/page/detilsProducts.dart';
import 'package:elhwar/page/employdetilsprodect.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:elhwar/updaithome.dart/edithom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class employProducts extends StatefulWidget {
  const employProducts({super.key});

  @override
  State<employProducts> createState() => _ProductsState();
}

class _ProductsState extends State<employProducts> {
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
        // لما يضغط على زر الرجوع الأساسي، يرجع للـ HomPage زي زر الرجوع جوه المشروع
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => HomPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        return false; // لمنع السلوك الافتراضي
      },
      child: SafeArea(
        child: Scaffold(
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
                    ),
                  ],
                ),
              ),
              // باقي الكود بدون تغيير
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
                        child: CircularProgressIndicator(color: Colors.brown),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: InkWell(
                              onLongPress: () {},
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => Employdetilsprodect(
                                          categoreid: data[index].id,
                                        ),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            top: 20,
                                          ),
                                          height: 200,
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
                                                color: Colors.black,
                                                offset: const Offset(0, 4),
                                                blurRadius: 8,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 20,
                                                left: 0,
                                                right: 0,
                                                child: Container(height: 170),
                                              ),
                                              Positioned(
                                                left: 10,
                                                bottom: 0,
                                                child: Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pushReplacement(
                                                        PageRouteBuilder(
                                                          pageBuilder:
                                                              (
                                                                context,
                                                                animation,
                                                                secondaryAnimation,
                                                              ) => Employdetilsprodect(
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
                                                      maxRadius: 25,
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                            255,
                                                            241,
                                                            236,
                                                            123,
                                                          ),
                                                      child: Icon(
                                                        Icons.menu_book,
                                                        size: 30,
                                                        color: kbotton,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                right: 180,
                                                child: Center(
                                                  child: CircleAvatar(
                                                    maxRadius: 30,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                          255,
                                                          241,
                                                          236,
                                                          123,
                                                        ),
                                                    child: Image.asset(
                                                      'assets/images/download.png',
                                                      height: 50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 50,
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
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
