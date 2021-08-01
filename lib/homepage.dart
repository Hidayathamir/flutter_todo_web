import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controllerAddTodo;
  List<Map<String, dynamic>> _todos = [
    {'todo': 'Eat fruit', 'done': true},
    {'todo': 'Exercise 30 M', 'done': true},
    {'todo': 'Learn program', 'done': false},
    {'todo': 'Learn language', 'done': false},
  ];

  @override
  void initState() {
    super.initState();
    _controllerAddTodo = TextEditingController();
  }

  @override
  void dispose() {
    _controllerAddTodo.dispose();
    super.dispose();
  }

  addTodo() {
    setState(() {
      _todos.add({'todo': _controllerAddTodo.text, 'done': false});
    });
    _controllerAddTodo.clear();
  }

  removeTodo(int index) {
    setState(() => _todos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.blue])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 600,
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: TextField(
                            controller: _controllerAddTodo,
                            decoration: InputDecoration(
                              labelText: 'Add Your Todo',
                              hintText: 'Play ...',
                              counterText: '',
                              suffixIcon: Tooltip(
                                message: 'Clear',
                                child: IconButton(
                                  onPressed: _controllerAddTodo.clear,
                                  icon: Icon(Icons.clear),
                                ),
                              ),
                            ),
                            maxLength: 65,
                            onSubmitted: (String value) => addTodo(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Tooltip(
                          message: 'Add Todo',
                          child: IconButton(
                            color: Colors.blue,
                            onPressed: () => addTodo(),
                            icon: Icon(Icons.send),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    height: 500,
                    child: showTodos(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showTodos() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: statusTodo(index),
            title: Text(_todos[index]['todo']),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.red),
              onPressed: () => removeTodo(index),
            ),
          ),
        );
      },
    );
  }

  Widget statusTodo(index) {
    if (_todos[index]['done']) {
      return IconButton(
        onPressed: () {
          setState(() => _todos[index]['done'] = false);
        },
        icon: Icon(Icons.check_circle, color: Colors.green),
      );
    }
    return IconButton(
      onPressed: () {
        setState(() => _todos[index]['done'] = true);
      },
      icon: Icon(Icons.check_circle, color: Colors.grey),
    );
  }
}
