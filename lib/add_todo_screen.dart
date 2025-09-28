import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<Color> colors = [Colors.blue, Colors.red, Colors.purple];
  int selectedColor = 0;

  void addTodo() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add ToDO')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 16,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter todo title',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter todo title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter todo description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter todo description';
                    }
                    return null;
                  },
                ),
                Row(
                  spacing: 5,
                  children: List.generate(colors.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = index;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: colors[index],
                        child: selectedColor == index
                            ? Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  }),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addTodo();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Add Todo',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
