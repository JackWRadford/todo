import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todos.dart';

class TodoDoneBtn extends StatefulWidget {
  final Todo todo;

  const TodoDoneBtn({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoDoneBtn> createState() => _TodoDoneBtnState();
}

class _TodoDoneBtnState extends State<TodoDoneBtn> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _updateTodo() async {
      setState(() => _isLoading = true);
      try {
        await Provider.of<Todos>(context, listen: false).updateTodo(
            Todo(widget.todo.text, widget.todo.id, !widget.todo.done));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')),
        );
      }
      setState(() => _isLoading = false);
    }

    return (!_isLoading)
        ? IconButton(
            onPressed: () => _updateTodo(),
            icon: Icon(
              (widget.todo.done)
                  ? CupertinoIcons.checkmark_alt
                  : CupertinoIcons.circle,
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(15),
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(CupertinoColors.black),
                strokeWidth: 2,
              ),
            ),
          );
  }
}
