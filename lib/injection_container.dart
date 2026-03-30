import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wedding_witness_app/features/wedding/data/datasources/http.config.dart';
import 'package:wedding_witness_app/features/wedding/data/datasources/task_local_datasource.dart';
import 'package:wedding_witness_app/features/wedding/data/repositories/task_repositories_impl.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/task_repository.dart';
import 'package:wedding_witness_app/features/wedding/domain/usecases/get_tasks.dart';
import 'package:wedding_witness_app/features/wedding/domain/usecases/update_task.dart';

part 'injection_container.g.dart';

// Data Sources
@riverpod
TaskLocalDataSource taskLocalDataSource(Ref ref) {
  return TaskLocalDataSourceImpl(
    dio: ref.watch(dioProvider),
  );
}

// Repositories
@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(
    localDataSource: ref.watch(taskLocalDataSourceProvider),
  );
}

// Use Cases
@riverpod
GetTasks getTasks(Ref ref) {
  return GetTasks(ref.watch(taskRepositoryProvider));
}

@riverpod
UpdateTask updateTask(Ref ref) {
  return UpdateTask(ref.watch(taskRepositoryProvider));
}
