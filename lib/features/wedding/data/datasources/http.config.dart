import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http.config.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}
