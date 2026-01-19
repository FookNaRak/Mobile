// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todo_app/pages/todo_detail_page.dart';

// class TodoListPage extends StatefulWidget {
//   const TodoListPage({super.key});

//   @override
//   State<TodoListPage> createState() => _TodoListPageState();
// }

// class _TodoListPageState extends State<TodoListPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _controller2 = TextEditingController();

//   List<dynamic> todos = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadTodos();
//   }

//   // -------------------- Preference --------------------

//   Future<void> _saveTodos() async {
//     final prefs = await SharedPreferences.getInstance();

//     List<String> todoStrings = todos.map((todo) {
//       return jsonEncode({
//         "title": todo[0],
//         "subtitle": todo[1],
//         "done": todo[2],
//       });
//     }).toList();

//     await prefs.setStringList("todos", todoStrings);
//   }

//   Future<void> _loadTodos() async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String>? todoStrings = prefs.getStringList("todos");

//     if (todoStrings != null) {
//       setState(() {
//         todos = todoStrings.map((str) {
//           final data = jsonDecode(str);
//           return [
//             data["title"],
//             data["subtitle"],
//             data["done"],
//           ];
//         }).toList();
//       });
//     }
//   }

//   // ----------------------------------------------------

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Todo App")),
//       body: ListView.builder(
//         itemCount: todos.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               leading: ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     todos.removeAt(index);
//                     _saveTodos();
//                   });
//                 },
//                 child: const Icon(Icons.remove),
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
//                     _saveTodos();
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
//                     _saveTodos();
//                   });
//                 }
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: const Text("Add Todo"),
//                 content: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextFormField(
//                         controller: _controller,
//                         decoration:
//                             const InputDecoration(hintText: "title"),
//                       ),
//                       TextFormField(
//                         controller: _controller2,
//                         decoration:
//                             const InputDecoration(hintText: "subtitle"),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 todos.add([
//                                   _controller.text,
//                                   _controller2.text,
//                                   false
//                                 ]);
//                                 _saveTodos();
//                                 Navigator.pop(context);
//                                 _controller.clear();
//                                 _controller2.clear();
//                               });
//                             },
//                             child: const Text("Save"),
//                           ),
//                           const SizedBox(width: 10),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text("Cancel"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
