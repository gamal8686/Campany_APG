import 'package:elhwar/const/const.dart';
import 'package:elhwar/custem/kTextFormField.dart';
import 'package:elhwar/page/Products.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:elhwar/page/pageCompany.dart';
import 'package:elhwar/page/sineIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class sineup extends StatelessWidget {
  sineup({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
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
                    'Sign Up',
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
                    hint: 'name',
                    leabol: 'name',
                    controller: name,
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
                            .createUserWithEmailAndPassword(
                              email: email.text,
                              password: bassword.text,
                            );
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Products(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
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
                    color: kbotton,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      ' رجوع',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kText,
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            sinein(),
                        transitionDuration: Duration.zero, // ⏱️ يلغي وقت الحركة
                        reverseTransitionDuration:
                            Duration.zero, // ⏱️ يلغي الرجوع
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
