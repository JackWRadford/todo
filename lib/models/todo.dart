import 'package:flutter/material.dart';

class Todo with ChangeNotifier {
  var id = '';
  var _text = '';
  var _done = false;

  Todo(this._text);

  String get text => _text;
  bool get done => _done;

  set text(String value) {
    _text = value;
    notifyListeners();
  }

  set done(bool value) {
    _done = value;
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {
        'text': _text,
        'done': _done,
      };

  Todo.fromJson(this.id, dynamic data)
      : _text = data['text'],
        _done = data['done'];
}
