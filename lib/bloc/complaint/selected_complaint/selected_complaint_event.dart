part of 'selected_complaint_bloc.dart';

abstract class SelectedComplaintEvent extends Equatable {
  const SelectedComplaintEvent();

  @override
  List<Object?> get props => [];
}

class InitializeSelectedComplaint extends SelectedComplaintEvent {}

class LoadSelectedComplaint extends SelectedComplaintEvent {
  const LoadSelectedComplaint(this.id);

  final String id;
}

class UpdateSelectedComplaint extends SelectedComplaintEvent {
  const UpdateSelectedComplaint(this.complaint);

  final ComplaintModel complaint;
}

class TakeComplaint extends SelectedComplaintEvent {
  const TakeComplaint({
    required this.assignedEmployeeId,
    required this.complaint,
    required this.stats,
  });

  final String assignedEmployeeId;
  final ComplaintModel complaint;
  final ComplaintStatsModel stats;
}

class HoldComplaint extends SelectedComplaintEvent {
  const HoldComplaint({required this.complaint, required this.stats});

  final ComplaintModel complaint;
  final ComplaintStatsModel stats;
}

class ResumeComplaint extends SelectedComplaintEvent {
  const ResumeComplaint({required this.complaint, required this.stats});

  final ComplaintModel complaint;
  final ComplaintStatsModel stats;
}

class AddRemarks extends SelectedComplaintEvent {
  const AddRemarks({required this.complaintId, required this.remarks});

  final String complaintId;
  final String remarks;
}

class RequestApproval extends SelectedComplaintEvent {
  const RequestApproval({required this.complaint, required this.stats});

  final ComplaintModel complaint;
  final ComplaintStatsModel stats;
}
