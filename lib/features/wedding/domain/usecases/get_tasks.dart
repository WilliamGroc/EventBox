import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return repository.getTasks();
  }
}
