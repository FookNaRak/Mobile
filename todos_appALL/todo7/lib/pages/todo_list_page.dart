import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/todo_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _subtitle = TextEditingController();

  List<dynamic> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  // ================= SAVE =================
  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> todoStringList =
        todos.map((todo) => jsonEncode(todo)).toList();
    await prefs.setStringList("todos", todoStringList);
  }

  // ================= LOAD =================
  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? todoStringList = prefs.getStringList("todos");

    if (todoStringList != null) {
      setState(() {
        todos =
            todoStringList.map((todo) => jsonDecode(todo)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App")),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  setState(() {
                    todos.removeAt(index);
                    saveTodos(); // ⭐
                  });
                },
              ),
              title: Text(
                todos[index][0],
                style: TextStyle(
                  color: Colors.white,
                  decoration: todos[index][2]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                todos[index][1],
                style: TextStyle(
                  color: Colors.white70,
                  decoration: todos[index][2]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                value: todos[index][2],
                onChanged: (value) {
                  setState(() {
                    todos[index][2] = value;
                    saveTodos(); // ⭐
                  });
                },
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoDeatilPage(
                      title: todos[index][0],
                      subtitle: todos[index][1],
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    todos[index][0] = result["title"];
                    todos[index][1] = result["subtitle"];
                    saveTodos(); // ⭐
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Todo"),
                content: Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _title,
                        decoration:
                            const InputDecoration(hintText: "Title"),
                      ),
                      TextFormField(
                        controller: _subtitle,
                        decoration:
                            const InputDecoration(hintText: "Subtitle"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                todos.add(
                                    [_title.text, _subtitle.text, false]);
                                saveTodos(); // ⭐
                                _title.clear();
                                _subtitle.clear();
                                Navigator.pop(context);
                              });
                            },
                            child: const Text("Add Todo"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
