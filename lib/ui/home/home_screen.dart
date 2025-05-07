import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/ui/auth/login/login_screen.dart';
import 'package:todo_flutter/ui/common/dialog_utils.dart';
import 'package:todo_flutter/ui/listOfTodos/task_list_tap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../common/add_task_bottom_sheet.dart';
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
    var authProvider = Provider.of<AppAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${authProvider.appUser!.fullName}"),
        actions: [
          InkWell(
            onTap: () {
              showMessage(
                context,
                content: "Do You need to Log out ?",
                posButtonTitle: "Ok",
                posButtonClick: () {
                  authProvider.logout();
                  Navigator.pushReplacementNamed(context, LoginScreen.routName);
                },
                negButtonTitle: "No",
                negButtonClick: () {
                },
              );
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: Colors.green.shade100,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 2)),
        elevation: 10,
        onPressed: () {
          showAddTaskBottomSheet();
        },
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

  void showAddTaskBottomSheet() {

    showModalBottomSheet(context: context, builder: (_) {
      return AddTaskBottomSheet();
    },backgroundColor: Colors.transparent);
  }
}
