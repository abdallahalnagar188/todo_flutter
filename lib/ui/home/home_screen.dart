import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/listOfTodos/task_list_tap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../settings/settings_tap.dart';

class HomeScreen extends StatefulWidget {
  static String routName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newSelectedIndex = 0;
  var taps = [TaskslistTap(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: Colors.green.shade100,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 2)),
        elevation: 10,
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: newSelectedIndex,
          onTap: (selectedIndex) {
            setState(() {
              newSelectedIndex = selectedIndex;
            });
          },
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: AppLocalizations.of(context)!.listsTasksTap,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settingsTap,
            ),
          ],
        ),
      ),
      body: taps[newSelectedIndex],
    );
  }
}
