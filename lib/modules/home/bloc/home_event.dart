part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends HomeEvent {
  final LaunchFilter? filter;
  const LoadEvent({this.filter});

  @override
  List<Object?> get props => [filter];
}

class LoadMoreEvent extends HomeEvent {
  final LaunchFilter? filter;
  const LoadMoreEvent({this.filter});

  @override
  List<Object?> get props => [filter];
}

class ResetSearchEvent extends HomeEvent {
  const ResetSearchEvent();

  @override
  List<Object?> get props => [];
}
