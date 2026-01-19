import 'package:flutter/material.dart';
import 'pages/todos_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo App",
      theme: ThemeData(useMaterial3: true),
      home: const TodosListPage(),
    );
  }
}