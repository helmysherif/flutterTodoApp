import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/widgets/task_item.dart';
import 'package:todo_app/shared/network/firebase/firebase_functions.dart';
import 'package:todo_app/styles/app_colors.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime date = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: DatePicker(
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: lightColor,
            height: 100,
            // inactiveDates: [DateTime.now().add(Duration(days: 2))],
            selectedTextColor: Colors.white,
            onDateChange: (newDate) {
              setState(() {
                date = newDate;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        StreamBuilder(
          stream:
              FireBaseFunctions.getTasksFromFireStore(DateUtils.dateOnly(date)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
            return tasks.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return TaskItem(tasks[index]);
                      },
                      itemCount: tasks.length,
                    ),
                  )
                : const Center(child: Text("There is no tasks in this date"));
          },
        )
      ],
    );
  }
}
