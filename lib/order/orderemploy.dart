import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elhwar/page/hompage.dart';
import 'package:intl/intl.dart';

class EmployeeOrdersPage extends StatefulWidget {
  const EmployeeOrdersPage({super.key});

  @override
  State<EmployeeOrdersPage> createState() => _EmployeeOrdersPageState();
}

class _EmployeeOrdersPageState extends State<EmployeeOrdersPage> {
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
            transitionDuration: const Duration(milliseconds: 50), // سريع
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
          title: const Text('أوامر المدير'),
          backgroundColor: Colors.blueGrey[800],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 50), // سريع
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
          child: StreamBuilder<QuerySnapshot>(
            stream: orders.orderBy('timestamp', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = snapshot.data!.docs;
              if (data.isEmpty) {
                return const Center(child: Text('لا يوجد أوامر حتى الآن'));
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final orderDoc = data[index];
                  final orderData = orderDoc.data() as Map<String, dynamic>;
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
