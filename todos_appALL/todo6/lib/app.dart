import 'package:flutter/material.dart';
import 'package:todos_app/pages/todo_list_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo App",
      theme: ThemeData(useMaterial3: true),
      home: const TodoListPage(),
    );
  }
}