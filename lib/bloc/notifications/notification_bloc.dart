import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/notification_model.dart';
import '../../repositories/notification_repository.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository,
        super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<UpdateNotification>(_onUpdateNotification);
    on<InitializeNotifications>(_onInitializeNotification);
  }

  final NotificationRepository _notificationRepository;
  StreamSubscription? _notificationSubscription;

  void _onInitializeNotification(
    InitializeNotifications event,
    Emitter<NotificationState> emit,
  ) {
    _notificationSubscription?.cancel();
    emit(NotificationInitial());
  }

  FutureOr<void> _onUpdateNotification(
    UpdateNotification event,
    Emitter<NotificationState> emit,
  ) {
    emit(NotificationLoaded(event.notificationList));
  }

  FutureOr<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) {
    _notificationSubscription?.cancel();

    try {
      _notificationSubscription = _notificationRepository
          .getNotifications(event.department)
          .listen((list) {
        add(UpdateNotification(list));
      });
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  @override
  void onTransition(
    Transition<NotificationEvent, NotificationState> transition,
  ) {
    super.onTransition(transition);
    dev.log(transition.toString(), name: "Notifications");
  }
}
