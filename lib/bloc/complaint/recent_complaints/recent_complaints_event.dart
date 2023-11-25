part of 'recent_complaints_bloc.dart';

abstract class RecentComplaintsEvent extends Equatable {
  const RecentComplaintsEvent();

  @override
  List<Object?> get props => [];
}

class InitializeRecentComplaints extends RecentComplaintsEvent {

}

class LoadRecentComplaints extends RecentComplaintsEvent {

}

class UpdateRecentComplaints extends RecentComplaintsEvent {
  const UpdateRecentComplaints(this.complaints);

  final List<ComplaintModel> complaints;
}
