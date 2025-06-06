import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/ui/auth/login/login_screen.dart';
import 'package:todo_flutter/ui/common/app_form_field.dart';
import 'package:todo_flutter/ui/common/dialog_utils.dart';
import 'package:todo_flutter/ui/home/home_screen.dart';
import 'package:todo_flutter/ui/them/todo_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/auth_provider.dart';
import '../../common/app_utils.dart';

class RegisterScreen extends StatefulWidget {
  static String routName = "register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController passwordConformation = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TodoTheme.appColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40),
                  Image.asset(MyImages.routeLogoIv, height: 70, width: 100),
                  SizedBox(height: 40),

                  AppFormField(
                    title: AppLocalizations.of(context)!.fullName,
                    hint: AppLocalizations.of(context)!.fullNameHint,
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return AppLocalizations.of(context)!.fullNameHint;
                      }
                      return null;
                    },
                    controler: fullName,
                  ),
                  SizedBox(height: 28),
                  AppFormField(
                    title: AppLocalizations.of(context)!.email,
                    hint: AppLocalizations.of(context)!.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return AppLocalizations.of(context)!.emailHint;
                      }
                      return null;
                    },
                    controler: email,
                  ),
                  SizedBox(height: 28),
                  AppFormField(
                    title: AppLocalizations.of(context)!.password,
                    hint: AppLocalizations.of(context)!.passwordHint,
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return AppLocalizations.of(context)!.passwordHint;
                      }
                      return null;
                    },
                    sceuredPassword: true,
                    controler: password,
                  ),
                  SizedBox(height: 28),
                  AppFormField(
                    title: AppLocalizations.of(context)!.conformationPassword,
                    hint:
                        AppLocalizations.of(context)!.conformationPasswordHint,
                    keyboardType: TextInputType.text,
                    sceuredPassword: true,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return AppLocalizations.of(
                          context,
                        )!.conformationPasswordHint;
                      }
                      if (password.text != text) {
                        return "Please enter the correct password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 36),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signUp,
                      style: TextStyle(
                        fontSize: 18,
                        color: TodoTheme.appColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAccount,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routName,
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.singIn,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    createAccount();
  }

  void createAccount() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    try {
      showLoading(context);
      final appUser = await authProvider.createUserWithEmailAndPassword(
        email.text,
        password.text,
        fullName.text,
      );
      hideLoading(context);
      if (appUser == null) {
        showMessage(
          context,
          content: "somthing was wrong ",
          posButtonTitle: "try agan",
          posButtonClick: () {
            createAccount();
          },
        );
        return;
      }
      showMessage(
        context,
        content: "Account Created successful ",
        posButtonTitle: "ok",
        posButtonClick: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routName);
        },
      );
    } on FirebaseAuthException catch (e) {
      String message = "something was wrong";
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      hideLoading(context);
      showMessage(context, content: message, posButtonTitle: "ok");
    } catch (e) {
      String message = "something was wrong";
      hideLoading(context);
      showMessage(context, content: message, posButtonTitle: "ok");
    }
  }
}
