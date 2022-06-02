import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/add_edit_todo_dialog.dart';
import 'package:todo/widgets/todo_done_btn.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  const TodoListItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showDialog(
            context: context, builder: (_) => AddEditTodoDialog(todo: todo));
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  todo.text,
                  style: TextStyle(
                    color: (todo.done) ? CupertinoColors.systemGrey : null,
                  ),
                ),
              ),
              TodoDoneBtn(todo: todo),
            ],
          ),
        ),
      ),
    );
  }
}
