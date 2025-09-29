import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/add_todo_provider.dart';
import 'package:todo_app/providers/app_provider.dart';
import 'package:todo_app/screens/add_todo_screen.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todos_provider.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider()..getAllTodos(),
      builder: (context, child) {
        final provider = context.read<TodosProvider>();
        final appProvider = context.read<AppProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Todos'),
            actions: [
              IconButton(
                onPressed: () {
                  appProvider.setIsDark();
                },
                icon: Icon(Icons.dark_mode),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodoScreen()),
              );
              if (result != null && result) {
                provider.getAllTodos();
              }
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Icon(Icons.add),
          ),
          body: Consumer<TodosProvider>(
            builder: (context, provider, child) {
              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final todo = provider.todos[index];
                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddTodoScreen(todo: todo, index: index),
                        ),
                      );
                      if (result != null && result) {
                        provider.getAllTodos();
                      }
                    },
                    child: Container(
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
                              provider.changeTodoCompletion(
                                index,
                                value ?? false,
                              );
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
                              provider.deleteBox(index);
                            },
                            icon: Icon(Icons.delete, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: provider.todos.length,
              );
            },
          ),
        );
      },
    );
  }
}
