import 'package:flutter/material.dart';
import 'package:todos_app/pages/todos_detail_page.dart';

class TodosListPage extends StatefulWidget {
  const TodosListPage({super.key});

  @override
  State<TodosListPage> createState() => _TodosListPageState();
}

class _TodosListPageState extends State<TodosListPage> {

  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<List<dynamic>> todos = [
    ["Learn Flutter",false],
    ["Learn Django", false]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text("ToDoList"),centerTitle: true,backgroundColor: const Color.fromARGB(255, 0, 173, 253),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: Dismissible(
              key: ValueKey(todos[index][0]),
              direction: DismissDirection.endToStart,
              onDismissed: (direction){
                setState(() {
                  todos.removeAt(index);
                });
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete),
              ),
              child: ListTile(
                title: Text(todos[index][0],style: TextStyle(decoration: todos[index][1] ? TextDecoration.lineThrough :TextDecoration.none),),
                trailing: Checkbox(value: todos[index][1], onChanged: (value){
                  setState(() {
                    todos[index][1] = value;
                  });
                }),
                onTap: () async {
                  final result = await Navigator.push(context,MaterialPageRoute(builder: (context) => TodosDetailPage(todoId:index,initialText: todos[index][0],)));
                  if (result != null){
                    setState(() {
                      todos[index][0] = result;
                    });
                  }
                },
              ),
            ),
          );
        },),
        floatingActionButton: FloatingActionButton(onPressed: (){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 107, 160, 187),
              content: Container(
                height: 80,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(hint: Text("Enter ToDo",style: TextStyle(color: Colors.white),)),
                        validator: (value) {
                          if(value == null || value.trim().isEmpty){
                            return "Please Fill Todo";
                          }
                          return null;
                        },
                      ),
                      ],
                  ),
                ),
              ),
              actions: [TextButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  setState(() {
                    todos.add([_controller.text,false]);
                  });
                  _controller.clear();
                  Navigator.pop(context);
                }
              }, child: Text("Save")),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel"))],
            );
          });
        },
        child: Icon(Icons.add),),
    );
  }
}