import 'package:wedding_witness_app/features/wedding/data/datasources/task_local_datasource.dart';
import 'package:wedding_witness_app/features/wedding/data/models/task_model.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Task>> getTasks() async {
    return localDataSource.getTasks();
  }

  @override
  Future<void> updateTask(Task task) async {
    await localDataSource.updateTask(
      TaskModel(id: task.id, isCompleted: task.isCompleted),
    );
  }
}
