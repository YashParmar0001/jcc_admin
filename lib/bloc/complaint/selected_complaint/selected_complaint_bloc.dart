import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc_admin/model/complaint_stats_model.dart';
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
    on<InitializeSelectedComplaint>(_onInitializeSelectedComplaint);
    on<LoadSelectedComplaint>(_onLoadSelectedComplaint);
    on<UpdateSelectedComplaint>(_onUpdateSelectedComplaint);
    on<TakeComplaint>(_onTakeComplaint);
    on<HoldComplaint>(_onHoldComplaint);
    on<ResumeComplaint>(_onResumeComplaint);
    on<RequestApproval>(_onRequestApproval);
    on<AddRemarks>(_onAddRemarks);
  }

  final ComplaintRepository _complaintRepository;
  final NotificationRepository _notificationRepository;
  StreamSubscription? _selectedComplaintSubscription;

  void _onInitializeSelectedComplaint(
    InitializeSelectedComplaint event,
    Emitter<SelectedComplaintState> emit,
  ) {
    _selectedComplaintSubscription?.cancel();
    emit(SelectedComplaintInitial());
  }

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

    await _complaintRepository.updateComplaint(complaint.id, updateData);
    await _complaintRepository.updateComplaintStats({
      'in_process': (event.stats.inProcess - 1).toString(),
      'on_hold': (event.stats.onHold + 1).toString(),
    });

    final notification = NotificationModel(
      description:
          'Your complaint has been put on hold: Complaint no. ${complaint.id}',
      timeStamp: time,
      userId: complaint.userId,
      departmentName: complaint.departmentName,
      complaintId: complaint.id,
      ward: complaint.ward,
    );

    await _notificationRepository.addNotification(notification);

    await _notificationRepository.sendPushNotification(
      notification.description,
      notification.departmentName,
      [notification.userId],
    );
  }

  Future<void> _onResumeComplaint(
    ResumeComplaint event,
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
      'trackData': updatedTrackData.map((e) => e.toMap()),
    };

    await _complaintRepository.updateComplaint(complaint.id, updateData);
    await _complaintRepository.updateComplaintStats({
      'on_hold': (event.stats.onHold - 1).toString(),
      'in_process': (event.stats.inProcess + 1).toString(),
    });

    final notification = NotificationModel(
      description:
          'Work on your complaint has been resumed: Complaint no. ${complaint.id}',
      timeStamp: time,
      userId: complaint.userId,
      departmentName: complaint.departmentName,
      complaintId: complaint.id,
      ward: complaint.ward,
    );

    await _notificationRepository.addNotification(notification);

    await _notificationRepository.sendPushNotification(
      notification.description,
      notification.departmentName,
      [notification.userId],
    );
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

    final response = await _complaintRepository.uploadFiles(
      complaint.id,
      event.images,
    );

    final updateData = {
      'status': 'Approval Pending',
      'isLocked': true,
      'verifiedImageUrls' : response,
      'trackData': updatedTrackData.map((e) => e.toMap()),
    };

    await _complaintRepository.updateComplaint(complaint.id, updateData);

    final notification = NotificationModel(
      description:
          'Your approval is requested to mark complaint as Solved: Complaint no. ${complaint.id}',
      timeStamp: time,
      userId: complaint.userId,
      departmentName: complaint.departmentName,
      complaintId: complaint.id,
      ward: complaint.ward,
    );

    await _notificationRepository.addNotification(notification);

    await _notificationRepository.sendPushNotification(
      notification.description,
      notification.departmentName,
      [notification.userId],
    );
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

    await _complaintRepository.updateComplaint(complaint.id, updateData);
    await _complaintRepository.updateComplaintStats({
      'registered': (event.stats.registered - 1).toString(),
      'in_process': (event.stats.inProcess + 1).toString(),
    });

    final notification = NotificationModel(
      description:
          'Your complaint has been taken: Complaint no. ${complaint.id}',
      timeStamp: time,
      userId: complaint.userId,
      departmentName: complaint.departmentName,
      complaintId: complaint.id,
      ward: complaint.ward,
    );

    await _notificationRepository.addNotification(notification);

    await _notificationRepository.sendPushNotification(
      notification.description,
      notification.departmentName,
      [notification.userId],
    );
  }

  Future<void> _onAddRemarks(
    AddRemarks event,
    Emitter<SelectedComplaintState> emit,
  ) async {
    await _complaintRepository.updateComplaint(event.complaintId, {
      'remarks': event.remarks,
    });
  }

  @override
  void onTransition(
      Transition<SelectedComplaintEvent, SelectedComplaintState> transition) {
    dev.log(transition.toString(), name: 'SelectedComplaint');
    super.onTransition(transition);
  }
}
