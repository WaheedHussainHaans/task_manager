import 'package:task_management/features/tasks/data/models/task.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repositories/task_repository.dart';

class MemoryTaskRepository implements TaskRepository {
  final List<Task> tasks = [];
  @override
  Future<void> addTask({required String title, String? id}) async {
    tasks.add(Task(id: id ?? const Uuid().v4(), title: title));
  }

  @override
  Future<void> deleteTask(String id) async {
    tasks.removeWhere((element) => element.id == id);
  }

  @override
  Future<List<Task>> getTasks() async {
    return tasks;
  }
}
