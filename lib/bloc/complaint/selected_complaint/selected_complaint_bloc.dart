import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc_admin/model/notification_model.dart';
import 'package:jcc_admin/repositories/complaint_repository.dart';
import 'package:jcc_admin/repositories/notification_repository.dart';

import '../../../model/complaint_model.dart';

part 'selected_complaint_event.dart';

part 'selected_complaint_state.dart';

class SelectedComplaintBloc
    extends Bloc<SelectedComplaintEvent, SelectedComplaintState> {
  SelectedComplaintBloc({
    required ComplaintRepository complaintRepository,
    required NotificationRepository notificationRepository,
  })  : _complaintRepository = complaintRepository,
        _notificationRepository = notificationRepository,
        super(SelectedComplaintInitial()) {
    on<LoadSelectedComplaint>(_onLoadSelectedComplaint);
    on<UpdateSelectedComplaint>(_onUpdateSelectedComplaint);
    on<TakeComplaint>(_onTakeComplaint);
    on<HoldComplaint>(_onHoldComplaint);
    on<SolveComplaint>(_onSolveComplaint);
    on<RequestApproval>(_onRequestApproval);
  }

  final ComplaintRepository _complaintRepository;
  final NotificationRepository _notificationRepository;
  StreamSubscription? _selectedComplaintSubscription;

  void _onLoadSelectedComplaint(
    LoadSelectedComplaint event,
    Emitter<SelectedComplaintState> emit,
  ) {
    emit(SelectedComplaintLoading());
    _selectedComplaintSubscription?.cancel();
    try {
      _selectedComplaintSubscription = _complaintRepository
          .getSelectedComplaint(event.id)
          .listen((complaint) {
        if (complaint == null) {
          emit(const SelectedComplaintError('Not found'));
        } else {
          add(UpdateSelectedComplaint(complaint));
        }
      });
    } catch (e) {
      emit(SelectedComplaintError(e.toString()));
    }
  }

  void _onUpdateSelectedComplaint(
    UpdateSelectedComplaint event,
    Emitter<SelectedComplaintState> emit,
  ) {
    emit(SelectedComplaintLoaded(event.complaint));
  }

  Future<void> _onHoldComplaint(
    HoldComplaint event,
    Emitter<SelectedComplaintState> emit,
  ) async {
    final time = DateTime.now();
    final complaint = event.complaint;

    final updatedTrackData = complaint.trackData
      ..add(
        TimeLine(
          date: time.toString(),
          status: 'On Hold',
        ),
      );

    final updateData = {
      'status': 'On Hold',
      'trackData': updatedTrackData.map((e) => e.toMap()),
    };

    await _complaintRepository.updateComplaintToTaken(complaint.id, updateData);
  }

  Future<void> _onRequestApproval(
    RequestApproval event,
    Emitter<SelectedComplaintState> emit,
  ) async {
    final time = DateTime.now();
    final complaint = event.complaint;

    final updatedTrackData = complaint.trackData
      ..add(
        TimeLine(
          date: time.toString(),
          status: 'Approval Pending',
        ),
      );

    final updateData = {
      'status': 'Approval Pending',
      'trackData': updatedTrackData.map((e) => e.toMap()),
    };

    await _complaintRepository.updateComplaintToTaken(complaint.id, updateData);
  }

  Future<void> _onSolveComplaint(
    SolveComplaint event,
    Emitter<SelectedComplaintState> emit,
  ) async {
    final time = DateTime.now();
    final complaint = event.complaint;

    final updatedTrackData = complaint.trackData
      ..add(
        TimeLine(
          date: time.toString(),
          status: 'Solved',
        ),
      );

    final updateData = {
      'status': 'Solved',
      'trackData': updatedTrackData.map((e) => e.toMap()),
    };

    await _complaintRepository.updateComplaintToTaken(complaint.id, updateData);
  }

  Future<void> _onTakeComplaint(
    TakeComplaint event,
    Emitter<SelectedComplaintState> emit,
  ) async {
    final time = DateTime.now();
    final complaint = event.complaint;

    final updatedTrackData = complaint.trackData
      ..add(
        TimeLine(
          date: time.toString(),
          status: 'In Process',
        ),
      );

    final updateData = {
      'status': 'In Process',
      'assignedId': event.assignedEmployeeId,
      'isAssigned': true,
      'trackData': updatedTrackData.map((e) => e.toMap()),
    };

    await _complaintRepository.updateComplaintToTaken(complaint.id, updateData);

    final notification = NotificationModel(
      description: 'Your complaint has been taken',
      timeStamp: time,
      userId: complaint.userId,
      departmentName: complaint.departmentName,
      complaintId: complaint.id,
    );

    await _notificationRepository.addNotification(notification);

    await _notificationRepository.sendPushNotification(notification.description, notification.departmentName, [notification.userId]);
  }
}
