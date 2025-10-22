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

class Empalyprodected extends StatefulWidget {
  const Empalyprodected({super.key});

  @override
  State<Empalyprodected> createState() => _ProductsState();
}

class _ProductsState extends State<Empalyprodected> {
  List<QueryDocumentSnapshot> filteredData = [];
  String searchQuery = '';
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
              // SizedBox(height: 50),
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
                              onTap: () {
                                // خلي الكارت كله يقدر يضغط عليه
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
                                  height: 250, // 👈 كانت 190 قللناها
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
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 30,
                                                left: 10,
                                                right: 120,
                                                child: Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            241,
                                                            236,
                                                            123,
                                                          ),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    height: 50,
                                                    width: 180,
                                                    child: Center(
                                                      child: Text(
                                                        data[index]['nambrr'],
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 90,
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
