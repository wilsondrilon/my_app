import 'package:flutter/material.dart';

class TodoListEdit extends StatefulWidget {
  const TodoListEdit({super.key});

  @override
  State<TodoListEdit> createState() => _TodoListEditState();
}

class _TodoListEditState extends State<TodoListEdit> {
  final TextEditingController _controller = TextEditingController();

  ondispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textForeColor = const Color.fromARGB(255, 103, 103, 103);

    var taskDescription = ModalRoute.of(context)!.settings.arguments as String?;

    _controller.text = taskDescription!;

    //Log value of taskDescription
    debugPrint(taskDescription);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text("Edit Todo List",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Enter your task',
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: size.width * 0.66,
                        child: ElevatedButton(
                          onPressed: () => {
                            // Navigator pop to previous screen with the edited task
                            taskDescription = _controller.text,
                            debugPrint(taskDescription),
                            FocusScope.of(context).requestFocus(FocusNode()),
                            Navigator.pop(context, taskDescription),
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 73, 173, 255),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                          child: const Text("Save Todo"),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: size.width * 0.3,
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.pop(context),
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            foregroundColor: textForeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
