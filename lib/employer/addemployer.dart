import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController vacationsController = TextEditingController();
  final TextEditingController penaltiesController = TextEditingController();

  Future<void> addEmployee() async {
    try {
      await FirebaseFirestore.instance.collection('employees').add({
        'name': nameController.text.trim(),
        'position': positionController.text.trim(),
        'phone': phoneController.text.trim(),
        'employeeId': employeeIdController.text.trim(),
        'address': addressController.text.trim(),
        'vacations': vacationsController.text.trim(),
        'penalties': penaltiesController.text.trim().isEmpty
            ? 'لا يوجد جزاءات'
            : penaltiesController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ تم إضافة الموظف بنجاح')),
        );

        // 🔹 رجوع سريع لصفحة القائمة بدون وميض
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ حدث خطأ أثناء الإضافة: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        title: const Text('إضافة موظف جديد'),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildTextField('الاسم', nameController),
                _buildTextField('المسمى الوظيفي', positionController),
                _buildTextField(
                  'رقم الهاتف',
                  phoneController,
                  keyboardType: TextInputType.phone,
                ),
                _buildTextField(
                  'الكود',
                  employeeIdController,
                  keyboardType: TextInputType.number,
                ),
                _buildTextField('العنوان', addressController),
                _buildTextField(
                  'عدد الإجازات',
                  vacationsController,
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  'الجزاءات',
                  penaltiesController,
                  keyboardType: TextInputType.number,
                  optional: true,
                ),
                const SizedBox(height: 25),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: addEmployee,
                  icon: const Icon(Icons.person_add),
                  label: const Text(
                    'إضافة الموظف',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool optional = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: optional ? 'اختياري' : '',
          labelStyle: const TextStyle(color: Colors.black87, fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
