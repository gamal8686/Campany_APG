import 'package:elhwar/custemColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:elhwar/home.dart';
import 'package:elhwar/list.dart/listprodect.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Scrin extends StatelessWidget {
  final String imaged;
  const Scrin({super.key, required this.imaged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(
              context,
            ).pushReplacement(MaterialPageRoute(builder: (context) => Home())),
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
      backgroundColor: kBlueColor,

      body: Scrinv(),
    );
  }
}

class Scrinv extends StatefulWidget {
  const Scrinv({super.key});

  @override
  State<Scrinv> createState() => _nameState();
}

class _nameState extends State<Scrinv> {
  List<QueryDocumentSnapshot> data = [];

  addData() async {
    CollectionReference Scrin = FirebaseFirestore.instance.collection('Mobail');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Scrin')
        .get();
    data = querySnapshot.docs;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(height: 30),
          Expanded(
            child: Stack(
              children: [
                Container(color: kBlueColor),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var docData =
                        data[index].data()
                            as Map<String, dynamic>; // 👈 حول المستند إلى Map
                    var productf = Product.fromFirestore(docData);
                    return detelScrin(Index: index, item: productf);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class detelScrin extends StatelessWidget {
  final int Index;
  final Product item;
  const detelScrin({super.key, required this.Index, required this.item});

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
                      'images/headset.png',
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
                          item.name,
                          style: GoogleFonts.almarai(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 4),
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
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.amber,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 5,
                        ),
                        child: FittedBox(
                          child: Text(
                            'السعر:${item.price}',
                            style: GoogleFonts.getFont(
                              'Almarai',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
