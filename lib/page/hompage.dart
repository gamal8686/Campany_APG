import 'package:elhwar/LoadingTrucksPage/firstLoad.dart';
import 'package:elhwar/LoadingTrucksPage/loadingTrucks.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/LogoCampany.dart';
import 'package:elhwar/employer/kemployer.dart';
import 'package:elhwar/employer/listemployr.dart';
import 'package:elhwar/order/firstorder.dart';
import 'package:elhwar/order/order.dart';
import 'package:elhwar/page/Products.dart';
import 'package:elhwar/page/empalyprodected.dart';
import 'package:elhwar/page/pageCompany.dart';
import 'package:elhwar/page/sineIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomPage extends StatefulWidget {
  const HomPage({super.key});

  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  final CollectionReference orders = FirebaseFirestore.instance.collection(
    'manager_orders',
  );

  bool showBadge = true; // يتحكم في ظهور العداد

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kbacegGrond,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.03,
                left: screenWidth * 0.15,
              ),
              child: Center(child: LogoCampany()),
            ),
            SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    employProducts(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      color: kbotton,
                      minWidth: double.infinity,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        ' أماكن الانتاج التام',
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    firsload(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      color: kbotton,
                      minWidth: double.infinity,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        ' سيارات التحميل',
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder<QuerySnapshot>(
                      stream: orders.snapshots(),
                      builder: (context, snapshot) {
                        int count = 0;
                        if (snapshot.hasData) {
                          count = snapshot.data!.docs.length;
                        }
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                // عند الدخول على صفحة التعليمات نخفي العداد
                                setState(() {
                                  showBadge = false;
                                });
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => InstructionsPage(),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              color: kbotton,
                              minWidth: double.infinity,
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                ' التعليمات',
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kText,
                                  ),
                                ),
                              ),
                            ),
                            if (count > 0 && showBadge)
                              Positioned(
                                right: 16,
                                top: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: Text(
                                    '$count',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    EmployeesListPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      color: kbotton,
                      minWidth: double.infinity,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        ' أمناء المخزن والسائقين',
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    sinein(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      color: kbotton,
                      minWidth: double.infinity,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'الاضافة والحذف',
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    MaterialButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        SystemNavigator.pop();
                      },
                      color: kbotton,
                      minWidth: double.infinity,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        ' خروج',
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
