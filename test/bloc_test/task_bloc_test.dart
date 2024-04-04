import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_events.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_state.dart';

import 'package:task_management/features/tasks/data/models/task.dart';
import 'package:task_management/features/tasks/data/repositories/memory_task_repository.dart';
import 'package:task_management/features/tasks/domain/usecases/task_use_case.dart';

class MockTaskUseCase extends Mock implements TaskUseCase {}

// Helper function to create a task list for testing
List<Task> createTasksList({int count = 2}) =>
    List.generate(count, (index) => Task(id: '$index', title: 'Task $index'));

void main() {
  late TaskUseCase mockTaskUseCase;
  final taskRepository = MemoryTaskRepository();

  setUp(() {
    mockTaskUseCase = TaskUseCase(taskRepository);
  });

  group('TasksBloc', () {
    blocTest<TasksBloc, TasksState>(
      'emits [] when initial state',
      build: () => TasksBloc(mockTaskUseCase),
      expect: () => [],
    );

    blocTest<TasksBloc, TasksState>(
      'emits [loading, updated] when adding a task',
      build: () => TasksBloc(mockTaskUseCase),
      act: (bloc) {
        bloc.add(InsertingTaskEvent(title: 'Task 0', id: '0'));
        bloc.add(InsertingTaskEvent(title: 'Task 1', id: '1'));
      },
      expect: () => [
        TasksState(tasks: [], isLoading: true),
        TasksState(tasks: createTasksList(), isLoading: false),
      ],
    );

    blocTest<TasksBloc, TasksState>(
      'emits [loading, updated] when removing a task',
      build: () => TasksBloc(mockTaskUseCase),
      seed: () => TasksState(tasks: createTasksList()),
      act: (bloc) => bloc.add(RemoveTaskEvent(id: '0')),
      expect: () => [
        TasksState(tasks: [...createTasksList()], isLoading: true),
        TasksState(tasks: [...createTasksList().skip(1)], isLoading: false),
      ],
    );
  });
}
