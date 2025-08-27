import 'package:elhwar/custemColors.dart';
import 'package:elhwar/home.dart';
import 'package:elhwar/page/airBode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Face extends StatelessWidget {
  const Face({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.black), // بدل Expanded
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Image.asset('images/aimage-10.jpg'),
          ),
          Positioned(
            top: 600,
            left: 0,
            right: 0,
            child: Center(
              child: MaterialButton(
                minWidth: 250,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                height: 50,
                color: const Color.fromARGB(255, 208, 195, 17),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'دخول',
                  style: GoogleFonts.getFont(
                    'Almarai',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
