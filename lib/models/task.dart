class Task {
  String title;
  String subject;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.title,
    required this.subject,
    required this.dueDate,
    this.isCompleted = false,
  });
}