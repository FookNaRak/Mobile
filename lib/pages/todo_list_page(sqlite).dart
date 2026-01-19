// import 'package:flutter/material.dart';
// import '../db/todo_db.dart';
// import '../models/todo.dart';

// class TodoListPage extends StatefulWidget {
//   const TodoListPage({super.key});

//   @override
//   State<TodoListPage> createState() => _TodoListPageState();
// }

// class _TodoListPageState extends State<TodoListPage> {
//   final TextEditingController _titleCtrl = TextEditingController();
//   final TextEditingController _subCtrl = TextEditingController();

//   List<Todo> todos = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadTodos();
//   }

//   Future<void> _loadTodos() async {
//     final data = await TodoDB.instance.getTodos();
//     setState(() {
//       todos = data;
//     });
//   }

//   Future<void> _addTodo() async {
//     final todo = Todo(
//       title: _titleCtrl.text,
//       subtitle: _subCtrl.text,
//       done: false,
//     );

//     await TodoDB.instance.insertTodo(todo);
//     _titleCtrl.clear();
//     _subCtrl.clear();
//     _loadTodos();
//   }

//   Future<void> _updateTodo(Todo todo) async {
//     await TodoDB.instance.updateTodo(todo);
//     _loadTodos();
//   }

//   Future<void> _deleteTodo(int id) async {
//     await TodoDB.instance.deleteTodo(id);
//     _loadTodos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Todo App (SQLite)")),
//       body: ListView.builder(
//         itemCount: todos.length,
//         itemBuilder: (context, index) {
//           final todo = todos[index];

//           return Card(
//             child: ListTile(
//               leading: IconButton(
//                 icon: const Icon(Icons.delete),
//                 onPressed: () => _deleteTodo(todo.id!),
//               ),
//               title: Text(
//                 todo.title,
//                 style: TextStyle(
//                   decoration:
//                       todo.done ? TextDecoration.lineThrough : null,
//                 ),
//               ),
//               subtitle: Text(todo.subtitle),
//               trailing: Checkbox(
//                 value: todo.done,
//                 onChanged: (value) {
//                   _updateTodo(
//                     Todo(
//                       id: todo.id,
//                       title: todo.title,
//                       subtitle: todo.subtitle,
//                       done: value!,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text("Add Todo"),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: _titleCtrl,
//                     decoration:
//                         const InputDecoration(hintText: "Title"),
//                   ),
//                   TextField(
//                     controller: _subCtrl,
//                     decoration:
//                         const InputDecoration(hintText: "Subtitle"),
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       _addTodo();
//                       Navigator.pop(context);
//                     },
//                     child: const Text("Save"),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
