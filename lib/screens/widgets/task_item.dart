import 'package:flutter/material.dart';
import 'package:todo_app/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7, top: 5),
      child: Card(
        elevation: 12,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 80,
              width: 5,
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
              decoration: BoxDecoration(
                  color: lightColor, borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task Title",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: lightColor),
                ),
                Text(
                  "Task description",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 15),
                )
              ],
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(right: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                decoration: BoxDecoration(
                    color: lightColor, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.done, color: Colors.white, size: 30))
          ],
        ),
      ),
    );
  }
}
