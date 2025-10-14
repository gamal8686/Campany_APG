import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateEmployeePage extends StatefulWidget {
  final DocumentSnapshot employeeDoc;

  const UpdateEmployeePage({super.key, required this.employeeDoc});

  @override
  State<UpdateEmployeePage> createState() => _UpdateEmployeePageState();
}

class _UpdateEmployeePageState extends State<UpdateEmployeePage> {
  late TextEditingController nameController;
  late TextEditingController positionController;
  late TextEditingController phoneController;
  late TextEditingController employeeIdController;
  late TextEditingController addressController;
  late TextEditingController vacationsController;
  late TextEditingController penaltiesController;

  @override
  void initState() {
    super.initState();
    final data = widget.employeeDoc.data() as Map<String, dynamic>;

    nameController = TextEditingController(text: data['name'] ?? '');
    positionController = TextEditingController(text: data['position'] ?? '');
    phoneController = TextEditingController(text: data['phone'] ?? '');
    employeeIdController = TextEditingController(
      text: data['employeeId'] ?? '',
    );
    addressController = TextEditingController(text: data['address'] ?? '');
    vacationsController = TextEditingController(text: data['vacations'] ?? '');
    penaltiesController = TextEditingController(text: data['penalties'] ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    phoneController.dispose();
    employeeIdController.dispose();
    addressController.dispose();
    vacationsController.dispose();
    penaltiesController.dispose();
    super.dispose();
  }

  Future<void> updateEmployee() async {
    try {
      await widget.employeeDoc.reference.update({
        'name': nameController.text.trim(),
        'position': positionController.text.trim(),
        'phone': phoneController.text.trim(),
        'employeeId': employeeIdController.text.trim(),
        'address': addressController.text.trim(),
        'vacations': vacationsController.text.trim(),
        'penalties': penaltiesController.text.trim().isEmpty
            ? 'لا يوجد جزاءات'
            : penaltiesController.text.trim(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ تم تحديث بيانات الموظف بنجاح')),
        );

        // 🔹 رجوع سريع إلى صفحة التفاصيل بدون وميض
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ حدث خطأ أثناء التحديث: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        title: const Text('تعديل بيانات الموظف'),
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
                  onPressed: updateEmployee,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'حفظ التعديلات',
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
