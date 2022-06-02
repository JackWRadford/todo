class Todo {
  String id;
  bool done;
  var text = '';

  Todo(this.text, [this.id = '', this.done = false]);

  Map<String, dynamic> toJson() => {
        'text': text,
        'done': done,
      };

  Todo.fromJson(this.id, dynamic data)
      : text = data['text'],
        done = data['done'];
}
