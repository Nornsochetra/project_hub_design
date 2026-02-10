enum StatusProject { pending, active, completed }

StatusProject statusProjectFromApi(String s) {
  switch (s.toLowerCase().trim()) {
    case 'pending':
      return StatusProject.pending;
    case 'active':
      return StatusProject.active;
    case 'completed':
      return StatusProject.completed;
    default:
      return StatusProject.pending;
  }
}

String statusToApi(StatusProject status) => status.name;

String statusToText(StatusProject status) {
  switch (status) {
    case StatusProject.pending:
      return 'Pending';
    case StatusProject.active:
      return 'Active';
    case StatusProject.completed:
      return 'Completed';
  }
}

class Project {
  final String id;
  final String title;
  final DateTime dateTime;
  final double progress; // keep as 0.0 - 1.0
  final StatusProject status;

  Project({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.progress,
    required this.status,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    final dateStr = (json['date'] ?? '').toString(); // e.g. "2026-10-07"
    final progressPercent = (json['progress'] as num).toDouble(); // 0-100

    return Project(
      id: json['id'].toString(),
      title: (json['title'] ?? '').toString(),
      dateTime: DateTime.parse(dateStr), // parse ISO date
      progress: (progressPercent / 100).clamp(0.0, 1.0),
      status: statusProjectFromApi((json['status'] ?? '').toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': dateTime.toIso8601String().split('T').first, //  "2026-10-07"
      'progress': progress * 100,                          //  back to 0-100
      'status': statusToApi(status),
    };
  }
}
