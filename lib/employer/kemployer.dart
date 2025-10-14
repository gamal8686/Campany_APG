import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elhwar/employer/listemployr.dart';
import 'package:elhwar/employer/updateemployerj.dart';
import 'package:flutter/material.dart';
import 'kemployer.dart';

class EmployeeDetailsPage extends StatefulWidget {
  final DocumentSnapshot employeeDoc;

  const EmployeeDetailsPage({super.key, required this.employeeDoc});

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  late DocumentSnapshot employeeDoc;

  @override
  void initState() {
    super.initState();
    employeeDoc = widget.employeeDoc;
  }

  Future<void> refreshData() async {
    final updatedDoc = await FirebaseFirestore.instance
        .collection('employees')
        .doc(employeeDoc.id)
        .get();

    if (mounted) {
      setState(() {
        employeeDoc = updatedDoc;
      });
    }
  }

  Future<bool> _onWillPop() async {
    // عند الضغط على زر الرجوع في الهاتف
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EmployeesListPage(),
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
    return false; // منع الرجوع الافتراضي
  }

  @override
  Widget build(BuildContext context) {
    final name = employeeDoc['name'] ?? '';
    final position = employeeDoc['position'] ?? '';
    final phone = employeeDoc['phone'] ?? '';
    final employeeId = employeeDoc['employeeId'] ?? '';
    final address = employeeDoc['address'] ?? '';
    final vacations = employeeDoc['vacations'] ?? '';
    final penalties = employeeDoc['penalties'] ?? '';

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFBDBDBD),
        appBar: AppBar(
          title: Text(name),
          backgroundColor: Colors.grey[800],
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _onWillPop(),
          ),
          actions: [
            // ✏️ أيقونة التعديل
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () async {
                // 🔐 نعرض دايالوج يطلب الرقم السري
                final TextEditingController passController =
                    TextEditingController();

                final bool? isAuthorized = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('ادخل الرقم السري'),
                    content: TextField(
                      controller: passController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'ادخل 4444'),
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

                // ✅ لو الرقم السري صحيح نكمل التعديل
                if (isAuthorized == true) {
                  await Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 100),
                      pageBuilder: (_, __, ___) =>
                          UpdateEmployeePage(employeeDoc: employeeDoc),
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  );
                  await refreshData();
                }
              },
            ),

            // 🗑️ أيقونة الحذف
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () async {
                final firstConfirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('تأكيد الحذف'),
                    content: const Text(
                      'هل أنت متأكد أنك تريد حذف هذا الموظف؟',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('إلغاء'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('متابعة'),
                      ),
                    ],
                  ),
                );

                if (firstConfirm == true) {
                  final finalConfirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('تأكيد نهائي'),
                      content: const Text(
                        'هل أنت متأكد 100٪ من حذف هذا الموظف؟ لا يمكن التراجع بعد الحذف.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('إلغاء'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: const Text('تأكيد الحذف'),
                        ),
                      ],
                    ),
                  );

                  if (finalConfirm == true) {
                    await employeeDoc.reference.delete();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✅ تم حذف الموظف بنجاح'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      _onWillPop();
                    }
                  }
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: _buildEmployeeCard(
            name,
            employeeId,
            position,
            phone,
            address,
            vacations,
            penalties,
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(
    String name,
    String id,
    String position,
    String phone,
    String address,
    String vacations,
    String penalties,
  ) {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const Divider(height: 30, thickness: 1),
            _buildDetailRow('الكود', id),
            _buildDetailRow('المسمى الوظيفي', position, singleLine: true),
            _buildDetailRow('رقم الهاتف', phone),
            _buildDetailRow('العنوان', address),
            _buildDetailRow('الإجازات', vacations),
            _buildDetailRow(
              'الجزاءات',
              penalties.isNotEmpty ? penalties : 'لا يوجد',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool singleLine = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: singleLine
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value.isNotEmpty ? value : '-',
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              softWrap: !singleLine,
              overflow: singleLine
                  ? TextOverflow.ellipsis
                  : TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
