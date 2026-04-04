import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wedding_witness_app/features/wedding/data/datasources/chat_datasource.dart';
import 'package:wedding_witness_app/features/wedding/data/datasources/http.config.dart';
import 'package:wedding_witness_app/features/wedding/data/datasources/song_datasource.dart';
import 'package:wedding_witness_app/features/wedding/data/datasources/task_local_datasource.dart';
import 'package:wedding_witness_app/features/wedding/data/datasources/task_ws_datasource.dart';
import 'package:wedding_witness_app/features/wedding/data/repositories/chat_repository_impl.dart';
import 'package:wedding_witness_app/features/wedding/data/repositories/song_repositories_impl.dart';
import 'package:wedding_witness_app/features/wedding/data/repositories/task_repositories_impl.dart';
import 'package:wedding_witness_app/features/wedding/device/notification_service.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/chat_repository.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/song_repository.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/task_repository.dart';
import 'package:wedding_witness_app/features/wedding/domain/usecases/get_chat_messages.dart';
import 'package:wedding_witness_app/features/wedding/domain/usecases/get_songs.dart';
import 'package:wedding_witness_app/features/wedding/domain/usecases/get_tasks.dart';
import 'package:wedding_witness_app/features/wedding/domain/usecases/update_task.dart';

part 'injection_container.g.dart';

// ──────────────────────────────────────────────
// Configuration réseau
// ──────────────────────────────────────────────

// URL WebSocket : 10.0.2.2 pour l'émulateur Android, localhost pour le web
const String _wsBase = 'ws://10.0.2.2:3000/';

// ──────────────────────────────────────────────
// Services & WebSocket datasources (persistants)
// ──────────────────────────────────────────────

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) => NotificationService();

@Riverpod(keepAlive: true)
TaskWsDatasource taskWsDatasource(Ref ref) {
  final ds = TaskWsDatasourceImpl('${_wsBase}ws/tasks');
  ref.onDispose(ds.dispose);
  return ds;
}

@Riverpod(keepAlive: true)
ChatDatasource chatDatasource(Ref ref) {
  final ds = ChatDatasourceImpl('${_wsBase}chat/ws');
  ref.onDispose(ds.dispose);
  return ds;
}

// ──────────────────────────────────────────────
// Data Sources HTTP
// ──────────────────────────────────────────────

@riverpod
TaskLocalDataSource taskLocalDataSource(Ref ref) {
  return TaskLocalDataSourceImpl(
    dio: ref.watch(dioProvider),
  );
}

@riverpod
SongDataSource songLocalDataSource(Ref ref) {
  return SongDataSourceImpl(
    dio: ref.watch(dioProvider),
  );
}

// ──────────────────────────────────────────────
// Repositories
// ──────────────────────────────────────────────

@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(
    localDataSource: ref.watch(taskLocalDataSourceProvider),
  );
}

@riverpod
SongRepository songRepository(Ref ref) {
  return SongRepositoriesImpl(
    localDataSource: ref.watch(songLocalDataSourceProvider),
  );
}

@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepositoryImpl(dio: ref.watch(dioProvider));
}

// ──────────────────────────────────────────────
// Use Cases
// ──────────────────────────────────────────────

@riverpod
GetTasks getTasks(Ref ref) {
  return GetTasks(ref.watch(taskRepositoryProvider));
}

@riverpod
UpdateTask updateTask(Ref ref) {
  return UpdateTask(ref.watch(taskRepositoryProvider));
}

@riverpod
GetSongs getSong(Ref ref) {
  return GetSongs(ref.watch(songRepositoryProvider));
}

@riverpod
GetChatMessages getChatMessages(Ref ref) {
  return GetChatMessages(ref.watch(chatRepositoryProvider));
}
