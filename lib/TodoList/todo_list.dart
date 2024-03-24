import 'package:flutter/material.dart';
import 'package:my_app/TodoList/todo_list_edit.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _tasks = [];

  ondispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8.0),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "ToDo List",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Enter your task',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                              color: Color.fromARGB(255, 101, 101, 101)),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (_controller.text.isNotEmpty) {
                            _tasks.add(_controller.text);
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      );
                      debugPrint(_controller.text);
                      _controller.clear();
                    },
                    child: const Text("Add Task"),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tasks[index]),
                    trailing: SizedBox(
                      width: size.width * 0.24,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(
                                () {
                                  _navigateAndModifyTodoSelection(
                                      context, _tasks[index]);

                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(
                                () {
                                  _tasks.removeAt(index);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _navigateAndModifyTodoSelection(
      BuildContext context, String tasks) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TodoListEdit(),
        settings: RouteSettings(arguments: tasks),
      ),
    );
    if (result != null) {
      debugPrint(tasks);
      //Set state on same index after edit
      setState(() {
        _tasks[_tasks.indexOf(tasks)] = result as String;
      });
    }
  }
}
