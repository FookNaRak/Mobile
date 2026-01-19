import 'package:flutter/material.dart';

class TodoDeatilPage extends StatefulWidget {
  final String title;
  final String subtitle;

  const TodoDeatilPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<TodoDeatilPage> createState() => _TodoDeatilPageState();
}

class _TodoDeatilPageState extends State<TodoDeatilPage> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _subtitleController = TextEditingController(text: widget.subtitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Todo")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(controller: _titleController),
            TextFormField(controller: _subtitleController),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      "title": _titleController.text,
                      "subtitle": _subtitleController.text,
                    });
                  },
                  child: Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
