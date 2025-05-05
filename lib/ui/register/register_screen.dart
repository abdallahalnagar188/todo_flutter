import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/common/app_form_field.dart';

class RegisterScreen extends StatelessWidget {
  static String routName = "register_screen";

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppFormField(
                title: "Full Name",
                hint: "Please enter Full name",
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              AppFormField(
                title: "Mail",
                hint: "Please enter eMail",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              AppFormField(
                title: "PassWord",
                hint: "Please enter PassWord",
                keyboardType: TextInputType.text,
                sceuredPassword: true,
              ),
              SizedBox(height: 20),
              AppFormField(
                title: " Conformation PassWord",
                hint: "Please enter PassWord",
                keyboardType: TextInputType.text,
                sceuredPassword: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
