import 'package:flutter/material.dart';
import 'package:todo_app/pages/todo_list_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo APP",
      theme: ThemeData(useMaterial3: true),
      home: TodoListPage(),
    );
  }
}
