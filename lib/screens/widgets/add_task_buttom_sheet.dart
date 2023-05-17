import 'package:flutter/material.dart';
import 'package:todo_app/styles/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  String selected = DateTime.now().toString().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add New Task",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black)),
            const SizedBox(height: 25),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please Enter task title";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: const Text("Task title"),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: lightColor),
                    borderRadius: BorderRadius.circular(18)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: lightColor),
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please Enter task title";
                }
                return null;
              },
              maxLines: 3,
              decoration: InputDecoration(
                label: const Text("Task Description"),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: lightColor),
                    borderRadius: BorderRadius.circular(18)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: lightColor),
                    borderRadius: BorderRadius.circular(18)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Select Date",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
                textAlign: TextAlign.start,
              ),
            ),
            InkWell(
              onTap: () {
                chooseDate();
              },
              child: Text(
                selected,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: lightColor),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                child: const Text("Add Task", style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void chooseDate() async {
    DateTime? selectedDate = await showDatePicker(
        builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme!.copyWith(
                      primary: Colors.red,
                      onSecondary: Colors.green,
                      onSurface: Colors.black)),
              child: child!,
            ),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (selectedDate != null) {
      selected = selectedDate.toString().substring(0, 10);
      setState(() {});
    }
  }
}
