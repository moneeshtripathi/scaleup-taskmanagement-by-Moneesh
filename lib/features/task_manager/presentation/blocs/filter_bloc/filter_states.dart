part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilterInitialState extends FilterState {}

class FilterCompletedState extends FilterState {
  final bool isCompletedShown;

  FilterCompletedState(this.isCompletedShown);

  @override
  List<Object> get props => [isCompletedShown];
}
