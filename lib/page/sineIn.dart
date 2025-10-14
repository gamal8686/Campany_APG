import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/kTextFormField.dart';
import 'package:elhwar/page/Products.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:elhwar/page/sineup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class sinein extends StatelessWidget {
  sinein({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController bassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Sign In',
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: kText,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  custmTextField(
                    hint: 'Email',
                    leabol: 'email',
                    controller: email,
                  ),
                  SizedBox(height: 30),
                  custmTextField(
                    controller: bassword,
                    hint: 'bassword',
                    leabol: 'bassword',
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: email.text,
                              password: bassword.text,
                            );

                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Products(),
                            transitionDuration:
                                Duration.zero, // ⏱️ يلغي وقت الحركة
                            reverseTransitionDuration:
                                Duration.zero, // ⏱️ يلغي الرجوع
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    color: kbotton,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      ' ادخل',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kText,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  HomPage(),
                          transitionDuration:
                              Duration.zero, // ⏱️ يلغي وقت الحركة
                          reverseTransitionDuration:
                              Duration.zero, // ⏱️ يلغي الرجوع
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
                      'خروج ',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: kText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
