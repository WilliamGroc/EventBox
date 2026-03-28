import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> updateTask(Task task);
}
