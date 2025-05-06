import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Validator = String? Function (String? text);

class AppFormField extends StatefulWidget {
  String title;
  String hint;
  TextInputType keyboardType;
  bool sceuredPassword;
  Validator? validator;
  TextEditingController? controler = null;

  AppFormField({
    super.key,
    required this.title,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.sceuredPassword = false,
    this.validator,
    this.controler
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool isVisibleText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVisibleText = widget.sceuredPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            suffixIcon:
            widget.sceuredPassword
                ? InkWell(
              onTap: () {
                setState(() {
                  isVisibleText = !isVisibleText;
                });
              },
              child: Icon(
                isVisibleText
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            label: Text(widget.hint),
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          keyboardType: widget.keyboardType,
          obscureText: isVisibleText,
          validator:widget.validator ,
          controller:widget.controler,
        ),
      ],
    );
  }
}
