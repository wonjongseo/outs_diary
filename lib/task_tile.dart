import 'package:flutter/material.dart';

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
}

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, this.task});

  final Task? task;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBGClr(task?.color ?? 0)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task?.title ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${task!.startTime} - ${task!.endTime}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[100],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    task?.note ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[100],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: .5,
              color: Colors.grey[200]!.withOpacity(.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task!.isCompleted == 1 ? 'COMPLETED' : 'TODO',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getBGClr(int index) {
    switch (index) {
      // case 0:
      //   return primaryClr;
      // case 1:
      //   return pinkClr;
      // case 2:
      //   return yellowClr;

      default:
        return Colors.pinkAccent;
    }
  }
}
