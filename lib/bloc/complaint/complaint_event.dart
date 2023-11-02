part of 'complaint_bloc.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object?> get props => [];
}

class InitializeComplaint extends ComplaintEvent {}

class LoadComplaint extends ComplaintEvent {
  const LoadComplaint({required this.department, required this.ward});

  final String department;
  final String ward;
}

class UpdateComplaint extends ComplaintEvent {
  const UpdateComplaint(this.complaintList);

  final List<ComplaintModel> complaintList;
}
