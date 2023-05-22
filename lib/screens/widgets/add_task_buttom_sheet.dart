import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/network/firebase/firebase_functions.dart';
import 'package:todo_app/styles/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  DateTime selected = DateUtils.dateOnly(DateTime.now());
  var titleController = TextEditingController();
  var descController = TextEditingController();

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
              controller: titleController,
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
              controller: descController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please Enter task desc";
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
                selected.toString().substring(0, 10),
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
                  if (formKey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        dateOfTime: DateTime.now().microsecondsSinceEpoch,
                        title: titleController.text,
                        description: descController.text,
                        date: selected.microsecondsSinceEpoch,
                        status: false);
                    FireBaseFunctions.addTaskToFireStore(task).then((value) {
                      Navigator.pop(context);
                    });
                  }
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
      selected = DateUtils.dateOnly(selectedDate);
      setState(() {});
    }
  }
}
