import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'tasks': tasks.map((x) => x.toMap()).toList(),
      'isLoading': isLoading,
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      tasks: List<Task>.from(map['tasks']?.map((x) => Task.fromMap(x))),
      isLoading: map['isLoading'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksState.fromJson(String source) =>
      TasksState.fromMap(json.decode(source));

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
