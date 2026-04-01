import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/song.dart';

class MusicPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  // Méthode pour lire un fichier local (depuis le stockage de l'appareil)
  Future<void> playFromFile(Song song) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = "${directory.path}/${song.fileName}";

      await _audioPlayer.stop();
      await _audioPlayer.play(DeviceFileSource(filePath));
      _isPlaying = true;
    } catch (e) {
      throw Exception("Erreur lors de la lecture: $e");
    }
  }

  // Méthode pour mettre en pause
  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  // Méthode pour reprendre la lecture
  Future<void> resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
  }

  // Méthode pour arrêter la lecture
  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }

  // Méthode pour libérer les ressources
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }

  // Méthode pour obtenir l'état de lecture
  bool get isPlaying => _isPlaying;
}
