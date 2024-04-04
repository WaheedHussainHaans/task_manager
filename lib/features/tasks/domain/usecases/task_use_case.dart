import 'package:flutter/foundation.dart';

import '../repositories/task_repository.dart';
import '../utils/typdef.dart';

class TaskUseCase {
  final TaskRepository taskRepository;

  TaskUseCase(this.taskRepository);

  Future<void> executeAdd({required String title, String? id}) async {
    debugPrint('TITLE :$title');
    await taskRepository.addTask(title: title, id: id);
  }

  Future<TaskList> executeFetch() async {
    return await taskRepository.getTasks();
  }

  Future<void> executeDelete(String id) async {
    await taskRepository.deleteTask(id);
  }
}
