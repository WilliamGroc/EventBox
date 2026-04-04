class Song {
  final int id;
  final String title;
  final String fileName;
  final String moment;

  Song({
    required this.id,
    required this.title,
    required this.fileName,
    this.moment = '',
  });
}