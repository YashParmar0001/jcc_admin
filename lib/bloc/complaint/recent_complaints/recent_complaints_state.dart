part of 'recent_complaints_bloc.dart';

abstract class RecentComplaintsState extends Equatable {
  const RecentComplaintsState();

  @override
  List<Object> get props => [];
}

class RecentComplaintsInitial extends RecentComplaintsState {

}

class RecentComplaintsLoading extends RecentComplaintsState {}

class RecentComplaintsLoaded extends RecentComplaintsState {
  const RecentComplaintsLoaded(this.complaints);

  final List<ComplaintModel> complaints;

  @override
  List<Object> get props => [complaints];
}

class RecentComplaintsError extends RecentComplaintsState {
  const RecentComplaintsError(this.message);

  final String message;
}
