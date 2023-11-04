import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String description;
  final DateTime time;
  final String userId;
  final String department;
  final String complaintID;

  List<Object?> get props => [
        description,
        time,
        userId,
        department,
        complaintID,
      ];

  const NotificationModel({
    required this.description,
    required this.time,
    required this.userId,
    required this.department,
    required this.complaintID,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      description: map['description'],
      time: (map['timeStamp'] as Timestamp).toDate(),
      userId: map['userId'],
      department: map['departmentName'],
      complaintID: map['complaintID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'timeStamp': time,
      'userId': userId,
      'departmentName': department,
      'complaintID': complaintID,
    };
  }

  NotificationModel copyWith({
    String? description,
    DateTime? time,
    String? userId,
    String? department,
    String? complaintID,
  }) {
    return NotificationModel(
      description: description ?? this.description,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      department: department ?? this.department,
      complaintID: complaintID ?? this.complaintID,
    );
  }

  @override
  String toString() {
    return 'NotificationModel{description: $description, time: $time, userId: $userId, department: $department, complaintID: $complaintID}';
  }
}
