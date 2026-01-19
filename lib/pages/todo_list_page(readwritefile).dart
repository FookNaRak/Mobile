// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:todo_app/pages/todo_detail_page.dart';

// class TodoListPage extends StatefulWidget {
//   const TodoListPage({super.key});

//   @override
//   State<TodoListPage> createState() => _TodoListPageState();
// }

// class _TodoListPageState extends State<TodoListPage> {
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _controller2 = TextEditingController();

//   List<dynamic> todos = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadTodosFromFile();
//   }

//   // ================= FILE PART =================

//   Future<File> _getTodoFile() async {
//     final dir = await getApplicationDocumentsDirectory();
//     return File('${dir.path}/todos.json');
//   }

//   Future<void> _saveTodosToFile() async {
//     final file = await _getTodoFile();
//     final jsonString = jsonEncode(todos.map((todo) {
//       return {
//         "title": todo[0],
//         "subtitle": todo[1],
//         "done": todo[2],
//       };
//     }).toList());

//     await file.writeAsString(jsonString);
//   }

//   Future<void> _loadTodosFromFile() async {
//     try {
//       final file = await _getTodoFile();
//       if (await file.exists()) {
//         final jsonString = await file.readAsString();
//         final List decoded = jsonDecode(jsonString);

//         setState(() {
//           todos = decoded.map((e) {
//             return [
//               e["title"],
//               e["subtitle"],
//               e["done"],
//             ];
//           }).toList();
//         });
//       }
//     } catch (e) {
//       debugPrint("Read file error: $e");
//     }
//   }

//   // =================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Todo App (File IO)")),
//       body: ListView.builder(
//         itemCount: todos.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               leading: IconButton(
//                 icon: const Icon(Icons.delete),
//                 onPressed: () {
//                   setState(() {
//                     todos.removeAt(index);
//                     _saveTodosToFile();
//                   });
//                 },
//               ),
//               title: Text(
//                 todos[index][0],
//                 style: TextStyle(
//                   decoration: todos[index][2]
//                       ? TextDecoration.lineThrough
//                       : TextDecoration.none,
//                 ),
//               ),
//               subtitle: Text(
//                 todos[index][1],
//                 style: TextStyle(
//                   decoration: todos[index][2]
//                       ? TextDecoration.lineThrough
//                       : TextDecoration.none,
//                 ),
//               ),
//               trailing: Checkbox(
//                 value: todos[index][2],
//                 onChanged: (value) {
//                   setState(() {
//                     todos[index][2] = value;
//                     _saveTodosToFile();
//                   });
//                 },
//               ),
//               onTap: () async {
//                 final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TodoDeatilPage(
//                       title: todos[index][0],
//                       subtitle: todos[index][1],
//                     ),
//                   ),
//                 );

//                 if (result != null) {
//                   setState(() {
//                     todos[index][0] = result["title"];
//                     todos[index][1] = result["subtitle"];
//                     _saveTodosToFile();
//                   });
//                 }
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: const Text("Add Todo"),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextField(
//                       controller: _controller,
//                       decoration:
//                           const InputDecoration(hintText: "title"),
//                     ),
//                     TextField(
//                       controller: _controller2,
//                       decoration:
//                           const InputDecoration(hintText: "subtitle"),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           todos.add([
//                             _controller.text,
//                             _controller2.text,
//                             false
//                           ]);
//                           _saveTodosToFile();
//                           _controller.clear();
//                           _controller2.clear();
//                           Navigator.pop(context);
//                         });
//                       },
//                       child: const Text("Save"),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
