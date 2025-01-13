part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleCompletedFilterEvent extends FilterEvent {
  final bool isCompletedShown;

  ToggleCompletedFilterEvent(this.isCompletedShown);

  @override
  List<Object> get props => [isCompletedShown];
}
