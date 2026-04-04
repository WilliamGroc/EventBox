import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wedding_witness_app/features/wedding/data/models/task_model.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/task.dart';

abstract class TaskWsDatasource {
  Stream<List<Task>> get taskUpdates;
  void dispose();
}

class TaskWsDatasourceImpl implements TaskWsDatasource {
  late final WebSocketChannel _channel;
  final StreamController<List<Task>> _controller =
      StreamController<List<Task>>.broadcast();

  TaskWsDatasourceImpl(String wsUrl) {
    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
    _channel.stream.listen(
      (message) {
        try {
          final List<dynamic> data = jsonDecode(message as String) as List;
          final tasks = data
              .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
              .toList();
          _controller.add(tasks);
        } catch (_) {}
      },
      onError: (e) => _controller.addError(e),
      onDone: () => _controller.close(),
    );
  }

  @override
  Stream<List<Task>> get taskUpdates => _controller.stream;

  @override
  void dispose() {
    _channel.sink.close();
    if (!_controller.isClosed) _controller.close();
  }
}
