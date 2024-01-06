import 'package:equatable/equatable.dart';
import 'package:flutter_assignment_pranad/transporters/data/models/transproter.dart';
import 'package:flutter_assignment_pranad/utils/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../data/repo/transporter_repository.dart';

part 'transporters_event.dart';
part 'transporters_state.dart';

// BLoC
class TransportersBloc extends Bloc<TransportersEvent, TransportersState> {
  final TransporterRepository transporterRepository;

  TransportersBloc(this.transporterRepository) : super(TransportersInitial()) {
    on<SearchTransporters>(
      _onSearchTransporters,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }

  void _onSearchTransporters(
    SearchTransporters event,
    Emitter<TransportersState> emit,
  ) async {
    emit(TransportersLoading());

    try {
      final transporters =
          await transporterRepository.getTransporters(event.query);
      emit(TransportersLoaded(transporters));
    } on InternetFailure catch (e) {
      emit(TransportersError(e.message));
    } on DefaultFailure catch (e) {
      emit(TransportersError(e.message));
    }
  }
}
