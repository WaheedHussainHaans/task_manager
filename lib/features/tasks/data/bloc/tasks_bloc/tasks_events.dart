class TasksEvent {}

final class InsertingTaskEvent extends TasksEvent {
  final String title;
  final String? id;
  InsertingTaskEvent({
    required this.title,
    this.id,
  });
}

final class RemoveTaskEvent extends TasksEvent {
  final String id;

  RemoveTaskEvent({required this.id});
}

final class FetchTasksEvent extends TasksEvent {}
