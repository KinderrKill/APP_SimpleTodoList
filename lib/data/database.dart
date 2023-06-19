import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  final _myBox = Hive.box("myBox");

  void createInitialData() {
    todoList = [
      ["Ma première tâche", true],
      ["Glisse sur la gauche pour supprimer", false],
    ];
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}
