import '../../data/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask({required String title, String? id});
  Future<void> deleteTask(String id);
}
