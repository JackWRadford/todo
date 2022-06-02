import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/hide_me.dart';
import 'package:http/http.dart' as http;

class Todos with ChangeNotifier {
  /// List of all todos
  var _todoList = <Todo>[];

  List<Todo> get todoList {
    return [..._todoList];
  }

  /// Firebase base URL
  static const _baseUrl = baseUrl;

  /// Fetch all Todos
  Future<void> fetchTodos() async {
    if (kDebugMode) {
      print('CALLED SERVER: fetchTodos()');
    }
    final url = Uri.parse('$_baseUrl/todos.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) throw Error();
      final todoData = json.decode(response.body) as Map<String, dynamic>;
      final todos = <Todo>[];
      todoData.forEach((todoId, todoData) {
        todos.add(Todo.fromJson(todoId, todoData));
      });
      _todoList = todos;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Add new Todo
  Future<void> addTodo(String text) async {
    if (kDebugMode) {
      print('CALLED SERVER: addTodo()');
    }
    final url = Uri.parse('$_baseUrl/todos.json');
    try {
      final response =
          await http.post(url, body: jsonEncode(Todo(text).toJson()));
      if (response.statusCode >= 400) throw Error();
      final todo = Todo(text);
      todo.id = jsonDecode(response.body)['name'];
      _todoList.add(todo);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  /// Update a Todo
  Future<void> updateTodo(Todo todo) async {
    if (kDebugMode) {
      print('CALLED SERVER: updateTodo()');
    }
    final todoIndex = _todoList.indexWhere((t) => t.id == todo.id);
    if (todoIndex < 0) return;
    final url = Uri.parse('$_baseUrl/todos/${todo.id}.json');
    try {
      var response = await http.patch(url, body: jsonEncode(todo.toJson()));
      if (response.statusCode >= 400) throw Error();
      _todoList[todoIndex] = todo;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Delete a Todo
  Future<void> deleteTodo(int id) async {}
}
