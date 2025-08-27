import 'package:elhwar/custemColors.dart';
import 'package:elhwar/detilsItem.dart';
import 'package:elhwar/list.dart/listprodect.dart';
import 'package:elhwar/main.dart';
import 'package:elhwar/page/airBode.dart';
import 'package:elhwar/page/camera.dart';
import 'package:elhwar/page/mobail.dart';
import 'package:elhwar/page/scrin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: kPrimaryColor,
        child: Column(
          children: [
            SizedBox(height: 150),
            Text(
              'الاقسام  :',
              style: GoogleFonts.getFont(
                'Almarai',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: 250,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => airBode(imaged: 'images/airpod.png'),
                  ),
                );
              },
              height: 50,
              color: kTextColor,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),
              child: Text(
                ' اير بودز',
                style: GoogleFonts.getFont(
                  'Almarai',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: 250,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Mobail(imaged: 'images/mobile.png'),
                  ),
                );
              },
              height: 50,
              color: kTextColor,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),
              child: Text(
                'اجهزة الموبيل',
                style: GoogleFonts.getFont(
                  'Almarai',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: 250,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Scrin(imaged: 'images/headset.png'),
                  ),
                );
              },
              height: 50,
              color: kTextColor,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),
              child: Text(
                'سماعات الهيد  ',
                style: GoogleFonts.getFont(
                  'Almarai',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: 250,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => camera(imaged: 'images/camera.png'),
                  ),
                );
              },
              height: 50,
              color: kTextColor,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),
              child: Text(
                ' كاميرات الخارجى',
                style: GoogleFonts.getFont(
                  'Almarai',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: 250,
              onPressed: () {},

              height: 50,
              color: kTextColor,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),
              child: Text(
                ' تواصل معنا',
                style: GoogleFonts.getFont(
                  'Almarai',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              minWidth: 250,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Face()),
                );
              },
              height: 50,
              color: kTextColor,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),
              child: Text(
                ' خروج',
                style: GoogleFonts.getFont(
                  'Almarai',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          '    محتويات المتجر',
          style: GoogleFonts.getFont(
            'Almarai',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBlueColor,
      body: homeabbet(),
    );
  }
}

class homeabbet extends StatelessWidget {
  const homeabbet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            ' مرحبا بكم في متجر الهوارى',
            style: GoogleFonts.getFont(
              'Almarai',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          SizedBox(height: 10),

          Expanded(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MaterialButton(
                            minWidth: 250,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      airBode(imaged: 'images/airpod.png'),
                                ),
                              );
                            },
                            height: 50,
                            color: kTextColor,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            child: Text(
                              ' اير بودز',
                              style: GoogleFonts.getFont(
                                'Almarai',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MaterialButton(
                            minWidth: 250,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      camera(imaged: 'images/camera.png'),
                                ),
                              );
                            },
                            height: 50,
                            color: kTextColor,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            child: Text(
                              ' الكاميرات ',
                              style: GoogleFonts.getFont(
                                'Almarai',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MaterialButton(
                            minWidth: 250,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Mobail(imaged: 'images/mobile.png'),
                                ),
                              );
                            },
                            height: 50,
                            color: kTextColor,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            child: Text(
                              ' الموبيلات ',
                              style: GoogleFonts.getFont(
                                'Almarai',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MaterialButton(
                            minWidth: 250,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Scrin(imaged: 'images/headset.png'),
                                ),
                              );
                            },
                            height: 50,
                            color: kTextColor,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            child: Text(
                              ' الهيد ',
                              style: GoogleFonts.getFont(
                                'Almarai',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
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
        ],
      ),
    );
  }
}
