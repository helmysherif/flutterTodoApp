import 'package:flutter/material.dart';
import 'package:todo_app/screens/tasks.dart';
import '../screens/settings.dart';
import '../screens/widgets/add_task_buttom_sheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "home";

  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> tabs = [TasksTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Todo App"),
        // toolbarHeight: 100,
      ),
      body: tabs[index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskSheet();
        },
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 4)),
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomAppBar(
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconSize: 35,
            currentIndex: index,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 15,
                    child: Icon(Icons.list),
                  ),
                  label: ""),
              BottomNavigationBarItem(
                icon:
                    SizedBox(height: 15, child: Icon(Icons.settings_outlined)),
                label: "",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddTaskSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskBottomSheet(),
            ),
        isScrollControlled: true);
  }
}
