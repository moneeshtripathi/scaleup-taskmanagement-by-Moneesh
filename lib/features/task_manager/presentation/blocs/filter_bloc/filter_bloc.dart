import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'filter_events.dart';
part 'filter_states.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitialState()) {
    on<ToggleCompletedFilterEvent>((event, emit) {
      emit(FilterCompletedState(event.isCompletedShown));
    });
  }
}
