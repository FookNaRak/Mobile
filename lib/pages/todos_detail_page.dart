import 'package:flutter/material.dart';

class TodosDetailPage extends StatefulWidget {
  final int todoId;
  final String initialText;

  const TodosDetailPage({
    super.key,
    required this.todoId,
    required this.initialText,
  });

  @override
  State<TodosDetailPage> createState() => _TodosDetailPageState();
}

class _TodosDetailPageState extends State<TodosDetailPage> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EditToDo")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(controller: _controller,validator: (value){
              if(value == null || value.trim().isEmpty){
                return "กรุณากรอกข้อมูลก่อนบันทึก";
              }
              return null;
            },),
            TextButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  Navigator.pop(context, _controller.text);
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
