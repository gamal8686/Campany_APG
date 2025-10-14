import 'package:flutter/material.dart';

class custmTextField extends StatefulWidget {
  final String hint;
  final String leabol;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const custmTextField({
    super.key,
    required this.hint,
    required this.leabol,
    this.validator,
    required this.controller,
  });

  @override
  State<custmTextField> createState() => NiceTextFieldState();
}

class NiceTextFieldState extends State<custmTextField> {
  TextEditingController controllerr = TextEditingController();
  GlobalKey Mykey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.leabol,
          hintText: widget.hint,
          floatingLabelBehavior: FloatingLabelBehavior.auto,

          // ✨ الألوان
          labelStyle: const TextStyle(color: Colors.deepPurple),
          hintStyle: TextStyle(color: Colors.deepPurple.shade200),
          filled: true,
          fillColor: Colors.deepPurple.shade50,

          // ✨ الـ borders
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.deepPurple.shade200,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),

          // ✨ أيقونة في الشمال
        ),
      ),
    );
  }
}
