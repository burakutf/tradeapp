class NotificationModel {
  final int id;
  final int? sendType;
  final String? title;
  final String? text;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.sendType,
    this.title,
    this.text,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      sendType: json['send_type'],
      title: json['title'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
