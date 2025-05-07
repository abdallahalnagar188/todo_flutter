import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/ui/auth/register/register_screen.dart';
import 'package:todo_flutter/ui/common/app_form_field.dart';
import 'package:todo_flutter/ui/common/dialog_utils.dart';
import 'package:todo_flutter/ui/them/todo_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../common/app_utils.dart';
import '../../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routName = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

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
                  Image.asset(MyImages.routeLogoIv,height:70,width: 100,),
                  SizedBox(height: 40),
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
                  SizedBox(height: 20),
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
                      login();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.singIn,
                      style: TextStyle(
                        fontSize: 18,
                        color: TodoTheme.appColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dontHaveAccount,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RegisterScreen.routName,
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.createAccount,
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

  void login() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    singIn();
  }

  void singIn() async {
    var authProvider = Provider.of<AppAuthProvider>(context,listen: false);

    try {
      showLoading(context);
      final appUser = await authProvider.signInWithEmailAndPassword(email.text, password.text);
      hideLoading(context);
      if(appUser == null){
        showMessage(
          context,
          content: "Something was wrong ",
          posButtonTitle: "try again",
          posButtonClick: () {
           singIn();
          },
        );
        return;
      }
      showMessage(
        context,
        content: "sing in successful ",
        posButtonTitle: "ok",
        posButtonClick: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routName);
        },
      );
     // print(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      String message = "something was wrong";
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      hideLoading(context);
      showMessage(context, content: message,posButtonTitle: "ok");
    } catch (e) {
      String message = "something was wrong";
      hideLoading(context);
      showMessage(context, content: message,posButtonTitle: "ok");
    }
  }
}
