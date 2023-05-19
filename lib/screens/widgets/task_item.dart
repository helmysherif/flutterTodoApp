import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/shared/network/firebase/firebase_functions.dart';
import 'package:todo_app/styles/app_colors.dart';
import 'package:todo_app/models/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Card(
        elevation: 12,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent)),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.5,
            children: [
              SlidableAction(
                onPressed: (context) {
                  FireBaseFunctions.deleteTask(task.id);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                autoClose: true,
                label: 'Delete',
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
              ),
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
                autoClose: true,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 5),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 80,
                  width: 5,
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  decoration: BoxDecoration(
                      color: task.status ? greenColor : lightColor,
                      borderRadius: BorderRadius.circular(12)),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: task.status ? greenColor : lightColor),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        task.description,
                        maxLines: 10,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 15),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                task.status
                    ? Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: Text("Done!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: greenColor)))
                    : InkWell(
                        onTap: () {
                          task.status = true;
                          FireBaseFunctions.updateTask(task.id, task);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 3),
                            decoration: BoxDecoration(
                                color: lightColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.done,
                                color: Colors.white, size: 30)),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
