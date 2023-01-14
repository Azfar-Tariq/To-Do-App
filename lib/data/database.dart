import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];

  final _mybox = Hive.box('mybox');

  void createInitialData() {
    todoList = [
      ["Welcome to ToDo App", true],
      ["Swipe to Delete Task", false],
    ];
  }

  void loadData() {
    todoList = _mybox.get("TODOLIST");
  }

  void updateDatabase() {
    _mybox.put("TODOLIST", todoList);
  }
}
