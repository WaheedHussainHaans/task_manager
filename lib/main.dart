import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/tasks/data/repositories/memory_task_repository.dart';
import 'package:task_management/features/tasks/presentation/views/task_list_view.dart';

import 'features/tasks/data/bloc/tasks_bloc/tasks_bloc.dart';
import 'features/tasks/domain/usecases/task_use_case.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final taskRepository = MemoryTaskRepository();

    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TasksBloc>(
        create: (context) => TasksBloc(
          TaskUseCase(taskRepository),
        ),
        child: const TaskListView(),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
