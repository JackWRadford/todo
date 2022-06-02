import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todos.dart';

class AddEditTodoDialog extends StatefulWidget {
  final Todo? todo;

  const AddEditTodoDialog({Key? key, this.todo}) : super(key: key);

  @override
  State<AddEditTodoDialog> createState() => _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {
  final _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();

  var _isLoading = false;
  var _isLoadingDelete = false;

  @override
  void initState() {
    if (widget.todo != null) _textController.text = widget.todo!.text;
    super.initState();
  }

  /// Either adds or updates a Todo
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      if (widget.todo != null) {
        await Provider.of<Todos>(context, listen: false).updateTodo(
            Todo(_textController.text, widget.todo!.id, widget.todo!.done));
      } else {
        await Provider.of<Todos>(context, listen: false)
            .addTodo(_textController.text);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    }
    setState(() => _isLoading = false);
    Navigator.of(context).pop();
  }

  /// Delete todo
  Future<void> _delete() async {
    setState(() => _isLoadingDelete = true);
    try {
      await Provider.of<Todos>(context, listen: false)
          .deleteTodo(widget.todo!.id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    }
    setState(() => _isLoadingDelete = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        (widget.todo != null) ? 'Update Todo' : 'New Todo',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: 800,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text input
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _textController,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Delete button
                (widget.todo != null)
                    ? Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  CupertinoColors.destructiveRed)),
                          onPressed: _delete,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: (!_isLoadingDelete)
                                ? const Text('Delete')
                                : const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          CupertinoColors.white),
                                    ),
                                  ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(width: (widget.todo != null) ? 10 : 0),
                // Submit button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: (!_isLoading)
                          ? Text((widget.todo != null) ? 'Update' : 'Add')
                          : const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CupertinoColors.white),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
