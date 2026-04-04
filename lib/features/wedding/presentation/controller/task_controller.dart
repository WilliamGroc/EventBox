import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';
import 'package:wedding_witness_app/injection_container.dart';

part 'task_controller.g.dart';

@riverpod
class TaskController extends _$TaskController {
  StreamSubscription<List<Task>>? _subscription;

  @override
  Future<List<Task>> build() async {
    final wsDatasource = ref.read(taskWsDatasourceProvider);

    // Compléter dès la réception du premier message WebSocket (état initial)
    final completer = Completer<List<Task>>();

    _subscription?.cancel();
    _subscription = wsDatasource.taskUpdates.listen((tasks) {
      if (!completer.isCompleted) {
        completer.complete(tasks);
        // Programmer les notifications pour les tâches reçues
        ref.read(notificationServiceProvider).scheduleNotificationsForTasks(tasks);
      } else {
        state = AsyncValue.data(tasks);
        ref.read(notificationServiceProvider).scheduleNotificationsForTasks(tasks);
      }
    }, onError: (e) {
      if (!completer.isCompleted) completer.completeError(e);
    });

    ref.onDispose(() => _subscription?.cancel());

    return completer.future;
  }

  Future<void> toggleTaskCompletion(Task task) async {
    // Mise à jour optimiste
    if (state case AsyncData(:final value)) {
      final optimistic = value
          .map((t) => t.id == task.id
              ? Task(
                  id: t.id,
                  title: t.title,
                  description: t.description,
                  startTime: t.startTime,
                  isCompleted: !t.isCompleted,
                )
              : t)
          .toList();
      state = AsyncValue.data(optimistic);
    }
    await ref.read(updateTaskProvider)(
      Task(id: task.id, title: task.title, isCompleted: !task.isCompleted),
    );
    // Le serveur va broadcaster via WebSocket → état se mettra à jour automatiquement
  }
}
