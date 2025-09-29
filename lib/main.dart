import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/app_provider.dart';
import 'package:todo_app/screens/todos_screen.dart';
import 'package:todo_app/style/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider()..getIsDark(),
      builder: (context, child) {
        return Consumer<AppProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: value.isDark ? AppThemes.darkTheme : AppThemes.lighTheme,
              home: TodosScreen(),
            );
          },
        );
      },
    );
  }
}
