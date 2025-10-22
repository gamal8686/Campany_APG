import 'package:animate_do/animate_do.dart';
import 'package:elhwar/custem/LogoCampany.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:elhwar/page/sineIn.dart';
import 'package:flutter/material.dart';

class Company extends StatefulWidget {
  const Company({super.key});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomPage(),
          transitionDuration: Duration.zero, // 👈 من غير أنيميشن
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/Untitled.png',
                width: screenWidth,
                height: screenHeight,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.08,
                left: screenWidth * 0.15,
              ),
              child: Center(child: ShakeY(child: const LogoCampany())),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:elhwar/const/const.dart';
// import 'package:elhwar/custem/LogoCampany.dart';
// import 'package:elhwar/page/sineIn.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Company extends StatelessWidget {
//   const Company({super.key});

//   Future<void> _goToSignin(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("visitedCompany", true); // 👈 حفظنا انه زار الصفحة
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => sinein()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/images/Untitled.png',
//                 width: screenWidth,
//                 height: screenHeight,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 top: screenHeight * 0.08,
//                 left: screenWidth * 0.19,
//               ),
//               child: Center(child: LogoCampany()),
            // ),
            // Positioned(
            //   top: screenHeight * 0.85,
            //   left: screenWidth * 0.40,
            //   child: ElevatedButton(
            //     onPressed: () => _goToSignin(context),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: kbotton,
            //       foregroundColor: kText,
            //       elevation: 8,
            //       shadowColor: Colors.black,
            //       minimumSize: Size(150, 50),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //     child: Text(
            //       'Go',
            //       style: GoogleFonts.cairo(
            //         textStyle: const TextStyle(
            //           fontSize: 25,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
