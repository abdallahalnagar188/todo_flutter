import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  String title;
  String hint;
  TextInputType keyboardType;
  bool sceuredPassword;

  AppFormField({
    super.key,
    required this.title,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.sceuredPassword = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            label: Text(hint),
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: keyboardType,
          obscureText: sceuredPassword,
        ),
      ],
    );
  }
}
