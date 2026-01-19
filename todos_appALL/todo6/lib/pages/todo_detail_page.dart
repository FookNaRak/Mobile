import 'package:flutter/material.dart';

class TodoDetailPage extends StatefulWidget {

  final int todoId;
  final String initialText;

  const TodoDetailPage({
    super.key,
    required this.todoId,
    required this.initialText});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {

  late TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo"),centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [TextFormField(controller: _controller,),
          TextButton(onPressed: (){
            if(_formKey.currentState!.validate()){
              Navigator.pop(context,_controller.text);
            }
          }, child: Text("enter"))],
        ),
      ),
    );
  }
}