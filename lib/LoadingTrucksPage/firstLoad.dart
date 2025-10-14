import 'package:elhwar/LoadingTrucksPage/loademploy.dart';
import 'package:elhwar/LoadingTrucksPage/loadingTrucks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class firsload extends StatelessWidget {
  const firsload({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference orders = FirebaseFirestore.instance.collection(
      'manager_orders',
    );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // يرجع عند الضغط على زر الرجوع
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('التحميل', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueGrey[800],
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                'سيارات التحمل اليومية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // 🔹 زر المدير بكلمة السر
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    final TextEditingController passwordController =
                        TextEditingController();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('أدخل كلمة السر'),
                          content: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'اكتب كلمة السر هنا',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('إلغاء'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (passwordController.text.trim() == '3333') {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(
                                        milliseconds: 50,
                                      ),
                                      pageBuilder: (_, __, ___) =>
                                          const LoadingTrucksPage(),
                                      transitionsBuilder:
                                          (_, animation, __, child) =>
                                              FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('كلمة السر غير صحيحة!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'تأكيد',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'المبيعات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 زر الموظف مع عداد الأوامر
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
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                  milliseconds: 50,
                                ),
                                pageBuilder: (_, __, ___) =>
                                    const Loadingemployer(),
                                transitionsBuilder: (_, animation, __, child) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'قسم المنتج النهائى',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // ✅ لو في عدد أكبر من 0 يظهر الدائرة الحمراء
                      // if (count > 0)
                      //   Positioned(
                      //     right: 16,
                      //     top: 4,
                      //     child: Container(
                      //       padding: const EdgeInsets.all(4),
                      //       decoration: const BoxDecoration(
                      //         color: Colors.red,
                      //         shape: BoxShape.circle,
                      //       ),
                      //       constraints: const BoxConstraints(
                      //         minWidth: 20,
                      //         minHeight: 20,
                      //       ),
                      //       child: Text(
                      //         '$count',
                      //         style: const TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //         textAlign: TextAlign.center,
                      //       ),
                      //     ),
                      //   ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
