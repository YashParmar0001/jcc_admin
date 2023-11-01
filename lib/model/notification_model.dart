class NotificationModel {
  final String title;
  final String description;
  final String time;
  final String userId;
  final String department;
  final String complaintID;

  List<Object?> get props => [
        title,
        description,
        time,
        userId,
        department,
        complaintID,
      ];

  const NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    required this.userId,
    required this.department,
    required this.complaintID,
  });

  factory NotificationModel.toMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'],
      description: map['description'],
      time: map['time'],
      userId: map['userId'],
      department: map['department'],
      complaintID: map['complaintID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'time': time,
      'userId': userId,
      'department': department,
      'complaintID': complaintID,
    };
  }

  NotificationModel copyWith({
    String? title,
    String? description,
    String? time,
    String? userId,
    String? department,
    String? complaintID,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      department: department ?? this.department,
      complaintID: complaintID ?? this.complaintID,
    );
  }

  @override
  String toString() {
    return 'NotificationModel{title: $title, description: $description, time: $time, userId: $userId, department: $department, complaintID: $complaintID}';
  }
}
