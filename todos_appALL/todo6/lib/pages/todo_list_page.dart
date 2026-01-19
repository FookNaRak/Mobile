import 'package:flutter/material.dart';
import 'package:todos_app/pages/todo_detail_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ToDoList"), centerTitle: true),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: TextButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(onPressed: (){
                          setState(() {
                            todos.removeAt(index);
                            Navigator.pop(context);
                          });
                        }, child: Text("confirm")),
                      TextButton(onPressed: (){Navigator.pop(context);}, child: Text("cancel"))
                      ],
                    )
                  );
                });
              }, child: Icon(Icons.remove)),
              title: Text(
                todos[index][0],
                style: TextStyle(
                  decoration: todos[index][1]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                value: todos[index][1],
                onChanged: (value) {
                  setState(() {
                    todos[index][1] = value;
                  });
                },
              ),
              onTap: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => TodoDetailPage(todoId:index,initialText:todos[index][0])));
                if(result != null){
                  setState(() {
                    todos[index][0] = result;
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.blue,
                content: Container(
                  height: 60,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(hint: Text("Enter Todo")),
                          validator: (value) {
                            if(value == null || value.trim().isEmpty){
                              return "please Fill Todo";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        todos.add([_controller.text, false]);
                        _controller.clear();
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Save"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
