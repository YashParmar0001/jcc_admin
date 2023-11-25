import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/complaint_model.dart';
import '../../../repositories/complaint_repository.dart';

part 'recent_complaints_event.dart';

part 'recent_complaints_state.dart';

class RecentComplaintsBloc
    extends Bloc<RecentComplaintsEvent, RecentComplaintsState> {
  RecentComplaintsBloc({required ComplaintRepository complaintRepository})
      : _complaintRepository = complaintRepository,
        super(RecentComplaintsInitial()) {
    on<InitializeRecentComplaints>(_onInitializeRecentComplaints);
    on<LoadRecentComplaints>(_onLoadRecentComplaints);
    on<UpdateRecentComplaints>(_onUpdateRecentComplaints);
  }

  final ComplaintRepository _complaintRepository;
  StreamSubscription? _recentComplaintsSubscription;

  void _onInitializeRecentComplaints(
    InitializeRecentComplaints event,
    Emitter<RecentComplaintsState> emit,
  ) {
    _recentComplaintsSubscription?.cancel();
    emit(RecentComplaintsInitial());
  }

  void _onLoadRecentComplaints(
    LoadRecentComplaints event,
    Emitter<RecentComplaintsState> emit,
  ) {
    emit(RecentComplaintsLoading());
    _recentComplaintsSubscription?.cancel();

    try {
      _recentComplaintsSubscription =
          _complaintRepository.getRecentComplaints().listen((list) {
        add(UpdateRecentComplaints(list));
      });
    } catch (e) {
      emit(RecentComplaintsError(e.toString()));
    }
  }

  void _onUpdateRecentComplaints(
    UpdateRecentComplaints event,
    Emitter<RecentComplaintsState> emit,
  ) {
    emit(RecentComplaintsLoaded(event.complaints));
  }

  @override
  void onTransition(Transition<RecentComplaintsEvent, RecentComplaintsState> transition) {
    dev.log(transition.toString(), name: 'RecentComplaints');
    super.onTransition(transition);
  }
}
