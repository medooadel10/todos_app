import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/add_todo_provider.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTodoProvider(),
      builder: (context, child) {
        final provider = context.read<AddTodoProvider>();
        return Scaffold(
          appBar: AppBar(title: Text('Add ToDO')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: provider.formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    TextFormField(
                      controller: provider.titleController,
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
                      controller: provider.descriptionController,
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
                    Consumer<AddTodoProvider>(
                      builder: (context, value, child) {
                        return Row(
                          spacing: 5,
                          children: List.generate(provider.colors.length, (
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                value.changeColor(index);
                              },
                              child: CircleAvatar(
                                backgroundColor: provider.colors[index],
                                child: provider.selectedColor == index
                                    ? Icon(Icons.check, color: Colors.white)
                                    : null,
                              ),
                            );
                          }),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (provider.formKey.currentState!.validate()) {
                          provider.addTodo(context);
                        }
                      },
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
      },
    );
  }
}
