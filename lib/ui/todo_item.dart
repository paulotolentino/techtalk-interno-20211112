import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String task;
  final int index;
  final Function removeFunction;
  const TodoItem({Key? key, required this.task, required this.index, required this.removeFunction})
      : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.task,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                widget.removeFunction(widget.index);
              },
              child: const Text('Remover'),
            ),
          ),
        ],
      ),
    );
  }
}
