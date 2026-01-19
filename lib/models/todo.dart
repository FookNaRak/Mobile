class Todo {
  final String title;
  final String subtitle;
  bool isDone;

  Todo({
    required this.title,
    required this.subtitle,
    this.isDone = false,
  });
  
  Map<String, dynamic> toMap(){
    return {
      "title":title,
      "subtitle":subtitle,
      "isDone":isDone,
    };
  }
  factory Todo.fromMap(Map<String,dynamic>map){
    return Todo(
      title: map["title"],
      subtitle: map["subtitle"],
      isDone: map["isDone"],
    );
  }
}