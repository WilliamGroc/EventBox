// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injection_container.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
