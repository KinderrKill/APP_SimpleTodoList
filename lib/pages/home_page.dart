import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/task_dialog_box.dart';
import 'package:flutter_application_1/components/todo_tile.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final _myBox = Hive.box("myBox");
  TodoDatabase database = TodoDatabase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      database.createInitialData();
    } else {
      database.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(int index) {
    setState(() {
      database.todoList[index][1] = !database.todoList[index][1];
      database.updateData();
    });
  }

  void dialogBoxSave() {
    setState(() {
      database.todoList.add([_controller.text, false]);
      database.updateData();
    });

    _controller.clear();
    Navigator.of(context).pop();
  }

  void onTileDelete(int index) {
    setState(() {
      database.todoList.removeAt(index);
      database.updateData();
    });
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return TaskDialogBox(
            textController: _controller,
            onSave: dialogBoxSave,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("Simple Todo List"),
        centerTitle: true,
        toolbarHeight: 64,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => createNewTask(), child: const Icon(Icons.add)),
      body: ListView.builder(
        itemCount: database.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: database.todoList[index][0],
              taskCompleted: database.todoList[index][1],
              onChanged: (value) => checkBoxChanged(index),
              onDelete: (context) => onTileDelete(index));
        },
      ),
    );
  }
}
