import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/add_todo_screen.dart';
import 'package:todo_app/models/todo_model.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  List<TodoModel> todos = [];
  void getAllTodos() async {
    final box = await Hive.openBox<TodoModel>('todosBox');
    setState(() {
      todos = box.values.toList();
    });
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

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
          if (result != null && result) {
            getAllTodos();
          }
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final todo = todos[index];
          return Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(todo.color),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              spacing: 5,
              children: [
                Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    changeTodoCompletion(index, value ?? false);
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        todo.description.trim(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deleteBox(index);
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: todos.length,
      ),
    );
  }
}
