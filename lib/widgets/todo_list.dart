import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todos.dart';
import 'package:todo/widgets/todo_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Todos>(context, listen: false).fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todosProvider = Provider.of<Todos>(context);
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: ListView.builder(
        itemCount: todosProvider.todoList.length,
        itemBuilder: (_, i) => TodoListItem(todo: todosProvider.todoList[i]),
      ),
    );
  }
}
