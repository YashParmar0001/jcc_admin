part of 'selected_complaint_bloc.dart';

abstract class SelectedComplaintEvent extends Equatable {
  const SelectedComplaintEvent();

  @override
  List<Object?> get props => [];
}

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
  });

  final String assignedEmployeeId;
  final ComplaintModel complaint;
}