import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext) onDelete;

  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    TextDecoration textDecoration =
        taskCompleted ? TextDecoration.lineThrough : TextDecoration.none;

    Color? todoTileColor =
        taskCompleted ? Colors.yellow[400] : Colors.yellow[500];

    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Slidable(
            endActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                      onPressed: onDelete,
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0))),
                ]),
            child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: todoTileColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.black,
                  ),
                  Expanded(
                      child: Text(taskName,
                          style: TextStyle(decoration: textDecoration))),
                ]))));
  }
}
