import 'package:flutter/material.dart';
import 'package:ps20211103/ui/todo_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Minha lista de tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _taskList = [];
  String _task = "";

  void addToList() {
    setState(() {
      _taskList.add(_task);
    });
    _formKey.currentState!.reset();
  }

  void removeFromList(int index) {
    setState(() {
      _taskList.removeAt(index);
    });
  }

  void setTask(value) {
    setState(() {
      _task = value;
    });
  }

  void removeAll() {
    setState(() {
      _taskList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double containerWidth = width * 0.50;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.all(10.0),
          color: Colors.blue[100],
          width: containerWidth,
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Digite a tarefa',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite alguma tarefa';
                        }
                        else if (_taskList.contains(_task)) {
                          return 'Tarefa repetida';
                        }
                        return null;
                      },
                      onChanged: setTask,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                addToList();
                              }
                            },
                            child: const Text('Adicionar'),
                          ),
                          _taskList.isNotEmpty ? ElevatedButton(
                            onPressed: removeAll,
                            child: const Text('Remover todos'),
                          ) : const Text('Lista vazia'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _taskList.length,
                  itemBuilder: (_, int index) {
                    return TodoItem(
                        task: _taskList[index],
                        index: index,
                        removeFunction: removeFromList);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
