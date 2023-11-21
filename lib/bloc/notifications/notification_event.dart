part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class InitializeNotifications extends NotificationEvent {

}

class LoadNotifications extends NotificationEvent {
  const LoadNotifications(this.department);

  final String department;
}

class UpdateNotification extends NotificationEvent {
  const UpdateNotification(this.notificationList);

  final List<NotificationModel> notificationList;
}

