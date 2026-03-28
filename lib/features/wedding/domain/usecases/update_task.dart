import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) async {
    await repository.updateTask(task);
  }
}