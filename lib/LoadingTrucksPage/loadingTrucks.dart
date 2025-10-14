import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'addloading.dart';

class LoadingTrucksPage extends StatefulWidget {
  const LoadingTrucksPage({super.key});

  @override
  State<LoadingTrucksPage> createState() => _LoadingTrucksPageState();
}

class _LoadingTrucksPageState extends State<LoadingTrucksPage> {
  final CollectionReference trucksCollection = FirebaseFirestore.instance
      .collection('trucks');

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ar', null);
  }

  Future<void> deleteTruck(String docId, Map<String, dynamic> truck) async {
    final docRef = trucksCollection.doc(docId);
    await docRef.update({
      'trucks': FieldValue.arrayRemove([truck]),
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('تم حذف السيارة')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سيارات التحميل'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: trucksCollection
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ، حاول مرة أخرى.'));
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text('لا توجد سيارات.'));
          }

          // 🧩 نجمع كل الشاحنات من جميع الأيام
          final allTrucks = <Map<String, dynamic>>[];
          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;
            final List trucks = data['trucks'] ?? [];
            for (var truck in trucks) {
              allTrucks.add({'truck': truck, 'docId': doc.id});
            }
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: allTrucks.length,
            itemBuilder: (context, index) {
              final truckData =
                  allTrucks[index]['truck'] as Map<String, dynamic>;
              final docId = allTrucks[index]['docId'] as String;
              final timestamp = (truckData['timestamp'] as Timestamp).toDate();

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.local_shipping),
                  title: Text(truckData['name']),
                  subtitle: Text(
                    ' ${truckData['pallets']},\n ${truckData['boxes']} \n'
                    '${truckData['description'] ?? ''}\n'
                    'تاريخ التسجيل: ${DateFormat('yyyy-MM-dd – kk:mm').format(timestamp)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('تأكيد الحذف'),
                            content: const Text(
                              'هل أنت متأكد أنك تريد حذف هذه السيارة؟',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  ); // إغلاق الرسالة بدون حذف
                                },
                                child: const Text('إلغاء'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context); // إغلاق الرسالة
                                  await deleteTruck(
                                    docId,
                                    truckData,
                                  ); // تنفيذ الحذف
                                },
                                child: const Text(
                                  'نعم',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTruckPage()),
          );
        },
        backgroundColor: Colors.blueGrey[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
