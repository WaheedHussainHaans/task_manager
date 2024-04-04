// presentation/add_task_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_events.dart';

class AddTaskView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksBlock = BlocProvider.of<TasksBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a task title'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    tasksBlock
                        .add(InsertingTaskEvent(title: _titleController.text));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
