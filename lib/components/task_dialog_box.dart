import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/task_box_button.dart';

class TaskDialogBox extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const TaskDialogBox(
      {super.key,
      required this.textController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();
    _focusNode.requestFocus();

    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 120,
        child: Column(children: [
          TextField(
            focusNode: _focusNode,
            controller: textController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nouvelle tâche",
                contentPadding: EdgeInsets.all(10)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TaskBoxButton(text: "Ajouter", onPressed: () => onSave()),
              TaskBoxButton(text: "Annuler", onPressed: () => onCancel()),
            ],
          )
        ]),
      ),
    );
  }
}
