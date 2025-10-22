import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/const/const.dart';
import 'package:elhwar/employer/addemployer.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:flutter/material.dart';
import 'kemployer.dart';

class EmployeesListPage extends StatefulWidget {
  const EmployeesListPage({super.key});

  @override
  State<EmployeesListPage> createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  final CollectionReference employees = FirebaseFirestore.instance.collection(
    'employees',
  );

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 80),
            pageBuilder: (_, __, ___) => const HomPage(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
          (route) => false,
        );
        return false; // لمنع الرجوع الافتراضي
      },
      child: Scaffold(
        backgroundColor: kbacegGrond,
        appBar: AppBar(
          title: const Text('قائمة الموظفين'),
          backgroundColor: Colors.grey[800],
          foregroundColor: kbotton,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            tooltip: 'رجوع إلى الرئيسية',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 80),
                  pageBuilder: (_, __, ___) => const HomPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
                (route) => false,
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white, size: 28),
              tooltip: 'إضافة موظف جديد',
              onPressed: () async {
                final TextEditingController passController =
                    TextEditingController();

                final bool? isAuthorized = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('أدخل الرقم السري'),
                    content: TextField(
                      controller: passController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('إلغاء'),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      ElevatedButton(
                        child: const Text('تأكيد'),
                        onPressed: () {
                          if (passController.text == '4444') {
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('❌ الرقم السري غير صحيح'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );

                if (isAuthorized == true) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 120),
                      pageBuilder: (_, __, ___) => const AddEmployeePage(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // 🔍 شريط البحث
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ابحث بالاسم أو الكود...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.trim().toLowerCase();
                  });
                },
              ),
            ),

            // 📋 عرض الموظفين
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: employees.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('حدث خطأ أثناء تحميل البيانات'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.data!.docs.where((doc) {
                    final dataMap = doc.data() as Map<String, dynamic>;
                    final name = (dataMap['name'] ?? '')
                        .toString()
                        .toLowerCase();
                    final id = (dataMap['employeeId'] ?? '')
                        .toString()
                        .toLowerCase();
                    return name.contains(searchQuery) ||
                        id.contains(searchQuery);
                  }).toList();

                  if (data.isEmpty) {
                    return const Center(
                      child: Text('لا يوجد موظفين مطابقين للبحث'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final dataMap =
                          data[index].data() as Map<String, dynamic>? ?? {};
                      final name = dataMap['name'] ?? '';
                      final employeeId = dataMap['employeeId'] ?? 'غير محدد';

                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text('الكود: $employeeId'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                  milliseconds: 120,
                                ),
                                pageBuilder: (_, __, ___) =>
                                    EmployeeDetailsPage(
                                      employeeDoc: data[index],
                                    ),
                                transitionsBuilder: (_, animation, __, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
