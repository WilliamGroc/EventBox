class Task {
  final int id;
  final String? title;
  final String? description;
  final bool isCompleted;
  final String? startTime ;

  Task({
    required this.id,
    this.title,
    this.description,
    this.startTime,
    this.isCompleted = false,
  });
}