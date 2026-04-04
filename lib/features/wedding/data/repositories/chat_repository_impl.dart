import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wedding_witness_app/features/wedding/data/models/chat_message_model.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/chat_message.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final Dio dio;
  ChatRepositoryImpl({required this.dio});

  @override
  Future<List<ChatMessage>> getRecentMessages() async {
    try {
      final response = await dio.get('chat/messages');
      if (response.statusCode == 200) {
        final dynamic rawData = response.data;
        final List<dynamic> data = rawData is String
            ? json.decode(rawData) as List<dynamic>
            : rawData is List<dynamic>
                ? rawData
                : [];
        return data
            .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }
}
