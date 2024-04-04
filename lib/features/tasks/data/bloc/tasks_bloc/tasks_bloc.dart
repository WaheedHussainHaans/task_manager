import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_events.dart';
import 'package:task_management/features/tasks/data/bloc/tasks_bloc/tasks_state.dart';

import '../../../domain/usecases/task_use_case.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskUseCase tasksUseCase;

  TasksBloc(
    this.tasksUseCase,
  ) : super(TasksState(tasks: [])) {
    on<TasksEvent>((event, emit) async {
      ///
      ///
      ///
      if (event is InsertingTaskEvent) {
        if (event.title.isEmpty) return;
        final title = event.title;
        emit(state.copyWith(isLoading: true));
        await tasksUseCase.executeAdd(title: title, id: event.id);
        final tasks = await tasksUseCase.executeFetch();
        emit(state.copyWith(tasks: tasks, isLoading: false));
      }

      ///
      ///
      ///
      else if (event is RemoveTaskEvent) {
        emit(state.copyWith(isLoading: true));
        await tasksUseCase.executeDelete(event.id);
        final tasks = await tasksUseCase.executeFetch();
        emit(state.copyWith(tasks: tasks, isLoading: false));
      }

      ///
      ///
      ///
      else if (event is FetchTasksEvent) {
        emit(state.copyWith(isLoading: true));
        final tasks = await tasksUseCase.executeFetch();
        emit(state.copyWith(tasks: tasks, isLoading: false));
      }
    });
  }
}
