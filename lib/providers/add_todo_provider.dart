import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';

class AddTodoProvider extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<Color> colors = [Colors.blue, Colors.red, Colors.purple];
  int selectedColor = 0;

  void addTodo(BuildContext context) async {
    final box = await Hive.openBox<TodoModel>('todosBox');
    final todo = TodoModel(
      title: titleController.text,
      description: descriptionController.text,
      createdAt: DateTime.now().toString(),
      color: colors[selectedColor].value,
    );
    await box.add(todo);
    Navigator.pop(context, true);
  }

  void changeColor(int index) {
    selectedColor = index;
    notifyListeners();
  }
}
