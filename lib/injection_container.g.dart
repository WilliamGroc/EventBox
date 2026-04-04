// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injection_container.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationService)
final notificationServiceProvider = NotificationServiceProvider._();

final class NotificationServiceProvider
    extends
        $FunctionalProvider<
          NotificationService,
          NotificationService,
          NotificationService
        >
    with $Provider<NotificationService> {
  NotificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationService create(Ref ref) {
    return notificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationService>(value),
    );
  }
}

String _$notificationServiceHash() =>
    r'585c1e42ea844e71a2b76b80b165adfe2c5c8529';

@ProviderFor(taskWsDatasource)
final taskWsDatasourceProvider = TaskWsDatasourceProvider._();

final class TaskWsDatasourceProvider
    extends
        $FunctionalProvider<
          TaskWsDatasource,
          TaskWsDatasource,
          TaskWsDatasource
        >
    with $Provider<TaskWsDatasource> {
  TaskWsDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskWsDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskWsDatasourceHash();

  @$internal
  @override
  $ProviderElement<TaskWsDatasource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskWsDatasource create(Ref ref) {
    return taskWsDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskWsDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskWsDatasource>(value),
    );
  }
}

String _$taskWsDatasourceHash() => r'35985ce615f3dba4cba06bf68a0571d1a2a5e130';

@ProviderFor(chatDatasource)
final chatDatasourceProvider = ChatDatasourceProvider._();

final class ChatDatasourceProvider
    extends $FunctionalProvider<ChatDatasource, ChatDatasource, ChatDatasource>
    with $Provider<ChatDatasource> {
  ChatDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatDatasourceHash();

  @$internal
  @override
  $ProviderElement<ChatDatasource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChatDatasource create(Ref ref) {
    return chatDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatDatasource>(value),
    );
  }
}

String _$chatDatasourceHash() => r'daa3d9cf55fb73eb9578eb31d0f77217e917b6b1';

@ProviderFor(taskLocalDataSource)
final taskLocalDataSourceProvider = TaskLocalDataSourceProvider._();

final class TaskLocalDataSourceProvider
    extends
        $FunctionalProvider<
          TaskLocalDataSource,
          TaskLocalDataSource,
          TaskLocalDataSource
        >
    with $Provider<TaskLocalDataSource> {
  TaskLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<TaskLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TaskLocalDataSource create(Ref ref) {
    return taskLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskLocalDataSource>(value),
    );
  }
}

String _$taskLocalDataSourceHash() =>
    r'79d2947f3b1c1d4142808a56d16233be01198455';

@ProviderFor(songLocalDataSource)
final songLocalDataSourceProvider = SongLocalDataSourceProvider._();

final class SongLocalDataSourceProvider
    extends $FunctionalProvider<SongDataSource, SongDataSource, SongDataSource>
    with $Provider<SongDataSource> {
  SongLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'songLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$songLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<SongDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SongDataSource create(Ref ref) {
    return songLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SongDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SongDataSource>(value),
    );
  }
}

String _$songLocalDataSourceHash() =>
    r'a19160eea8562d2b82038cf667301d0839982703';

@ProviderFor(taskRepository)
final taskRepositoryProvider = TaskRepositoryProvider._();

final class TaskRepositoryProvider
    extends $FunctionalProvider<TaskRepository, TaskRepository, TaskRepository>
    with $Provider<TaskRepository> {
  TaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskRepositoryHash();

  @$internal
  @override
  $ProviderElement<TaskRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskRepository create(Ref ref) {
    return taskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskRepository>(value),
    );
  }
}

String _$taskRepositoryHash() => r'd2c2fcf4aafea4bc006fc5fbf8c4dc2d0115bcbc';

@ProviderFor(songRepository)
final songRepositoryProvider = SongRepositoryProvider._();

final class SongRepositoryProvider
    extends $FunctionalProvider<SongRepository, SongRepository, SongRepository>
    with $Provider<SongRepository> {
  SongRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'songRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$songRepositoryHash();

  @$internal
  @override
  $ProviderElement<SongRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SongRepository create(Ref ref) {
    return songRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SongRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SongRepository>(value),
    );
  }
}

String _$songRepositoryHash() => r'57760c3b81f2ec3c2005db3a98f85e35017b4226';

@ProviderFor(chatRepository)
final chatRepositoryProvider = ChatRepositoryProvider._();

final class ChatRepositoryProvider
    extends $FunctionalProvider<ChatRepository, ChatRepository, ChatRepository>
    with $Provider<ChatRepository> {
  ChatRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChatRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChatRepository create(Ref ref) {
    return chatRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatRepository>(value),
    );
  }
}

String _$chatRepositoryHash() => r'090898082ec9b6159c307ada86f32005bf71ccbd';

@ProviderFor(getTasks)
final getTasksProvider = GetTasksProvider._();

final class GetTasksProvider
    extends $FunctionalProvider<GetTasks, GetTasks, GetTasks>
    with $Provider<GetTasks> {
  GetTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTasksHash();

  @$internal
  @override
  $ProviderElement<GetTasks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTasks create(Ref ref) {
    return getTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTasks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTasks>(value),
    );
  }
}

String _$getTasksHash() => r'8eb3b2150709b30715b9c2a5be8d32c0c60282c4';

@ProviderFor(updateTask)
final updateTaskProvider = UpdateTaskProvider._();

final class UpdateTaskProvider
    extends $FunctionalProvider<UpdateTask, UpdateTask, UpdateTask>
    with $Provider<UpdateTask> {
  UpdateTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTaskHash();

  @$internal
  @override
  $ProviderElement<UpdateTask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateTask create(Ref ref) {
    return updateTask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateTask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateTask>(value),
    );
  }
}

String _$updateTaskHash() => r'b3a70db759946aa0efd50ff85756c2db8f066f1d';

@ProviderFor(getSong)
final getSongProvider = GetSongProvider._();

final class GetSongProvider
    extends $FunctionalProvider<GetSongs, GetSongs, GetSongs>
    with $Provider<GetSongs> {
  GetSongProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSongProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSongHash();

  @$internal
  @override
  $ProviderElement<GetSongs> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetSongs create(Ref ref) {
    return getSong(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSongs value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSongs>(value),
    );
  }
}

String _$getSongHash() => r'c7e26544425edcda6ca1f6a9dbdaecfc9cfe8288';

@ProviderFor(getChatMessages)
final getChatMessagesProvider = GetChatMessagesProvider._();

final class GetChatMessagesProvider
    extends
        $FunctionalProvider<GetChatMessages, GetChatMessages, GetChatMessages>
    with $Provider<GetChatMessages> {
  GetChatMessagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getChatMessagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getChatMessagesHash();

  @$internal
  @override
  $ProviderElement<GetChatMessages> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetChatMessages create(Ref ref) {
    return getChatMessages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetChatMessages value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetChatMessages>(value),
    );
  }
}

String _$getChatMessagesHash() => r'cb23188153c1b09eec04143ebef774ec61318a9e';
