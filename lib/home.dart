import 'package:flutter/material.dart';
import 'package:flutter_forms_files/models/todo.dart';
import 'package:flutter_forms_files/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  Priority _selectedPriority = Priority.low;
  String _title = '';
  String _description = '';

  final List<Todo> todos = [
    const Todo(
        title: 'Buy milk',
        description: 'There is no milk left in the fridge!',
        priority: Priority.high),
    const Todo(
        title: 'Make the bed',
        description: 'Keep things tidy please..',
        priority: Priority.low),
    const Todo(
        title: 'Pay bills',
        description: 'The gas bill needs paying ASAP.',
        priority: Priority.urgent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: TodoList(todos: todos)),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You must enter value mf.';
                      }
                      return null;
                    }, onSaved: (value) {
                      _title = value!;
                    }),
                    TextFormField(validator: (value) {
                      if (value == null || value.isEmpty || value.length < 5) {
                        return 'You must enter value mf. lakers in 5';
                      }
                      return null;
                    }, onSaved: (value) {
                      _description = value!;
                    }),
                    DropdownButtonFormField(
                      value: _selectedPriority,
                      items: Priority.values.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e.title));
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                      },
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            setState(() {
                              todos.add(Todo(
                                  title: _title,
                                  description: _description,
                                  priority: _selectedPriority));
                            });
                            _formKey.currentState!.reset();
                            _selectedPriority = Priority.low;
                          }
                        },
                        child: const Text('Add'))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
