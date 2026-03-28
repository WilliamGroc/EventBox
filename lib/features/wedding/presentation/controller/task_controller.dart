import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';
import 'package:wedding_witness_app/injection_container.dart';

part 'task_controller.g.dart';

@riverpod
class TaskController extends _$TaskController {
  @override
  Future<List<Task>> build() async {
    final tasks = await ref.watch(getTasksProvider)();
    return tasks;
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      isCompleted: !task.isCompleted,
    );
    await ref.read(updateTaskProvider)(updatedTask);
    state = await AsyncValue.guard(() => ref.read(getTasksProvider)());
  }
}
