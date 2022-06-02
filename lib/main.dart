import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todos.dart';
import 'package:todo/widgets/add_edit_todo_dialog.dart';
import 'package:todo/widgets/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Todos>(
      create: ((_) => Todos()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isLoading = false;

  @override
  void initState() {
    setState(() => _isLoading = true);
    Provider.of<Todos>(context, listen: false)
        .fetchTodos()
        .then((_) => setState(() => _isLoading = false));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(CupertinoIcons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const AddEditTodoDialog(),
            );
          }),
      body: (!_isLoading)
          ? const TodoList()
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
