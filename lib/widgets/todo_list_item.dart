import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(
            todo.text,
            style: TextStyle(
              color: (todo.done) ? CupertinoColors.systemGrey : null,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              (todo.done)
                  ? CupertinoIcons.checkmark_alt
                  : CupertinoIcons.circle,
            ),
          )
        ],
      ),
    );
  }
}
