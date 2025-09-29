import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';

class TodosProvider extends ChangeNotifier {
  List<TodoModel> todos = [];
  void getAllTodos() async {
    final box = await Hive.openBox<TodoModel>('todosBox');
    todos = box.values.toList();
    notifyListeners();
  }

  void deleteBox(int index) async {
    final box = await Hive.openBox<TodoModel>('todosBox');
    await box.deleteAt(index);
    getAllTodos();
  }

  void changeTodoCompletion(int index, bool value) async {
    final box = await Hive.openBox<TodoModel>('todosBox');
    final todo = todos[index];
    todo.isCompleted = value;
    await box.putAt(index, todo);
    getAllTodos();
  }
}
