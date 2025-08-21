class Task {
  final String title;
  final String subject;
  final DateTime dueDate;
  bool isCompleted;

  Task({
    required this.title,
    required this.subject,
    required this.dueDate,
    this.isCompleted = false,
  });
}