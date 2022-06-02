import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/hide_me.dart';
import 'package:http/http.dart' as http;

class TodoProvider extends ChangeNotifier {
  /// List of all todos
  var todoList = <Todo>[];

  /// Firebase base URL
  static const _baseUrl = baseUrl;

  /// Add new Todo
  Future<void> addTodo(String text) async {
    // Create new todo
    Todo todo = Todo(text);

    Uri url = Uri.parse('$_baseUrl/todos.json');
    // Attempt to add todo to database
    try {
      http.post(url, body: jsonEncode(todo.toJson()));
    } catch (e) {
      if (kDebugMode) print(e);
    }

    // Add new todo locally
    todoList.add(todo);
  }

  /// Update a Todo
  Future<void> updateTodo(Todo todo) async {}
}
