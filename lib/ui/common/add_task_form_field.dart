import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Validator = String? Function(String? text);

class AddTaskFormField extends StatefulWidget {
  String hint;
  TextInputType keyboardType;
  bool sceuredPassword;
  Validator? validator;
  TextEditingController? controler = null;

  AddTaskFormField({
    super.key,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.sceuredPassword = false,
    this.validator,
    this.controler,
  });

  @override
  State<AddTaskFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AddTaskFormField> {
  bool isVisibleText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVisibleText = widget.sceuredPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade600
        )
      ),
      keyboardType: widget.keyboardType,
      obscureText: isVisibleText,
      validator: widget.validator,
      controller: widget.controler,
    );
  }
}
