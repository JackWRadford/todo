class Todo {
  var _text = '';
  var _done = false;

  Todo(this._text);

  String get text => _text;
  bool get done => _done;

  set text(String value) => text = value;
  set done(bool value) => done = value;

  Map<String, dynamic> toJson() => {
        'text': _text,
        'done': _done,
      };

  Todo.fromJson(Map<String, dynamic> json)
      : _text = json['text'],
        _done = json['done'];
}
