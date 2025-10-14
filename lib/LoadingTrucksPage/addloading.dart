import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddTruckPage extends StatefulWidget {
  const AddTruckPage({super.key});

  @override
  State<AddTruckPage> createState() => _AddTruckPageState();
}

class _AddTruckPageState extends State<AddTruckPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palletsController = TextEditingController();
  final TextEditingController _boxesController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference trucksCollection = FirebaseFirestore.instance
      .collection('trucks');

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ar', null);
  }

  Future<void> addTruck() async {
    if (_formKey.currentState!.validate()) {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final newTruck = {
        'name': _nameController.text.trim(),
        'pallets': _palletsController.text.trim(),
        'boxes': _boxesController.text.trim(),
        'number': _numberController.text.trim(),
        'description': _descriptionController.text.trim(),
        'timestamp': DateTime.now(),
      };

      final docRef = trucksCollection.doc(today);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.update({
          'trucks': FieldValue.arrayUnion([newTruck]),
        });
      } else {
        await docRef.set({
          'trucks': [newTruck],
          'timestamp': DateTime.now(),
        });
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم إضافة السيارة بنجاح')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة سيارة'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المنتج',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _palletsController,
                decoration: const InputDecoration(
                  labelText: 'عدد البلتات',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _boxesController,
                decoration: const InputDecoration(
                  labelText: 'عدد العبوات',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
              ),
              const SizedBox(height: 16),
              // TextFormField(
              //   controller: _numberController,
              //   decoration: const InputDecoration(
              //     labelText: 'رقم السيارة',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) =>
              //       value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
              // ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'وصف اختياري',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: addTruck,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'حفظ السيارة',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
