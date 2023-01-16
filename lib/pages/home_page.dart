import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final _controller = TextEditingController();

  final _myBox = Hive.box('mybox');

  ToDoDatabase _database = ToDoDatabase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      _database.createInitialData();
    } else {
      _database.loadData();
    }
    super.initState();
  }

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      _database.todoList[index][1] = !_database.todoList[index][1];
    });
    _database.updateDatabase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      _database.todoList.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.clear();
    });
    _database.updateDatabase();
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      _database.todoList.removeAt(index);
    });
    _database.updateDatabase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: _database.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: _database.todoList[index][0],
            taskCompleted: _database.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
