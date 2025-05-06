import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/ui/auth/login/login_screen.dart';
import 'package:todo_flutter/ui/auth/register/register_screen.dart';
import 'package:todo_flutter/ui/home/home_screen.dart';
import 'package:todo_flutter/ui/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return LanguageProvider();
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: CircleBorder(),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: {
        HomeScreen.routName: (_) => HomeScreen(),
        RegisterScreen.routName:(_) => RegisterScreen(),
        LoginScreen.routName:(_) => LoginScreen(),
      },
      initialRoute: LoginScreen.routName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale:Locale( languageProvider.currentLocale),
    );
  }
}
