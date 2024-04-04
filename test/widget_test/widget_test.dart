import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_state.dart';
import 'package:task_management/features/tasks/data/models/task.dart';
import 'package:task_management/features/tasks/data/repositories/memory_task_repository.dart';
import 'package:task_management/features/tasks/domain/usecases/task_use_case.dart';
import 'package:task_management/features/tasks/presentation/views/task_list_view.dart';

void main() {
  group('TaskListView Widget Test', () {
    final taskRepository = MemoryTaskRepository();

    testWidgets('Renders "No Task Available" when tasks list is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => TasksBloc(TaskUseCase(taskRepository)),
            child: TaskListView(),
          ),
        ),
      );

      expect(find.text('No Task Available'), findsOneWidget);
    });

    testWidgets('Renders tasks list when tasks are available',
        (WidgetTester tester) async {
      final tasks = [
        Task(id: '1', title: 'Task 1'),
        Task(id: '2', title: 'Task 2'),
      ];
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: TasksBloc(TaskUseCase(taskRepository))
              ..emit(TasksState(tasks: tasks)),
            child: TaskListView(),
          ),
        ),
      );

      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });
  });
}
