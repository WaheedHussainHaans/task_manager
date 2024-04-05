import 'package:flutter/foundation.dart';

import '../../models/task.dart';

class TasksState {
  final List<Task> tasks;
  final bool isLoading;

  TasksState({
    required this.tasks,
    this.isLoading = false,
  });

  TasksState copyWith({
    List<Task>? tasks,
    bool? isLoading,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() => 'TasksState(tasks: $tasks, isLoading: $isLoading)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TasksState &&
        listEquals(other.tasks, tasks) &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode => tasks.hashCode ^ isLoading.hashCode;
}
