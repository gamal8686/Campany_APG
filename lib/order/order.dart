import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:intl/intl.dart'; // مهم لعرض التاريخ

class ManagerOrdersPage extends StatefulWidget {
  const ManagerOrdersPage({super.key});

  @override
  State<ManagerOrdersPage> createState() => _ManagerOrdersPageState();
}

class _ManagerOrdersPageState extends State<ManagerOrdersPage> {
  final TextEditingController _orderController = TextEditingController();
  final CollectionReference orders = FirebaseFirestore.instance.collection(
    'manager_orders',
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 50), // أسرع
            pageBuilder: (_, __, ___) => const HomPage(),
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('صفحة المدير'),
          backgroundColor: Colors.blueGrey[800],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 50), // أسرع
                  pageBuilder: (_, __, ___) => const HomPage(),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(opacity: animation, child: child),
                ),
                (route) => false,
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // كارد لإصدار الأوامر
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _orderController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'اكتب الأمر هنا...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final text = _orderController.text.trim();
                          if (text.isNotEmpty) {
                            await orders.add({
                              'order': text,
                              'timestamp': Timestamp.now(),
                            });
                            _orderController.clear();
                          }
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('إرسال الأمر'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الأوامر:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: orders
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final data = snapshot.data!.docs;
                    if (data.isEmpty) {
                      return const Center(
                        child: Text('لا يوجد أوامر حتى الآن'),
                      );
                    }
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final orderDoc = data[index];
                        final orderData =
                            orderDoc.data() as Map<String, dynamic>;
                        final timestamp = orderData['timestamp'] as Timestamp;
                        final formattedDate = DateFormat(
                          'yyyy-MM-dd – kk:mm',
                        ).format(timestamp.toDate());

                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              orderData['order'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              formattedDate,
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () async {
                                final firstConfirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('تأكيد الحذف'),
                                    content: const Text(
                                      'هل أنت متأكد أنك تريد حذف هذا الأمر؟',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('إلغاء'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
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
                                        'هل أنت متأكد 100٪ من حذف هذا الأمر؟ لا يمكن التراجع بعد الحذف.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text('إلغاء'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent,
                                          ),
                                          child: const Text('تأكيد الحذف'),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (finalConfirm == true) {
                                    await orderDoc.reference.delete();
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('✅ تم حذف الأمر بنجاح'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                            ),
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
      ),
    );
  }
}
