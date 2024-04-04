import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_events.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_state.dart';
import 'add_task_view.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksBloc = BlocProvider.of<TasksBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        bloc: tasksBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.tasks.isEmpty) {
            return const Center(
              child: Text('No Task Available'),
            );
          }

          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return Dismissible(
                key: Key(task.id),
                onDismissed: (_) => tasksBloc.add(RemoveTaskEvent(id: task.id)),
                child: ListTile(
                  title: Text(task.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        tasksBloc.add(RemoveTaskEvent(id: task.id)),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BlocProvider.value(value: tasksBloc, child: AddTaskView())),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
