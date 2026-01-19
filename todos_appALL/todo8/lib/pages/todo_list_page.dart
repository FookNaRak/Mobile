import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/todo_detail_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  List<dynamic> todos = [
    ["Learn", "Flutter", false],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: ElevatedButton(
                onPressed: () {
                  setState(() {
                    todos.removeAt(index);
                  });
                },
                child: Icon(Icons.remove),
              ),
              title: Text(
                todos[index][0],
                style: TextStyle(
                  decoration: todos[index][2]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                todos[index][1],
                style: TextStyle(
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
                  });
                },
              ),
              onTap: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => TodoDeatilPage(title: todos[index][0], subtitle: todos[index][1])));
                if(result != null){
                  setState(() {
                    todos[index][0] = result["title"];
                    todos[index][1] = result["subtitle"];
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Todo"),
                content: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(hint: Text("title")),
                      ),
                      TextFormField(
                        controller: _controller2,
                        decoration: InputDecoration(hint: Text("subtitle")),
                      ),
                      Row(
                        children: [
                          ElevatedButton(onPressed: () {
                            setState(() {
                              todos.add([_controller.text,_controller2.text,false]);
                              Navigator.pop(context);
                              _controller.clear();
                              _controller2.clear();
                            });
                          }, child: Text("Save")),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("cancel"),
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
