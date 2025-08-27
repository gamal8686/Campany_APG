import 'package:elhwar/list.dart/listprodect.dart';
import 'package:elhwar/page/airBode.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class detilsItem extends StatelessWidget {
  const detilsItem({super.key, required this.namber, required this.item});
  final int namber;
  final Product item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},

        child: Container(
          alignment: Alignment.topCenter,
          height: 190,

          // color: Colors.green,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 166,
                  width: 500,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 15),
                        blurRadius: 15,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 150,
                  width: 150,
                  child: Align(
                    alignment: Alignment.centerLeft, // يخلي الصورة شمال
                    child: Image.asset(
                      item.image,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 20,
                child: SizedBox(
                  height: 136,
                  child: Column(
                    children: [
                      Flexible(
                        child: Text(
                          item.category,
                          style: GoogleFonts.almarai(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true, // يخلي النص يلف بدل ما يتمدد
                        ),
                      ),
                      SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          item.name,
                          style: GoogleFonts.almarai(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true, // يخلي النص يلف بدل ما يتمدد
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
