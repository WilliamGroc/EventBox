import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';
import 'package:wedding_witness_app/injection_container.dart';

part 'song_controller.g.dart';

@riverpod
class SongController extends _$SongController {
  @override
  Future<List<Song>> build() async {
    final tasks = await ref.watch(getSongProvider)();
    return tasks;
  }

  Future<void> playAudio(Song song) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = "${directory.path}/${song.fileName}";
      final AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      throw Exception("Erreur lors de la lecture: $e");
    }
  }
}
